//
//  ViewController.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import UIKit

// MARK:  QuestionViewControllerDelegate
protocol QuestionViewControllerDelegate: class {

  func questionViewController(
    _ viewController: QuestionViewController,
    didCancel questionGroup: QuestionGroup,
    at questionIndex: Int)

  func questionViewController(
    _ viewController: QuestionViewController,
    didComplete questionGroup: QuestionGroup)
}

class QuestionViewController: UIViewController {
  
  // MARK: outlets
  @IBOutlet weak var promptLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var answerButton: UIButton!
  @IBOutlet weak var numCorrectLabel: UILabel!
  @IBOutlet weak var numAttemptedLabel: UILabel!
  
  // MARK: instance variable
  public var questionGroup = QuestionGroup.intQuestions()  // we will let them choose in later iterations
  public var questionIndex = 0
  public var correctCount = 0
  public var questionCount = 0
  public var delegate: QuestionViewControllerDelegate?

  
  // MARK: actions
  @IBAction func correctTapped(_ sender: Any) {
    correctCount += 1
    questionCount += 1
    numCorrectLabel.text = "\(correctCount)"
    numAttemptedLabel.text = "\(questionCount)"
    showNextQuestion()
  }
  
  @IBAction func wrongTapped(_ sender: Any) {
    questionCount += 1
    numCorrectLabel.text = "\(correctCount)"
    numAttemptedLabel.text = "\(questionCount)"
    showNextQuestion()
  }
  
  
  @IBAction func showAnswerLabel(_ sender: Any) {
    answerButton.isHidden = true
    answerLabel.isHidden = false
  }

  // MARK: question management
  private func showQuestion() {
    let question = questionGroup.questions[questionIndex]
    answerLabel.text = question.answer
    promptLabel.text = question.prompt
    answerLabel.isHidden = true
    answerButton.isHidden = false
  }
  
  private func showNextQuestion() {
    questionIndex += 1
    guard questionIndex < questionGroup.questions.count else {
      delegate?.questionViewController(self, didComplete: questionGroup)

      return
    }
    showQuestion()
  }
  
  // MARK: viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
//    setupCancelButton()
    navigationItem.title = questionGroup.title
    numCorrectLabel.text = "0"
    numAttemptedLabel.text = "0"
    showQuestion()
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

