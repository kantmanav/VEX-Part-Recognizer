//
//  DefinitionVIewControllerViewController.swift
//  SeeFood-CoreML
//
//  Created by Useless on 4/2/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

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
