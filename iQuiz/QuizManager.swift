//
//  QuizManager.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/8/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import Foundation

// Implement api calls
// Get JSON and save to disk
/*
 NSArray/NSDictionary
    write: call writeToFile:atomically
    read: use initializer expecting "contentsOfFile" parameter
 
 */

public class QuizManager {
    
    public var quizzes : NSMutableArray!
    public var selectedQuiz : Quiz!
    
    private let icons : [String] = ["math.jpg", "science.png", "marvel.jpeg"]
    
    private let FILE : String = "quizzes.txt"
    public let URL : String = "http://tednewardsandbox.site44.com/questions.json"
    
    private static let _instance: QuizManager = QuizManager()
    public static var Instance: QuizManager {
        get {return _instance}
    }
    
    public func DownloadData(completion: () -> Void ) {
        let request = NSMutableURLRequest(URL: NSURL(string: URL)!)
        self.quizzes = []
        httpGet(request) { (data, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions()) as? NSArray
                    let jsonString = String(data: data.dataUsingEncoding(NSUTF8StringEncoding)!, encoding: NSUTF8StringEncoding)
                    self.saveToLocal(jsonString!)
                    for object in json! as NSArray {
                        let quiz = Quiz()
                        quiz.description = object["desc"] as! String
                        quiz.title = object["title"] as! String
                        quiz.questions = object["questions"] as! NSArray
                        self.quizzes.addObject(quiz)
                    }
                    completion()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func GetQuizzes() {
        if let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(FILE)
            
            do {
                let jsonString = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
                let json = try NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions()) as? NSArray
                generateQuizzes(json! as NSArray)
            } catch {
                DownloadData() {
                    
                }
            }
        }
    }
    
    private func generateQuizzes(array: NSArray) {
        for object in array {
            let quiz = Quiz()
            quiz.description = object["desc"] as! String
            quiz.title = object["title"] as! String
            quiz.questions = object["questions"] as! NSArray
            self.quizzes.addObject(quiz)
        }
    }
    
    private func saveToLocal(string: String) {
        if let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true).first {
            let path = dir.stringByAppendingString(FILE)
            
            do {
                try string.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            } catch { }
        }
    }
    
    public func startQuiz(number: Int) {
        selectedQuiz = quizzes[number] as! Quiz
    }
    
    private func httpGet(request: NSURLRequest!, completion: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                completion("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                completion(result as String, nil)
            }
        }
        task.resume()
    }
}
