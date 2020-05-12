//
//  Util.swift
//  QuizzApp
//
//  Created by Filip Radovic on 11/05/2020.
//  Copyright © 2020 Filip Radovic. All rights reserved.
//

import Foundation


// MARK: - Root
struct Root: Codable {
    let quizzes: [Quiz]
}

// MARK: - Quiz
struct Quiz: Codable {
    let id: Int
    let title, quizDescription, category: String
    let level: Int
    let image: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case id, title
        case quizDescription = "description"
        case category, level, image, questions
    }
}

// MARK: - Question
struct Question: Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int

    enum CodingKeys: String, CodingKey {
        case id, question, answers
        case correctAnswer = "correct_answer"
    }
}

func getQuizzApi(completion: @escaping (Root) -> (), noncompletion: @escaping () -> ()) {
    let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        if let data = data {
           do {
              let response = try JSONDecoder().decode(Root.self, from: data)
              completion(response)
           } catch let error {
              print(error)
              noncompletion()
           }
        }
    }
    task.resume()
}

func getImageApi(link : String, completion: @escaping (Data) -> ()) {
    let url = URL(string: link)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    task.resume()
}
