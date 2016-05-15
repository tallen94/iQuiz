//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/11/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    private var questionVC : QuestionViewController?
    private var answerVC : AnswerViewController?
    @IBOutlet var changeVCButton: UIButton!
    @IBOutlet var progressLabel: UILabel!
    
    override func viewDidLoad() {
        self.questionVC = storyboard?.instantiateViewControllerWithIdentifier("question") as? QuestionViewController
        self.answerVC = storyboard?.instantiateViewControllerWithIdentifier("answer") as? AnswerViewController
        self.addChildViewController(self.questionVC!)
        self.view.insertSubview(questionVC!.view, atIndex: 0)
        self.questionVC!.didMoveToParentViewController(self)
        self.progressLabel.text = "\(QuizManager.Instance.selectedQuiz.questionNumber + 1)/\(QuizManager.Instance.selectedQuiz.questions.count)"
    }
    
    @IBAction func changeVC(sender: UIButton) {
        if changeVCButton.currentTitle == "See Answer" {
            showAnswer()
        } else if changeVCButton.currentTitle == "Next Question" {
            nextQuestion()
        } else {
            finishQuiz()
        }
    }
    
    func nextQuestion() {
        changeVCButton.setTitle("See Answer", forState: .Normal)
        QuizManager.Instance.selectedQuiz.nextQuestion()
        questionVC?.reload()
        self.progressLabel.text = "\(QuizManager.Instance.selectedQuiz.questionNumber + 1)/\(QuizManager.Instance.selectedQuiz.questions.count)"
        switchToVC(answerVC, to: questionVC)
    }

    func showAnswer() {
        if QuizManager.Instance.selectedQuiz.questionNumber + 1 <
            QuizManager.Instance.selectedQuiz.questions.count {
            changeVCButton.setTitle("Next Question", forState: .Normal)
        } else {
            changeVCButton.setTitle("Finish Quiz", forState: .Normal)
        }
        if QuizManager.Instance.selectedQuiz.questionNumber > 0 {
            answerVC?.reload()
        }
        switchToVC(questionVC, to: answerVC)
    }
    
    func finishQuiz() {
        self.performSegueWithIdentifier("unwindQuizSegue", sender: self)
    }
    
    func switchToVC(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }
}
