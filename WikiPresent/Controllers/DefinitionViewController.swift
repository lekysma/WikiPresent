//
//  DefinitionViewController.swift
//  WikiPresent
//
//  Created by Jean martin Kyssama on 21/12/2019.
//  Copyright © 2019 Jean martin Kyssama. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DefinitionViewController: UIViewController {

    @IBOutlet weak var definitionIllustrationImageView: UIImageView!
    @IBOutlet weak var definitionTextView: UITextView!
    
    
    // on cree deux variables pour attacher l'image illustrative et la definition
    
    var definition: String?
    var imageIllustrative: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //definitionTextView.text = donnees
        definitionTextView.text = definition
        definitionIllustrationImageView = imageIllustrative

        // Do any additional setup after loading the view.
    }


}
