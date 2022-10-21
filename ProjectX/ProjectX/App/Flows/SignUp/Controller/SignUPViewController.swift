//
//  SignUPViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit

class SignUPViewController: UIViewController {
    
    private var authView: SignUpView {
        return self.view as! SignUpView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = SignUpView()
        view.delegate = self
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }

   
}

extension SignUPViewController: SignUpViewProtocol {
    func tapaddAvatarButton() {
        print("press avatar")
    }
    
    func tapSignUPButton() {
        print("press SignUP")
    }
    
    
    
}
