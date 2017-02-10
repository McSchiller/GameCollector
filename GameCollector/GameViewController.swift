//
//  GameViewController.swift
//  GameCollector
//
//  Created by Andreas Schiller on 10.02.17.
//  Copyright © 2017 Schiller. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageContainer: UIImageView!
   
    @IBOutlet weak var imageTextfield: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func cameraTabbed(_ sender: Any) {
       
        
    }
    
    @IBAction func folderTabbed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageContainer.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func addTabbed(_ sender: Any) {
        let manager = UIApplication.shared.delegate as! AppDelegate
        let context = manager.persistentContainer.viewContext
        let game = Game(context: context)
        
        game.name = imageTextfield.text
        game.image = UIImagePNGRepresentation(imageContainer.image!)! as NSData
        
        manager.saveContext()
    }
}
