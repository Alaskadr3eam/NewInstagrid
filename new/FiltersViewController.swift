//
//  FiltersViewController.swift
//  new
//
//  Created by Fiona on 13/02/2019.
//  Copyright © 2019 clement. All rights reserved.
//


import UIKit
import CoreImage






class FiltersViewController: UIViewController {
  
    /* Views */
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var imageToFilter: UIImageView!
    var imgOriginal = UIImage()
    
    @IBOutlet weak var filtersScrollView: UIScrollView!
    
    /* GLOBAL VARIABLES */
    var CIFilterNames = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
    var CIFilterNamesList = [
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func swipe(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForShare(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeForShare(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipe()
       
        originalImage.image = imgOriginal
        
        // Variables for setting the Font Buttons
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth: CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        // Items Counter
       var itemCount = 0
        
        // Loop for creating buttons ------------------------------------------------------------
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.showsTouchWhenHighlighted = true
            filterButton.addTarget(self, action: #selector(filterButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            filterButton.setTitle(CIFilterNamesList[i], for: .normal)
            filterButton.setTitleColor(.black, for: .normal)
            filterButton.titleLabel?.font = UIFont(name: "ThirstySoftRegular", size: 17)
            
            
            
            // Create filters for each button
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: originalImage.image!)
            let filter = CIFilter(name:  CIFilterNames[i] )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!)
         
            // Assign filtered image to the button
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            filtersScrollView.addSubview(filterButton)
        } // END LOOP ------------------------------------------------------------------------
        
        
        // Resize Scroll View
        filtersScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2), height: yCoord)
        // CGSizeMake(buttonWidth * CGFloat(itemCount+2), yCoord)
 
    }

    
    // FILTER BUTTON ACTION
    @objc func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        imageToFilter.image = button.backgroundImage(for: UIControl.State.normal)

    }
    
    
    
    @IBAction func swipeForShare(_ sender: UISwipeGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action:UIAlertAction) in
                    self.shareImg()
                }))
                actionSheet.addAction(UIAlertAction(title: "Annulate", style: .default, handler: { (action:UIAlertAction) in
                    self.performSegue(withIdentifier: "Return", sender: self)
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                present(actionSheet, animated: true, completion: nil)
                
            case UISwipeGestureRecognizer.Direction.up:
                let actionSheet = UIAlertController(title: "For Your Picture", message: "Choose An Option", preferredStyle: . actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action:UIAlertAction) in
                    self.shareImg()
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                present(actionSheet, animated: true, completion: nil)
                
            default: break
            }
        }
    }
    
    func shareImg() {
        shareLayoutUsingActivityViewController(imageParamater: (imageToFilter.image!))
    }
    
    func shareLayoutUsingActivityViewController(imageParamater: UIImage) {
        let activityItem: [UIImage] = [imageParamater as UIImage]
        
        let objActivityViewController = UIActivityViewController(activityItems: activityItem as [UIImage], applicationActivities: nil)
        objActivityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        
        self.present(objActivityViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}


