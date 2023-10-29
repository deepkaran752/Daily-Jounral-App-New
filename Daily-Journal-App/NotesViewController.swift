//
//  NotesViewController.swift
//  Daily-Journal-App
//
//  Created by Deepkaran Singh on 2023-10-12.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var noteLabel : UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = noteTitle
        noteLabel.text = note
        // Do any additional setup after loading the view.
    }
    

}
