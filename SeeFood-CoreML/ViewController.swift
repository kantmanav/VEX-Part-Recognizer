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
        
            let parts = ["12 Tooth Gear", "24 Tooth Gear", "Motor", "36 Tooth Gear", "Axle", "Base Plate", "C-Channel", "Vex Chain", "Vex Cortex"]
        
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
                
                iterateParts: for part in parts {
                    if topResult.identifier.contains(part) {
                        DispatchQueue.main.async {
                            self.navigationItem.title = part
                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                            self.navigationController?.navigationBar.isTranslucent = false
                            self.hide_buttons()
                        }
                        break iterateParts
                    }
                }
            }
                let handler = VNImageRequestHandler(ciImage: image)
        
                do { try handler.perform([request]) }
                catch { print(error) }
        
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
        
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}
