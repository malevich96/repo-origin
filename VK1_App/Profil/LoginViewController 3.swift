//
//  LoginViewController.swift
//  Lesson1_LA
//
//  Created by Анатолий Левин on 28.02.2021.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
          // Второе — когда она пропадает
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    // Когда клавиатура появляется
      @objc func keyboardWasShown(notification: Notification) {
          
          // Получаем размер клавиатуры
          let info = notification.userInfo! as NSDictionary
          let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
          let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
          
          // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
          self.scrollView?.contentInset = contentInsets
          scrollView?.scrollIndicatorInsets = contentInsets
      }
      
      //Когда клавиатура исчезает
      @objc func keyboardWillBeHidden(notification: Notification) {
          // Устанавливаем отступ внизу UIScrollView, равный 0
        scrollView?.contentInset = .zero
        
      }
    
    @IBAction func buttonAction(_ sender: Any) {
    }
    
    @IBAction func backToLogin(unwinSeque: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toMain" {
            if loginTextField.text == "admin",
               passwordTextField.text == "123456" {
                return true
            } else {
                showErrorAlert()
                return false
            }
        }else{
            return super.shouldPerformSegue(withIdentifier: identifier, sender: self)
        }
    }
    func showErrorAlert()  {
        let alert = UIAlertController(title: "Ошибка", message: "Неверные данные пользователя", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
}

