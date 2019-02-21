//
//  ViewController.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import CoreImage



class ViewController: UIViewController, communicationView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
  
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var swipeGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var viewForShare: LabelShareView!
    
    @IBOutlet var buttonLayout: [UIButton]!
    @IBOutlet weak var layout: LayoutView!
    @IBOutlet var layoutSelected: [UIImageView]!
    
    var i = 0
    
    
    private var selectImageView: UIImageView!
    //var subview = Subview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.delegate = self
        selectedLayout(buttonLayout[1])
        //layout.layout = .layout2
        swipe()
       
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Filter"{
            let filtersViewController = segue.destination as! FiltersViewController
            filtersViewController.imgOriginal = self.transformateViewOnImage()
        }
    }
    
   
    func swipe(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForShare(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForShare(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            viewForShare.shareLabel.text = "Swipe to up for share"
            viewForShare.iconArrow.image = UIImage(named: "arrow1")
        }
        if UIDevice.current.orientation.isLandscape {
            viewForShare.shareLabel.text = "Swipe to left for share"
            viewForShare.iconArrow.image = UIImage(named: "arrow2")
        }
    }
    
    func start() {
        selectedLayout(buttonLayout[1])
    }
    
  

    func tellMeWhenTheButtonIsClicked(view: Subview) {
       // view.buttonAddPicture.isHidden = true
        selectImageView = view.image
        pickPicture()
    }
    

    
    func pickPicture() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let actionSheet = UIAlertController(title: "Add Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else {
                print("Camera not Available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler:{ (action:UIAlertAction) in imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
        ))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectedLayout(_ sender: UIButton) {
        switch sender {
        case buttonLayout[0]:
            layout.layout = .layout1
            isHidden(index: 1)
            isHidden(index: 2)
            layoutSelected[0].isHidden = false
        case buttonLayout[1]:
            layout.layout = .layout2
            isHidden(index: 0)
            isHidden(index: 2)
            layoutSelected[1].isHidden = false
        case buttonLayout[2]:
            layout.layout = .layout3
            isHidden(index: 0)
            isHidden(index: 1)
            layoutSelected[2].isHidden = false
        default:
            break
            }
    }
    
    /*  func imageSelectedIsHidden(index: UIImageView){
     let indexKey = index
     var index1: Bool = false
     for i in layoutSelected {
     if i != indexKey{
     index1 = true
     }
     }
     
     if index1 {
     layoutSelected[index1].isHidden = true
     } else {
     layoutSelected[
     }
     
     }
     */
    
    func isHidden(index: Int){
        layoutSelected[index].isHidden = true
    }

    @IBAction func swipeForShare(_ sender: UISwipeGestureRecognizer?) {
        if let swipeGesture = sender {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action:UIAlertAction) in
                    self.shareImg()
                }))
                actionSheet.addAction(UIAlertAction(title: "Add to filter", style: .default, handler: { (action: UIAlertAction!) in
                    self.performSegue(withIdentifier: "Filter", sender: self)
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                present(actionSheet, animated: true, completion: nil)
                
            case UISwipeGestureRecognizer.Direction.up:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action:UIAlertAction) in
                    self.shareImg()
                }))
                actionSheet.addAction(UIAlertAction(title: "Add to Filter", style: .default, handler:{ (action:UIAlertAction) in
                    self.performSegue(withIdentifier: "Filter", sender: self)
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                present(actionSheet, animated: true, completion: nil)
            default: break
            }
        }
    }
    
    func transformateViewOnImage() -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: layout.bounds.size)
        let imgOriginal = renderer.image { ctx in
            layout.drawHierarchy(in: layout.bounds, afterScreenUpdates: true)
        }
        return imgOriginal
    }
    
    func shareImg() {
        shareLayoutUsingActivityViewController(imageParamater: (transformateViewOnImage()))
        
    }
    
    func shareLayoutUsingActivityViewController(imageParamater: UIImage) {
        let activityItem: [UIImage] = [imageParamater as UIImage]
        
        let objActivityViewController = UIActivityViewController(activityItems: activityItem as [UIImage], applicationActivities: nil)
        objActivityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        
        
        self.present(objActivityViewController, animated: true, completion: nil)
        
    }
    
    func attributedColor() {
        let color = Modele.colorArray[i]
        layout.borderColor = color
        for y in 0..<layout.imageSubview.count {
           layout.imageSubview[y].color = color
        }
        
    }
    
    func choiceBorderColor() {
        if i <= Modele.colorArray.count - 1 {
            attributedColor()
            i += 1
        } else {
            i = 0
            attributedColor()
            i += 1
        }
    }
    
    @IBAction func borderColor() {
        choiceBorderColor()
        
    }
    
    let step: Float = 0.5
    
    @IBAction func sliderThiknessBorder(_ sender: UISlider){
       // var senderIntValue = Int(sender.value)
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        if layout.layout == .layout1 {
            layout.borderWidth = CGFloat(sender.value)
            for y in 0..<layout.imageSubview.count {
            layout.imageSubview[y].borderWidth = CGFloat(sender.value)
                print(sender.value)
            }
        selectedLayout(buttonLayout[0])
        }/* else if layout.layout == .layout2 {
            layout.borderWidth = CGFloat(sender.value)
            for y in 0..<layout.imageSubview.count {
               layout.imageSubview[y].borderWidth = CGFloat(sender.value)
            }
            selectedLayout(buttonLayout[1])
        } else {
            layout.borderWidth = CGFloat(sender.value)
            for y in 0..<layout.imageSubview.count {
               layout.imageSubview[y].borderWidth = CGFloat(sender.value)
            }
            selectedLayout(buttonLayout[2])
        }*/
    }
    
}





