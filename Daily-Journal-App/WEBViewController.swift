//
//  WEBViewController.swift
//  Daily-Journal-App
//
//  Created by manjit on 07/11/23.
//

import UIKit

class WEBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //FOR WEBVIEW
        let urlString = URL(string: "https://youtu.be/56Abs-8OzzE?si=4-TRTbxUhA6E1oCt")
        let urlReq = URLRequest(url:urlString!)
        WebView.loadRequest(urlReq)
    }
    
    @IBOutlet weak var WebView: UIWebView!
    
    
}
