//
//  QuestionViewController.swift
//  MarubatuApp
//
//  Created by 杉浦陽樹 on 2022/10/23.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions: [[String: Any]] = []
    
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var result: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func store(_ sender: Any) {
        let alertController = UIAlertController(title: "保存する", message: nil, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            if ((self.question.text?.first) != nil) {
                self.questions.append(["question":self.question.text!, "answer":self.result.selectedSegmentIndex])
                UserDefaults.standard.set(self.questions, forKey: "Q")
                self.question.text = nil
                print(self.questions)
            } else {
                self.showAlert(message: "入力してください")
            }
        }
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    
    @IBAction func allDelete(_ sender: Any) {
        let alertcontroller = UIAlertController(title: "削除しますか？", message: nil, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {(action: UIAlertAction) in
            self.questions.removeAll()
            UserDefaults.standard.set(self.questions, forKey: "Q")
            print(self.questions)
        }
        alertcontroller.addAction(ok)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel)
        alertcontroller.addAction(cancel)
        
        present(alertcontroller, animated: true)
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}
