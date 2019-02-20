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
    
    var color = UIColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth: CGFloat = 1
    var edges = [UIRectEdge](){
        didSet {
            setNeedsDisplay()
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

