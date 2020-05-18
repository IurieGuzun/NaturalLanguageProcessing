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
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "123", consumerSecret: "456")
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    @IBAction func predictPressed(_ sender: Any) {
         fetchTweets()
    }
    
    func fetchTweets() {
        if let searchText = textField.text {
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is a nice company!")
          print(prediction.label)
          
          swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
              //    print(results)
              var tweets = [TweetSentimentClassifierInput]()
           for i in 0..<self.tweetCount {
                  if let tweet = results[i]["full_txt"].string {
                      print(tweet)
                      let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                      tweets.append(tweetForClassification)
                  }
              }
              print(tweets)
            self.makePrediction(with: tweets)
          }) { (error) in
              print("There are an error with the Twitter API Request, \(error.localizedDescription)")
          }
          }    }
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            print(predictions[0].label)
            for pred in predictions {
                     print(pred.label)
                let sentiment = pred.label
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            print("sentimentScore = ",sentimentScore)
            updateUI(with: sentimentScore)
       
            
        } catch {
            print("There was an error with making a prediction, \(error)")
        }
    }
    func updateUI(with sentimentScore: Int) {
        if sentimentScore > 20 {
                   self.sentimentLabel.text = "😍"
               } else if sentimentScore > 10 {
                   self.sentimentLabel.text = "😀"
               } else if sentimentScore > 0 {
                    self.sentimentLabel.text = "🙂"
               } else if sentimentScore == 0 {
                   self.sentimentLabel.text = "😐"
               } else if sentimentScore > -10 {
                   self.sentimentLabel.text = "😕"
               } else if sentimentScore > -20 {
                   self.sentimentLabel.text = "😡"
               } else  {
                 self.sentimentLabel.text = "😢"
               }
    }
    
    
}

