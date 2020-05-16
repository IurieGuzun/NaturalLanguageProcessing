//
//  ViewController.swift
//  NaturalLanguageProcessing
//
//  Created by Iurie Guzun on 2020-05-16.
//  Copyright © 2020 Iurie Guzun. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "", consumerSecret: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func predictPressed(_ sender: Any) {
        // do the job
    }
    
}

