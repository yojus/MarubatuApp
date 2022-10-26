//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 杉浦陽樹 on 2022/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    
    // 問題
    var questions: [[String: Any]] = []
    
    func showQuestion() {
        let question = questions[currentQuestionNum]
        if let que = question["question"] as? String {
            label.text = que
        }
    }
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            
            if yourAnswer == ans {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解")
            } else {
                // 不正解
                showAlert(message: "不正解")
            }
        } else {
            print("答えが入ってません")
            return
        }
        
        // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.array(forKey: "Q")?.first != nil {
            questions = UserDefaults.standard.array(forKey: "Q") as! [[String:Any]]
            showQuestion()
        } else {
            label.text = "問題を入力してください"
        }
    }
    
    @IBAction func Nobutton(_ sender: UIButton) {
        if UserDefaults.standard.array(forKey: "Q")?.first != nil{
            checkAnswer(yourAnswer: false)
        } else {
            showAlert(message: "問題を入力してください")
        }
    }
    
    @IBAction func Okbutton(_ sender: UIButton) {
        if UserDefaults.standard.array(forKey: "Q")?.first != nil {
            checkAnswer(yourAnswer: true)
        } else {
            showAlert(message: "問題を入力してください")
        }
    }
    
    @IBAction func create(_ sender: Any) {
        performSegue(withIdentifier: "qvc", sender: nil)
    }
}
