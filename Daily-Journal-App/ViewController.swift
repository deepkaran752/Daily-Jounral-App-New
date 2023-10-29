//
//  ViewController.swift
//  Daily-Journal-App
//
//  Created by Deepkaran Singh on 2023-10-09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Daily Journal" //the title of my app!
    }
    
    //variable declaration
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var didTapNewButton: UIBarButtonItem!
    
    
    var models: [(title: String, note: String)] = []
    //if a user creates a new note...
    @IBAction func didTapNewNote(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? EntryViewController else{
            return
        }
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion={noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.models.append((title: noteTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    //if a user wants to edit his/her notes
    @IBAction func Edit(_ sender : UIBarButtonItem){
        if table.isEditing{
            table.setEditing(false, animated: true)
            sender.title = "Edit"
            didTapNewButton.isEnabled = true
        } else{
            table.setEditing(true, animated: true)
            sender.title = "Done"
            didTapNewButton.isEnabled = false
        }
    }
    //for table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
        
        //Show note controller
        let model = models[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? NotesViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = model.title
        vc.note = model.note
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //for deleteing the notes
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            models.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

