//
//  LayoutView.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable

class LayoutView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    var subview = Subview()
    @IBOutlet weak var image1: Subview!
    @IBOutlet weak var image2: Subview!
    @IBOutlet weak var image3: Subview!
    @IBOutlet weak var image4: Subview!
    var delegate: communicationView?
   
  

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
    enum Layout {
        case layout1, layout2, layout3
    }
    
    var layout: Layout = .layout2 {
        didSet {
            setLayout(layout)
        }
    }
    
    
    
    private func setLayout(_ layout: Layout) {
        let layoutWidth = self.bounds.width - 8
        let layoutHeight = self.bounds.height - 8
        switch layout {
        case .layout1:
            image1.frame = CGRect(x: 4, y: 4, width: layoutWidth, height: layoutHeight / 2)
            image2.frame = CGRect(x: self.bounds.width / 2, y: 4, width: 0, height: 0)
            image3.frame = CGRect(x: 4, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
            image4.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
        case .layout2:
            image1.frame = CGRect(x: 4, y: 4, width: layoutWidth / 2, height: layoutHeight / 2)
            image2.frame = CGRect(x: self.bounds.width / 2, y: 4, width: layoutWidth / 2, height: layoutHeight / 2)
            image3.frame = CGRect(x: 4, y: self.bounds.height / 2, width: layoutWidth, height: layoutHeight / 2)
            image4.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: 0, height: 0)
        case .layout3:
            image1.frame = CGRect(x: 4, y: 4, width: layoutWidth / 2, height: layoutHeight / 2)
            image2.frame = CGRect(x: self.bounds.width / 2, y: 4, width: layoutWidth / 2, height: layoutHeight / 2)
            image3.frame = CGRect(x: 4, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
            image4.frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
        }
    }
    
    @IBAction func pushButton(button: UIButton) {
        switch button {
        case image1.buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: image1)
        case image2.buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: image2)
        case image3.buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: image3)
        case image4.buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: image4)
        default: break
        }
    }
    
    
    
    

}

protocol communicationView {
    func tellMeWhenTheButtonIsClicked(view: Subview)
}





/*extension UIView {
    
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                //return nil
            }
            self.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext() ?? <#default value#>
        }
    }
}*/



