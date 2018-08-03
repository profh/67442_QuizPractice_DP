//
//  AlphabeticalQuestionStrategy.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import Foundation

// MARK: RandomQuestionStrategy
public class AlphabeticalQuestionStrategy: BaseQuestionStrategy {
  
  // All we have to do here is modify our init so that we are drawing 20 questions of a given grouping at random
  
  // MARK: object lifecycle
  override public init(questionGroup: QuestionGroup) {
    super.init(questionGroup: questionGroup)
    let alphabeticalQuestions = self.questionGroup.questions.sorted(by: {$0.prompt < $1.prompt})
    self.questions = alphabeticalQuestions
  }
  
}
