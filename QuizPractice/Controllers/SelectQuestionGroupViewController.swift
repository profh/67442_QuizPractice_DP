//
//  SelectQuestionGroupViewController.swift
//  QuizPractice
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {

  // MARK: outlets
  @IBOutlet internal var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
    }
  }
  // MARK: properties
  private let appSettings = AppSettings.shared
  public let questionGroups = QuestionGroup.allGroups()
  private var selectedQuestionGroup: QuestionGroup!

  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
}


// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return questionGroups.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
    let questionGroup = questionGroups[indexPath.row]
    cell.titleLabel.text = questionGroup.title
    
    questionGroup.score.runningPercentage.addObserver(cell, options: [.initial, .new]) {
      [weak cell] (percentage, _) in
      DispatchQueue.main.async {
        cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))
      }
    }
    return cell
  }
}


// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    selectedQuestionGroup = questionGroups[indexPath.row]
    return indexPath
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let viewController = segue.destination
      as? QuestionViewController else { return }
    // viewController.questionGroup = selectedQuestionGroup
    // viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
    // viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
    viewController.questionStrategy = appSettings.questionStrategy(for: selectedQuestionGroup)
    viewController.delegate = self
  }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
  func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
    navigationController?.popToViewController(self, animated: true)
  }
  
  func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) {
    navigationController?.popToViewController(self, animated: true)
  }
}
