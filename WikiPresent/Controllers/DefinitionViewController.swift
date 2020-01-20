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
import SDWebImage

class DefinitionViewController: UIViewController {

    @IBOutlet weak var definitionIllustrationImageView: UIImageView!
    @IBOutlet weak var definitionTextView: UITextView!
    
    
    // on cree deux variables pour attacher l'image illustrative et la definition
    
    var definition: String?
    var urlImage: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // on s'assure que urlImage n'est pas nul
        if urlImage != nil {
            //test
            print(urlImage)
            //on utilise sd image pour afficher le texte via l'url
            definitionIllustrationImageView.sd_setImage(with: URL(string: urlImage!))
            //on affiche le texte ici pour avoir un affichage en meme temps que l'image
            definitionTextView.text = definition
        } else {
            fatalError("Unable to recover image Url!")
        }
        

        // Do any additional setup after loading the view.
    }


}
