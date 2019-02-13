//
//  ViewController.swift
//  new
//
//  Created by Fiona on 06/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import CoreImage

var CIFilterNames = "CIPhotoEffectChrome"

class ViewController: UIViewController, communicationView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
  
    
  
    @IBOutlet weak var buttonFilter: UIButton!

    @IBOutlet weak var imageToFilter: UIImageView!
    

    @IBOutlet weak var swipeGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var viewForShare: LabelShareView!
    
    @IBOutlet var buttonLayout: [UIButton]!
    @IBOutlet weak var layout: LayoutView!
    @IBOutlet weak var layoutSelected: UIImageView!
    
    var subview = Subview()
    
    private var selectImageView: UIImageView!
    //var subview = Subview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.delegate = self
        selectedLayout(buttonLayout[1])
        swipe()
       
        
        
    }
    

    
    @IBAction func iChoiceFilter(){
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = imageToFilter.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageToFilter.addSubview(blurView)
    
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
        //imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .camera
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectedLayout(_ sender: UIButton) {
        switch sender {
        case buttonLayout[0]:
            layout.layout = .layout1
            layoutSelected.center = buttonLayout[0].center
        case buttonLayout[1]:
            layout.layout = .layout2
            layoutSelected.center = buttonLayout[1].center
        case buttonLayout[2]:
            layout.layout = .layout3
            layoutSelected.center = buttonLayout[2].center
        default:
            break
            }
    }

    @IBAction func swipeForShare(_ sender: UISwipeGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                shareImg()
                print("gauche")
            case UISwipeGestureRecognizer.Direction.up:
                shareImg()
                print("haut")
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
        
        // objActivityViewController.popoverPresentationController?.sourceView = sender
        self.present(objActivityViewController, animated: true, completion: nil)
        /*{
            objActivityViewController.completionWithItemsHandler = { activity, success, items, error in
                
                if !success { print("cancelled")
                    return
                }/*
                
                if activity == UIActivity.ActivityType.mail {
                    print("mail")
                }
                else if activity == UIActivity.ActivityType.message {
                    print("message")
                }
                else if activity == UIActivity.ActivityType.saveToCameraRoll {
                    print("camera")
                }*/
            }
        })*/
    }
    
 /*   @IBAction func blurButtonTapped(_ sender: Any) {
        
        let inputImage = CIImage(cgImage: (self.layout.asImage()?.cgImage)!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        let blurred = filter?.outputImage
        
        var newImageSize: CGRect = (blurred?.extent)!
        newImageSize.origin.x += (newImageSize.size.width - (self.layout.asImage()?.size.width)!) / 2
        newImageSize.origin.y += (newImageSize.size.height - (self.layout.asImage()?.size.height)!) / 2
        newImageSize.size = (self.layout.asImage()?.size)!
        
        let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
        let context: CIContext = CIContext.init(options: nil)
        let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
        let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
        self.layout.asImage() = blurredImage
    }
   */
   /*
    @IBAction func addFilter(){
        //transformateViewOnImage().addBlur()
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.transformateViewOnImage().
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bg_imagview.addSubview(blurView)
    }
 */
}





