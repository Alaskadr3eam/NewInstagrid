//
//  Subview.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

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
 //    var delegate1: pinchInImage?
    //var delegate: communicationView?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
 
    
}



/*

extension Subview {
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {
        
       /* if edges.contains(.all) {
            layer.borderWidth = self.width
            layer.borderColor = self.color.cgColor
        } else {*/
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]
            
            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }
                
                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = self.color
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)
                    
                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"
                    
                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(self.width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(self.width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(self.width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(self.width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    
}

    

extension Subview {
    
    override func draw(_ rect: CGRect) {
        if edges.contains(.top) || edges.contains(.all){
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            color.setStroke()
            UIColor.blue.setFill()
            path.move(to: CGPoint(x: 0, y: 0 + lineWidth / 2))
            path.addLine(to: CGPoint(x: self.bounds.width, y: 0 + lineWidth / 2))
            path.stroke()
        }
        if edges.contains(.bottom) || edges.contains(.all){
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            color.setStroke()
            UIColor.blue.setFill()
            path.move(to: CGPoint(x: 0, y: self.bounds.height - lineWidth / 2))
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - lineWidth / 2))
            path.stroke()
        }
        if edges.contains(.left) || edges.contains(.all){
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            color.setStroke()
            UIColor.blue.setFill()
            path.move(to: CGPoint(x: 0 + lineWidth / 2, y: 0))
            path.addLine(to: CGPoint(x: 0 + lineWidth / 2, y: self.bounds.height))
            path.stroke()
        }
        if edges.contains(.right) || edges.contains(.all){
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            color.setStroke()
            UIColor.blue.setFill()
            path.move(to: CGPoint(x: self.bounds.width - lineWidth / 2, y: 0))
            path.addLine(to: CGPoint(x: self.bounds.width - lineWidth / 2, y: self.bounds.height))
            path.stroke()
        }
    }
    
    
    func borders(_ localisation: [UIRectEdge], thikness: CGFloat, bColor: UIColor){
        self.edges = localisation
        self.lineWidth = thikness
        self.color = bColor
    }
    
    
}
*/
