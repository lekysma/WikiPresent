//
//  ViewController.swift
//  WikiPresent
//
//  Created by Jean martin Kyssama on 21/12/2019.
//  Copyright © 2019 Jean martin Kyssama. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage // me permet d'ajouter une image venant de wikipedia pour illustrer mon paragraphe recherché

class ViewController: UIViewController {

    @IBOutlet weak var textEntryLabel: UITextField!
    @IBOutlet weak var segueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //darkMode()
        // on enleve le dark mode pour cette view
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Relevant variables
    let wikipediaURl = "https://fr.wikipedia.org/w/api.php"
    var termDefinitionInfo: String = ""
    var illustration = UIImageView()
    let segueName: String = "toDefinition"
    
    //MARK: - Button tapped action

    @IBAction func buttonToDefinition(_ sender: UIButton) {
        // on appelle la fonction ici
        httpCall(termDefinition: textEntryLabel.text ?? "Nothing to verify")
    }
    
    //MARK: - handles what needs to be done prior to triggering the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueName {
            
            if let secondVC = segue.destination as? DefinitionViewController {
                secondVC.definition = termDefinitionInfo
                secondVC.imageIllustrative = illustration
                
            } else {
                fatalError("Could not perform request!")
            }
            
        }
    }
    
    //MARK: - NETWORKING
      
      func httpCall(termDefinition: String) {
          let parameters : [String:String] = [
                 "format" : "json",
                 "action" : "query",
                 "prop" : "extracts|pageimages",
                 "exintro" : "",
                 "explaintext" : "",
                 "titles" : termDefinition,
                 "indexpageids" : "",
                 "redirects" : "1",
                 "pithumbsize" : "500"
                 ]
          
          //
          request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
              if response.result.isSuccess {
                //1. on affiche le tableau json initial
                let definitionJSON: JSON = JSON(response.result.value)
                print(definitionJSON)
                
                // 3 valeurs : pageID,definition et source de l'image
                let pageId = definitionJSON["query"]["pageids"][0].stringValue
                let pageDefinition = definitionJSON["query"]["pages"][pageId]["extract"].stringValue
                let imageSource = definitionJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                
                self.termDefinitionInfo = pageDefinition
                self.illustration.sd_setImage(with: URL(string: imageSource))
                
                
                // cas ou on n'a pas de definition
                if pageDefinition == "" {
                    self.termDefinitionInfo =  "Désolé,ce que vous cherchez ne se trouve pas sur Wikipedia"
                }
                
                // et on effectue le segue vers le second view controller ici
                self.performSegue(withIdentifier: "toDefinition", sender: self)
                print(self.termDefinitionInfo)
                  
              } else {
                print("Error! Could not fetch data!")
            }
          }
      }
    
    //MARK: - FONCTION QUI GERE LES COULEURS POUR LE DARK MODE
    func darkMode() {
        //la couleur du texte de la barre de navigation
        navigationController?.navigationBar.tintColor = UIColor.systemGray
        // la couleur du text du placeholder
        textEntryLabel.attributedPlaceholder = NSAttributedString(string: "Saisir ici le terme à rechercher", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        // la couleur du text
        textEntryLabel.textColor = UIColor.label
        //la couleur du text du bouton
        segueButton.setTitleColor(.secondaryLabel, for: .normal)
        
        //la couleur de fonds du bouton
        segueButton.backgroundColor = UIColor.secondaryLabel
        //la couleur de la bordure du bouton
        segueButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        segueButton.layer.borderWidth = 1
    }
    
}

