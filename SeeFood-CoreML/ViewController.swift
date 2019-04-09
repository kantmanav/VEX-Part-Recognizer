//
//  ViewController.swift
//  SeeFood-CoreML
//
//  Created by Angela Yu on 27/06/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var gearImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
    var labelText = ""
    
    @IBAction func seeDetails(_ sender: Any) {
        labelText = self.navigationItem.title!
        
        performSegue(withIdentifier: "segueDef", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DefinitionVIewControllerViewController
        vc.finalName = self.labelText
        vc.imageName = self.labelText
        
    }
    func hide_buttons() {
        gearImage.isHidden = true
        searchLabel.isHidden = true
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    var classificationResults : [VNClassificationObservation] = []

    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: VEX().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
                }
            
            if topResult.identifier.contains("12 Tooth Gear") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "12 Tooth Gear"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    }
                }
            else if topResult.identifier.contains("24 Tooth Gear") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "24 Tooth Gear"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("Motor") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Motor"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("36 Tooth Gear") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "36 Tooth Gear"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("Axle") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Axle"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("Base Plate") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Base Plate"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("C-Channel") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "C-Channel"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("Vex Chain") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Vex Chain"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                    
                }
            }
            else if topResult.identifier.contains("Vex Cortex") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Vex Cortex"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.hide_buttons()
                        
                    }
            }            
                
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }
        
        
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[.originalImage] as? UIImage {
                    
            imageView.image = image
            
            imagePicker.dismiss(animated: true, completion: nil)
            
            
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            
            detect(image: ciImage)
            
        }
    }
        

    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
   
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
