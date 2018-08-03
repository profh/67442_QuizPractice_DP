//
//  QuestionGroup.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import Foundation

//public struct QuestionGroup {
//  public let questions: [Question]
//  public let title: String
//}

public class QuestionGroup {
  
  public class Score {
    
    public var correctCount: Int = 0 {
      didSet {
        updateRunningPercentage()
      }
    }
    public var questionCount: Int = 0 {
      didSet {
        updateRunningPercentage()
      }
    }
    private func updateRunningPercentage() {
      runningPercentage.value = calculateRunningPercentage()
    }
    
    public init() { }
    
    public lazy var runningPercentage = Observable(calculateRunningPercentage())
    
    private func calculateRunningPercentage() -> Double {
      guard questionCount > 0 else { return 0 }
      return Double(correctCount) / Double(questionCount)
    }
    
    public func reset() {
      correctCount = 0
      questionCount = 0
    }
  }
  
  public let questions: [Question]
  public let title: String
  public private(set) var score: Score

  
  public init(questions: [Question], title: String, score: Score = Score()) {
    self.questions = questions
    self.score = score
    self.title = title
  }
}
