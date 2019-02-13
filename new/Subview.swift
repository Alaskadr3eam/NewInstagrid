//
//  Subview.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class Subview: UIView {
    
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
    
    @IBOutlet weak var buttonAddPicture: UIButton!
    @IBOutlet weak var image: UIImageView!
    
 //    var delegate1: pinchInImage?
    //var delegate: communicationView?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    func pinch(){
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchedView(pinch:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(pinchGesture)
    }
    */
    @IBAction func handlePan(recognizer:UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }

  

}
/*
protocol pinchInImage {
    func tellWhenPinch(view: Subview)
}
*/
