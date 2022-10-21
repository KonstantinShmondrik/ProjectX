//
//  ViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit

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
    
    // MARK: - private func
    
    private func showError(_ errorMessage: String) {
      
        let alert = UIAlertController(title: "Ошибка авторизации",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func proceedToWelcomeScreen() {
       
//        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
    
}

// MARK: - AuthViewProtocol
extension AuthViewController: AuthViewProtocol {
    
    func tapLoginButton(userName: String, password: String) {
        
    }
    
    func tapRegistButton() {
        navigationController?.pushViewController(SignUPViewController(), animated: true)
    }

}

