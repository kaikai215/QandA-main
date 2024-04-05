//
//  ViewController.swift
//  QandA
//
//  Created by Ryan on 2024/4/4.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    //選項按鈕
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    
    //重新開始按鈕
    @IBOutlet weak var restartButton: UIButton!
    
    
    var questions = [Question]()
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = randomizeQuestion(QuestionData.questions)
        restartGame()
        logoLabel.font = UIFont(name: "Humour-Normal", size: 45)
        scoreLabel.isHidden = true
        
    }
    
    
    
    //畫面題目
    func displayQuestion(){
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.text
        option1Button.setTitle(currentQuestion.option1, for: .normal)
        option2Button.setTitle(currentQuestion.option2, for: .normal)
    }
    
    //檢查答案
    func checkAnswer(selectedOption: String){
        let currectQuestion = questions[currentQuestionIndex]
        if selectedOption == currectQuestion.correctAnswer {
            score += 1
        }
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayQuestion()
        }else {
            showScore()
            scoreLabel.isHidden = false
        }
        
    }
    
    //顯示數字
    func showScore(){
        questionLabel.text = "結束～"
        option1Button.isHidden = true
        option2Button.isHidden = true
        restartButton.isHidden = false
        scoreLabel.isHidden = true
        scoreLabel.text = "分數: \(score)/\(questions.count)"
    }
    
    
    @IBAction func optionSelected(_ sender: UIButton) {
        let selectedOption = sender.title(for: .normal)!
        checkAnswer(selectedOption: selectedOption)
        
    }
    
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        option1Button.isHidden = false
        option2Button.isHidden = false
        scoreLabel.isHidden = true
        restartGame()
        
    }
    
    //資料清除
    func restartGame(){
        currentQuestionIndex = 0
        score = 0
        displayQuestion()
        restartButton.isHidden = true // 在重新開始遊戲時隱藏重新開始按鈕
    }
    
    //隨機選擇10題
    func randomizeQuestion (_ questions:[Question]) -> [Question] {
        var shuffledQuestions = questions
        shuffledQuestions.shuffle()
        return Array(shuffledQuestions.prefix(10))
    }

}


