//
//  Subview.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
// CREAT VIEW
class Subview: UIView {
    
    @IBOutlet weak var buttonAddPicture: UIButton!
    @IBOutlet weak var image: UIImageView!
  
    @IBInspectable var borderWidth: CGFloat = 1{
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var color: UIColor!{
        didSet {
            layer.borderColor = color?.cgColor
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
 
    
}

