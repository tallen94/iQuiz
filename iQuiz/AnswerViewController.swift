//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/11/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var options: UITableView!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        options.delegate = self;
        options.dataSource = self;
        options.allowsSelection = false
        options.estimatedRowHeight = 45
        options.rowHeight = UITableViewAutomaticDimension
        questionLabel.text = QuizManager.Instance.selectedQuiz.currentQuestion.title
        if QuizManager.Instance.selectedQuiz.currentQuestion.selectedIsCorrect() {
            resultLabel.text = "Correct!"
            resultLabel.textColor = UIColor.greenColor()
        } else {
            resultLabel.text = "Wrong!"
            resultLabel.textColor = UIColor.redColor()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuizManager.Instance.selectedQuiz.currentQuestion.answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = options.dequeueReusableCellWithIdentifier("RadioButton", forIndexPath: indexPath) as! RadioButton
        cell.label.text = QuizManager.Instance.selectedQuiz.currentQuestion.answers[indexPath.row] as? String
        cell.indicator.layer.borderWidth = 1.0
        if QuizManager.Instance.selectedQuiz.currentQuestion.selectedIsCorrect() {
            if indexPath.row == QuizManager.Instance.selectedQuiz.currentQuestion.selectedAnswer - 1 {
                cell.indicator.backgroundColor = UIColor.greenColor()
                cell.indicator.layer.borderColor = UIColor.greenColor().CGColor
            } else {
                cell.indicator.backgroundColor = UIColor.clearColor()
                cell.indicator.layer.borderColor = cell.indicator.tintColor.CGColor
            }
        } else {
            if indexPath.row == QuizManager.Instance.selectedQuiz.currentQuestion.selectedAnswer - 1 {
                cell.indicator.backgroundColor = UIColor.redColor()
                cell.indicator.layer.borderColor = UIColor.redColor().CGColor
            }else if indexPath.row == QuizManager.Instance.selectedQuiz.currentQuestion.correctAnswer - 1 {
                cell.indicator.backgroundColor = UIColor.greenColor()
                cell.indicator.layer.borderColor = UIColor.greenColor().CGColor
            } else {
                cell.indicator.backgroundColor = UIColor.clearColor()
                cell.indicator.layer.borderColor = cell.indicator.tintColor.CGColor
            }
        }
        return cell
    }
    
    func reload() {
        self.options.reloadData()
        questionLabel.text = QuizManager.Instance.selectedQuiz.currentQuestion.title
        if QuizManager.Instance.selectedQuiz.currentQuestion.selectedIsCorrect() {
            resultLabel.text = "Correct!"
            resultLabel.textColor = UIColor.greenColor()
        } else {
            resultLabel.text = "Wrong!"
            resultLabel.textColor = UIColor.redColor()
        }
    }

}
