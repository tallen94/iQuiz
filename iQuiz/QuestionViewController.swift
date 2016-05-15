//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/11/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var options: UITableView!
    
    override func viewDidLoad() {
        options.delegate = self
        options.dataSource = self
        options.estimatedRowHeight = 45
        options.rowHeight = UITableViewAutomaticDimension
        options.allowsMultipleSelection = false
        
        QuizManager.Instance.selectedQuiz.start()
        questionLabel.text = QuizManager.Instance.selectedQuiz.currentQuestion.title
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
        cell.indicator.backgroundColor = UIColor.clearColor()
        cell.indicator.layer.borderColor = cell.indicator.tintColor.CGColor
        cell.indicator.layer.borderWidth = 1.0
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        dispatch_async(dispatch_get_main_queue()) {
            var frame : CGRect = self.options.frame
            frame.size.height = tableView.contentSize.height
            self.options.frame = frame
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if QuizManager.Instance.selectedQuiz.currentQuestion.selectedAnswer != -1 {
            let previndex = NSIndexPath(forRow: QuizManager.Instance.selectedQuiz.currentQuestion.selectedAnswer - 1, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(previndex) as! RadioButton
            cell.indicator.backgroundColor = UIColor.clearColor()
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RadioButton
        cell.indicator.backgroundColor = cell.indicator.tintColor
        QuizManager.Instance.selectedQuiz.currentQuestion.selectedAnswer = indexPath.row + 1
    }
    
    func reload() {
        self.options.reloadData()
        questionLabel.text = QuizManager.Instance.selectedQuiz.currentQuestion.title
    }
}
