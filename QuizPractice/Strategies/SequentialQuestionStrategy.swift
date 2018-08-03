//
//  SequentialQuestionStrategy.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {
  // Actually, since the default questions are ordered sequentially, this is the base strategy.
  // All we need to do is run our own init method (which is really the base strategy's init)
  
  // MARK: object lifecycle
  override public init(questionGroup: QuestionGroup) {
    super.init(questionGroup: questionGroup)
  }
  
}
