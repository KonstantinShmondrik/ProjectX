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
        
        guard let login = self.authView.loginTexField.text, let password = self.authView.passwordTexField.text else {return}
        
        Auth.auth().signIn(withEmail: login, password: password) { (result, error) in
            if error != nil {
                self.showAlert(with: "Ohh...", and: error?.localizedDescription ?? error.debugDescription, completion: { print(error?.localizedDescription ?? error.debugDescription)
                })
            } else {
                self.showAlert(with: "Welcome", and: "You are logged in", completion: {
                    self.navigationController?.pushViewController(HomeViewController(), animated: true)
                })
            }
        }
        
    }
    
    func tapRegistButton() {
        navigationController?.pushViewController(SignUPViewController(), animated: true)
    }
    
}

