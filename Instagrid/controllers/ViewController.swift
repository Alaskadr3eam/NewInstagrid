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
    
    @IBOutlet weak var viewForAddFilter: LabelView!
   
    
    @IBOutlet var buttonLayout: [UIButton]!
    @IBOutlet weak var layout: LayoutView!
    @IBOutlet var layoutSelected: [UIImageView]!
    
    
    var i = 0
    var filterView = FiltersViewController()
    
    private var selectImageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.delegate = self
        selectedLayout(buttonLayout[1])
        initSwipeGesture()
       
        
        
    }
    
    // FUNC TO PASS AN IMAGE FROM ONE VIEWCONTROLLER TO ANOTHER
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Filter"{
            let filtersViewController = segue.destination as! FiltersViewController
            filtersViewController.imgOriginal = self.transformateViewOnImage()
        }
    }
    
   // FUNC TO INIT SWIPEGESTURE FOR THE CONTROLLER
    func initSwipeGesture(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForAddFilter(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForAddFilter(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
   //FUNCTION FOR KNOW ORIENTATION DEVICE => NOTIFICATION
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name:UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
   //FUNC TO MODIFY THE TEXT FOLLOWING THE ORIENTATION DEVICE
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        //let orientation = UIDevice.current.orientation
        if UIDevice.current.orientation.isPortrait {
            viewForAddFilter.shareLabel.text = "Swipe to up for filter"
            viewForAddFilter.iconArrow.image = UIImage(named: "arrow1")
            
        }
        if UIDevice.current.orientation.isLandscape {
            viewForAddFilter.shareLabel.text = "Swipe to left for filter"
            viewForAddFilter.iconArrow.image = UIImage(named: "arrow2")
        }
    }
 // FUNC DELEGATE
    func tellMeWhenTheButtonIsClicked(view: Subview) {
        selectImageView = view.image
        pickPicture()
    }
//FUNCTION TO RECOVER PHOTO
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
  //FUNC PICK IMAGE IN IMAGEVIEW
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
  //FUNC SELECTED LAYOUT
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
    
    private func isHidden(index: Int){
        layoutSelected[index].isHidden = true
    }
// FUNC FOR ACCESS FILTERSVIEWCONTROLLER
    @IBAction func swipeForAddFilter(_ sender: UISwipeGestureRecognizer?) {
        if let swipeGesture = sender {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
               
                actionSheet.addAction(UIAlertAction(title: "Add to filter", style: .default, handler: { (action: UIAlertAction!) in
                    self.performSegue(withIdentifier: "Filter", sender: self)
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                present(actionSheet, animated: true, completion: nil)
                
            case UISwipeGestureRecognizer.Direction.up:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
             
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
  // FUNC TO TRANSFORMATE VIEW IN UIIMAGE
    private func transformateViewOnImage() -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: layout.bounds.size)
        let imgOriginal = renderer.image { ctx in
            layout.drawHierarchy(in: layout.bounds, afterScreenUpdates: true)
        }
        return imgOriginal
    }
// FUNCTION GROUP TO CHANGE THE COLOR OF THE EDGE
    private func attributedColor() {
        let color = Modele.colorArray[i]
        layout.borderColor = color
        for y in 0..<layout.imageSubview.count {
           layout.imageSubview[y].color = color
        }
    }
    
    private func choiceBorderColor() {
        if i <= Modele.colorArray.count - 1 {
            attributedColor()
            i += 1
        } else {
            i = 0
            attributedColor()
            i += 1
        }
    }
    
    @IBAction func changedBorderColor() {
        choiceBorderColor()
        
    }
    
    
  // FUNCTION TO CHANGE THE THICKNESS OF BORDERS
    @IBAction func sliderModifiedThiknessBorder(_ sender: UISlider){
        let step: Float = 0.5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        if layout.layout == .layout1 {
            layout.borderWidth = CGFloat(sender.value)
            for y in 0..<layout.imageSubview.count {
            layout.imageSubview[y].borderWidth = CGFloat(sender.value)
            }
        selectedLayout(buttonLayout[0])
        }else if layout.layout == .layout2 {
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
        }
    }
    
}





