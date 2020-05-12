//
//  QuizView.swift
//  QuizzApp
//
//  Created by Iva Bogdanovic Radovic on 12/05/2020.
//  Copyright © 2020 Filip Radovic. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    @IBOutlet var QuizV: UIView!
    @IBOutlet weak var QuizQuestion: UILabel!
    @IBOutlet weak var qOne: UIButton!
    @IBOutlet weak var qTwo: UIButton!
    @IBOutlet weak var qThree: UIButton!
    @IBOutlet weak var qFour: UIButton!
    
    var answer : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("QuizView", owner: self, options: nil)
        addSubview(QuizV)
        QuizV.frame = self.bounds
        QuizV.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func questionInit(question : Question){
        self.QuizQuestion.text = question.question
        self.qOne.setTitle(question.answers[0], for: .normal)
        self.qOne.backgroundColor = UIColor.black
        self.qTwo.setTitle(question.answers[1], for: .normal)
        self.qTwo.backgroundColor = UIColor.black
        self.qThree.setTitle(question.answers[2], for: .normal)
        self.qThree.backgroundColor = UIColor.black
        self.qFour.setTitle(question.answers[3], for: .normal)
        self.qFour.backgroundColor = UIColor.black
        self.answer = question.correctAnswer
    }
    
    @IBAction func questionAnswer(sender: UIButton) {
        if ( sender.tag == self.answer){
            sender.backgroundColor = UIColor.green
        } else{
            sender.backgroundColor = UIColor.red
        }
    }
    
}

