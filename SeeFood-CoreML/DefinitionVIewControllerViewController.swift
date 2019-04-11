import UIKit

class DefinitionVIewControllerViewController: UIViewController {

    @IBOutlet var imageViewPart: UIImageView!
    
    @IBOutlet var partDef: UILabel!
    
    var finalName: String = ""
    
    var imageName : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partDef.text = finalName
        imageViewPart.image = UIImage(named : imageName)
    }
    
    
    
}
