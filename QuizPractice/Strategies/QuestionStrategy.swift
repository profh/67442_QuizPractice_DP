//
//  QuestionStrategy.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: class {
  
  func currentQuestion() -> Question
  
  func advanceToNextQuestion() -> Bool

  func title() -> String
  
  func markQuestionCorrect()
  
  func markQuestionIncorrect()
  
}
