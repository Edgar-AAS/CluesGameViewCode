//
//  QuizManager.swift
//  Challenge3
//
//  Created by Edgar Arlindo on 30/08/22.
//

import UIKit

final class CluesManager {
    private var lettersLabels = [UILabel]()
    private var lastAssertWords = [Character]()

    var letterButtons = [UIButton]()
    var letters = [Character]()
    var currentLevelPosition: Int = 0
    var score: Int = 0
    
    private var solutions = [
        Solution(clue: "Um líquido universal", correctAnswer: "AGUA"), //4
        Solution(clue: "Pode ser azedo, porém muito calmo", correctAnswer: "MARACUJA"), //8
        Solution(clue: "Tem quatro pernas mas não é animal", correctAnswer: "CADEIRA"), //7
        Solution(clue: "Nem todo alimento verde precisa estar podre", correctAnswer: "GORGONZOLA"), //10
        Solution(clue: "Se tiver um espelho use-o, caso contrario, é melhor furar seus olhos!", correctAnswer: "MEDUSA"), //6
        Solution(clue: "Um explicador, semelhante a palavra tatu", correctAnswer: "TUTOR") //5
    ]
    
    var getSolutionWord: String {
        return solutions[currentLevelPosition].correctAnswer
    }

    func startGame() {
        letters = solutions.flatMap { $0.correctAnswer }
        letters.shuffle()
        
        prepareSecretWord()
        setupLetterKeyboard()
    }
    
    func prepareSecretWord() {
        lastAssertWords.removeAll()
        let solution = solutions[currentLevelPosition].correctAnswer
        
        for _ in solution {
            lastAssertWords.append(Character("-"))
        }
    }
    
    private func setupLetterKeyboard() {
        for i in 0..<letters.count {
            letterButtons[i].setTitle(String(letters[i]), for: .normal)
        }
    }
    
    func didLetterButtonTapped(sender: UIButton) {
        guard let tryLetter = sender.currentTitle else { return }
        
        setAssertsAnswer(answer: tryLetter)
        
        if !lastAssertWords.contains(Character(tryLetter)) {
            score -= 1
        }
    }
    
    func setAssertsAnswer(answer: String) {
        let solutionWord = solutions[currentLevelPosition].correctAnswer
        let tryLetterCharacter = Character(answer)
        let solutionArray = Array(solutionWord)
        
        if lastAssertWords.contains(tryLetterCharacter) {
            return
        }
        
        for i in 0..<solutionWord.count {
            if solutionArray[i] == tryLetterCharacter {
                lastAssertWords[i] = tryLetterCharacter
                score += 1
            }
        }
    }

    func getLastAssertWords() -> String {
        return String(lastAssertWords)
    }
    
    func getClueTextLabel() -> String {
        let text = solutions[currentLevelPosition].clue
        return text
    }
}
