//
//  ViewController.swift
//  QuizzApp
//
//  Created by Filip Radovic on 10/05/2020.
//  Copyright © 2020 Filip Radovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var state : Root!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var funLabelOut: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var QuestionView: QuizView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setQuizImage(data: Data){
        DispatchQueue.main.async {
            self.quizImage.image = UIImage(data: data)
        }
    }

    func buttonActionCompletion(obj: Root){
        DispatchQueue.main.async {
            self.state = obj
            var counter = 0
             for quiz in obj.quizzes {
                 for question in quiz.questions{
                     if question.question.contains("NBA") {
                         counter = counter + 1
                     }
                 }
            }
            self.funLabelOut.text = "Nba questions: " + String(counter)
            let quizIndex = Int.random(in: 0..<obj.quizzes.count)
            let quiz = obj.quizzes[quizIndex]
            var color = UIColor.red.cgColor
            if (quiz.category == "SPORTS"){
                color = UIColor.yellow.cgColor
            }
            self.quizLabel.text = quiz.quizDescription
            self.quizImage.layer.borderColor = color
            self.quizImage.layer.borderWidth = 2.0
            getImageApi(link: quiz.image, completion: self.setQuizImage)
            let questionIndex = Int.random(in: 0..<quiz.questions.count)
            let question = quiz.questions[questionIndex]
            self.QuestionView.questionInit(question: question)
        }
    }
    
    func buttonActionNonCompletion(){
        DispatchQueue.main.async {
          self.errorLabel.text = "Error couldnt fetch data"
          self.errorLabel.isHidden = false
        }
    }
    
    @IBAction func DohvatiBtnAction(_ sender: UIButton) {
        getQuizzApi(completion: buttonActionCompletion(obj:), noncompletion : buttonActionNonCompletion)
    }
    
}

