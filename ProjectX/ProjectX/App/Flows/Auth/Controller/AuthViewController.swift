//
//  ViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    private var authView: AuthView {
        return self.view as! AuthView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = AuthView()
        view.delegate = self
        self.view = view
        
        view.loginTexField.text = "test3@test.ru"
        view.passwordTexField.text = "Zxc1zxc"
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

// MARK: - AuthViewProtocol
extension AuthViewController: AuthViewProtocol {
    
    func tapLoginButton(userName: String, password: String) {
        
        Auth.auth().signIn(withEmail: userName, password: password) { (result, error) in
            if error != nil {
                self.showAlert(with: "Ohh...", and: error?.localizedDescription ?? error.debugDescription, completion: { print(error?.localizedDescription ?? error.debugDescription)
                })
            } else {
                self.showAlert(with: "Welcome", and: "You are logged in", completion: {
                    self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    
                })
            }
        }
        
    }
    
    func tapRegistButton() {
        navigationController?.pushViewController(SignUPViewController(), animated: true)
    }
    
}

