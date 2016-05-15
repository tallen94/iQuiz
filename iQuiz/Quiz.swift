//
//  Quiz.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/14/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import Foundation

public class Quiz {
    
    private var _image : String!
    private var _title : String!
    private var _description : String!
    private var _questions : NSMutableArray!
    private var _questionNumber : Int!
    private var _currentQuestion : Question!
    
    private var _selectedAnswer : Int!
    
    public var image : String! {
        get { return _image }
        set (value) {
            _image = value
        }
    }
    
    public var questionNumber : Int! {
        get { return _questionNumber }
        set (value) {
            _questionNumber = value
        }
    }
    
    public var questions : NSArray! {
        get { return _questions }
        set (value) {
            _questions = []
            for object in value as NSArray {
                let question = Question()
                question.answers = object["answers"] as! NSArray
                question.correctAnswer = Int(object["answer"] as! String)
                question.selectedAnswer = -1
                question.title = object["text"] as! String
                _questions.addObject(question)
            }
        }
    }
    
    public var currentQuestion : Question! {
        get { return _currentQuestion }
        set (value) {
            _currentQuestion = value
        }
    }
    
    public var selectedAnswer : Int! {
        get { return _selectedAnswer }
        set (value) {
            _selectedAnswer = value
        }
    }
    
    public var title : String! {
        get { return _title }
        set (value) {
            _title = value
        }
    }
    
    public var description : String! {
        get { return _description }
        set (value) {
            _description = value
        }
    }
    
    public func nextQuestion() {
        questionNumber = questionNumber + 1
        selectedAnswer = -1
        currentQuestion = questions[questionNumber] as! Question
    }
    
    public func selectedCorrectAnswer() -> Bool {
        return _selectedAnswer == currentQuestion.correctAnswer
    }
    
    public func start() {
        self.questionNumber = 0
        self.currentQuestion = questions[questionNumber] as! Question
    }
}
