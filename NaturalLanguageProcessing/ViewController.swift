//
//  ViewController.swift
//  NaturalLanguageProcessing
//
//  Created by Iurie Guzun on 2020-05-16.
//  Copyright © 2020 Iurie Guzun. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "123", consumerSecret: "456")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is a nice company!")
        print(prediction.label)
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            //    print(results)
            var tweeds = [String]()
            for i in 0..<100 {
                if let tweet = results[i]["full_txt"].string {
                    print(tweet)
                    tweeds.append(tweet)
                }
            }
            print(tweeds)
        }) { (error) in
            print("There are an error with the Twitter API Request, \(error.localizedDescription)")
        }
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        // do the job
    }
    
}

