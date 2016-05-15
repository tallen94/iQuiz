//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/15/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var url: UITextField!
    @IBAction func checkNow(sender: UIButton) {
        if url.text != "" {
            QuizManager.Instance.DownloadData() {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        url.text = QuizManager.Instance.URL
    }
}
