//
//  Question.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/14/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import Foundation

public class Question {
    
    private var _title : String!
    private var _answers : NSArray!
    private var _selectedAnswer : Int!
    private var _correctAnswer : Int!
    
    public var title : String {
        get { return _title }
        set (value) {
            _title = value
        }
    }
    
    public var answers : NSArray! {
        get { return _answers }
        set (value) {
            _answers = value
        }
    }
    
    public var selectedAnswer : Int! {
        get { return _selectedAnswer }
        set (value) {
            _selectedAnswer = value
        }
    }
    
    public var correctAnswer : Int! {
        get { return _correctAnswer }
        set (value) {
            _correctAnswer = value
        }
    }
    
    public func selectedIsCorrect() -> Bool {
        return selectedAnswer == correctAnswer
    }
}