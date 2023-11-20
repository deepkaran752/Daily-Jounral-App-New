//
//  EntryViewController.swift
//  Daily-Journal-App
//
//  Created by Deepkaran Singh on 2023-10-12.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    @IBOutlet var imageO: UIImageView!
    
    public var completion: ((String,String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style : .done, target: self, action: #selector(didTapSave))
        
        imageO.image = UIImage(named: "deepu.jpeg")
    }
    
    @objc func didTapSave(){
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty{
            completion?(text,noteField.text)
        }
    }
    

    

}
