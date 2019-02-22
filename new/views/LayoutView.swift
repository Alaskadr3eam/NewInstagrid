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
    
    @IBInspectable var borderWidth: CGFloat = 4 {
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
    @IBOutlet var imageSubview: [Subview]!
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
       
        let layoutWidth = self.bounds.width - (self.borderWidth*2)
        let layoutHeight = self.bounds.height - (self.borderWidth*2)
        switch layout {
        case .layout1:
            imageSubview[0].frame = CGRect(x: borderWidth, y: borderWidth, width: layoutWidth, height: layoutHeight / 2)
            imageSubview[1].frame = CGRect(x: (self.bounds.width / 2), y: borderWidth, width: 0, height: 0)
            imageSubview[2].frame = CGRect(x: borderWidth, y: (self.bounds.height / 2), width: (layoutWidth / 2), height: layoutHeight / 2)
            imageSubview[3].frame = CGRect(x: (self.bounds.width / 2), y: (self.bounds.height / 2), width: layoutWidth / 2, height: layoutHeight / 2)
        case .layout2:
            imageSubview[0].frame = CGRect(x: borderWidth, y: borderWidth, width: layoutWidth / 2, height: layoutHeight / 2)
            imageSubview[1].frame = CGRect(x: self.bounds.width / 2, y: borderWidth, width: layoutWidth / 2, height: layoutHeight / 2)
            imageSubview[2].frame = CGRect(x: borderWidth, y: self.bounds.height / 2, width: layoutWidth, height: layoutHeight / 2)
            imageSubview[3].frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: 0, height: 0)
        case .layout3:
            imageSubview[0].frame = CGRect(x: borderWidth, y: borderWidth, width: layoutWidth / 2, height: layoutHeight / 2)
            imageSubview[1].frame = CGRect(x: self.bounds.width / 2, y: borderWidth, width: layoutWidth / 2, height: layoutHeight / 2)
            imageSubview[2].frame = CGRect(x: borderWidth, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
            imageSubview[3].frame = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: layoutWidth / 2, height: layoutHeight / 2)
        }
    }
    
    @IBAction func pushButton(button: UIButton) {
        switch button {
        case imageSubview[0].buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: imageSubview[0])
        case imageSubview[1].buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: imageSubview[1])
        case imageSubview[2].buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: imageSubview[2])
        case imageSubview[3].buttonAddPicture:
            delegate?.tellMeWhenTheButtonIsClicked(view: imageSubview[3])
        default: break
        }
    }
    
    
    
    

}

protocol communicationView {
    func tellMeWhenTheButtonIsClicked(view: Subview)
}





