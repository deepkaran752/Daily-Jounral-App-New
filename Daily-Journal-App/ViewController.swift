//
//  ViewController.swift
//  Daily-Journal-App
//
//  Created by Deepkaran Singh on 2023-10-09.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    //var for audio player
    var audioPlayer : AVAudioPlayer = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Switch.isOn = true
        table.delegate = self
        table.dataSource = self
        title = "Daily Journal" //the title of my app!
        
        //for audio player functionality
        do{
            let audioPath1 = Bundle.main.path(forResource: "BH", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath1!) as URL)
        }
        catch
            {
                
            }
    }
    
    //variable declaration
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    
    @IBOutlet weak var didTapNewButton: UIBarButtonItem!
    
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet var Background: UIView!
    //for music player
    @IBOutlet weak var MusicButton: UIBarButtonItem!
    
    
    //for web view
    @IBOutlet weak var WebViewManage: UIBarButtonItem!
    
    //dataset
    var models: [(title: String, note: String)] = []
    //if a user creates a new note...
    
    //alert handler
    @IBAction func didTapNewNote(){
        let alert = UIAlertController(title: "Daily Journal App", message: "Do you want to add a note?", preferredStyle: .alert)
            
            let addAction = UIAlertAction(title: "Add Note", style: .default) { [weak self] _ in
                // Call the function to navigate to the new note view
                self?.didTapNewNotefunc()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
    }
    
    func didTapNewNotefunc(){
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
        //play music on selecting the note
        
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
    
    //for dark mode
    
    @IBAction func DarkMode(_ sender: UISwitch) {
        print("Switch state: \(sender.isOn)")
        if(Switch.isOn){
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }else{
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
    
    //for playing the music
    @IBAction func MusicButtonPlay(_ sender: Any) {
        if(audioPlayer.isPlaying){
            audioPlayer.stop()
        }else{
            audioPlayer.play()
        }
    }
    
    //for playing the video
    
    @IBAction func WebViewManageVideo(_ sender: Any) {
        performSegue(withIdentifier: "webclick", sender: self)
    }
    

}

//)
