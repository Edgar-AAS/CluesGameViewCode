//
//  ViewController.swift
//  Challenge3
//
//  Created by Edgar Arlindo on 20/07/22.
//

import UIKit

final class CluesViewController: UIViewController {
    private lazy var customView: CluesScreen? = {
        return view as? CluesScreen
    }()
    
    private var quizManager = CluesViewModel()
    
    override func loadView() {
        view = CluesScreen(delegate: self)
        setButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView?.clueLabel.text = self.quizManager.getClueTextLabel()
        quizManager.startGame()
        customView?.letterLabel.text = quizManager.getLastAssertWords()
    }
    
    private func getAlertHandler() {
        quizManager.letters.shuffle()
        let solutionWord = quizManager.getSolutionWord
        var message = String()
        var title = String()
        
        if quizManager.currentLevelPosition < 5 {
            if customView?.letterLabel.text == solutionWord {
                quizManager.currentLevelPosition += 1
                title = "Correct Answer"
                message = "Let's go to next!"
                showAlert(message: message, title: title)
            } else {
                title = "Incorrect answer"
                message = "Try again"
                showAlert(message: message, title: title)
            }
        } else {
            showFinalAlert()
        }
    }
//MARK: - UIAlertControllers
    private func showAlert(message: String, title: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "GO", style: .default, handler: { _ in
            self.customView?.clueLabel.text = self.quizManager.getClueTextLabel()
            self.quizManager.prepareSecretWord()
            self.customView?.letterLabel.text = self.quizManager.getLastAssertWords()
            self.quizManager.showAllButtons()
        }))
        present(ac, animated: true, completion: nil)
    }
    
    private func showFinalAlert() {
        let finalAlert = UIAlertController(title: "Final", message: "Congratulations!", preferredStyle: .alert)
        finalAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.quizManager.currentLevelPosition = 0
            self.quizManager.score = 0
            self.customView?.clueLabel.text = self.quizManager.getClueTextLabel()
            self.quizManager.prepareSecretWord()
            self.customView?.letterLabel.text = self.quizManager.getLastAssertWords()
            self.setScoreText()
            self.quizManager.showAllButtons()
        }))
        present(finalAlert, animated: true)
    }

//MARK: - Grid buttons
    private func setButtons() {
        let widht = 80
        let height = 44

        if quizManager.letterButtons.count == quizManager.letters.count {
            for row in 0..<8 {
                for col in 0..<5 {
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
                    letterButton.setTitle("W", for: .normal)
                    
                    letterButton.addTarget(self, action: #selector(tappedLetterButton(sender:)), for: .touchUpInside)

                    let frame = CGRect(x: row*widht, y: col*height, width: widht, height: height)
                    letterButton.frame = frame

                    customView?.buttonsSubView.addSubview(letterButton)
                    quizManager.letterButtons.append(letterButton)
                }
            }
        }
    }
    
    private func setScoreText() {
         customView?.labelScore.text = "Score: \(quizManager.score)"
     }
    
    @objc func tappedLetterButton(sender: UIButton) {
        quizManager.didLetterButtonTapped(sender: sender)
        customView?.letterLabel.text = quizManager.getLastAssertWords()
        setScoreText()
    }
}

//MARK: - CluesScreenDelegate
extension CluesViewController: CluesScreenDelegate {
    func didSubmitTapped() {
        getAlertHandler()
    }
}
