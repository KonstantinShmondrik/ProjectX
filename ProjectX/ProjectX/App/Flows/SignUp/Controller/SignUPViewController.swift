//
//  SignUPViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit
import Firebase

class SignUPViewController: UIViewController {
    
    private var signUpView: SignUpView {
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
        signUpView.phoneNomberTexField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }
    
    func register(firstName: String?, lastname: String?, email: String?, phoneNomber: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        
        guard Validators.isFilled(firstname: signUpView.nameTexField.text,
                                  lastName: signUpView.lastnameTexField.text,
                                  dateOfBirth: signUpView.dateOfBirthTexField.text,
                                  email: signUpView.emailTexField.text,
                                  phoneNumber: signUpView.phoneNomberTexField.text,
                                  password: signUpView.passwordTexField.text) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        guard let firstName = firstName, let lastname = lastname, let email = email, let phoneNomber = phoneNomber, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isSimpleName(firstName) else {
            completion(.failure(AuthError.invalidFirstName))
            signUpView.nameTexField.text = ""
            return
        }
        
        guard Validators.isSimpleName(lastname) else {
            completion(.failure(AuthError.invalidLastName))
            signUpView.lastnameTexField.text = ""
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            signUpView.emailTexField.text = ""
            return
        }
        
        guard Validators.isSimplePhoneNomber(phoneNomber) else {
            completion(.failure(AuthError.invalidPhoneNomber))
            signUpView.phoneNomberTexField.text = ""
            return
        }
        
        guard Validators.isSimplePassword(password)  else {
            completion(.failure(AuthError.invalidPassword))
            signUpView.passwordTexField.text = ""
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: [
                "firstname": self.signUpView.nameTexField.text ?? "",
                "lastname": self.signUpView.lastnameTexField.text ?? "",
                "phoneNomber": self.signUpView.phoneNomberTexField.text ?? "",
                "e-mail": self.signUpView.emailTexField.text ?? "",
                "dateOfBirth": self.signUpView.dateOfBirthTexField.text ?? "",
                "uid": result.user.uid
            ]) { (error) in
                if let error = error {
                    completion(.failure(error))
                }
                completion(.success)
            }
        }
    }
    
    
    
    
}

extension SignUPViewController: SignUpViewProtocol {
    func tapaddAvatarButton() {
        print("press avatar")
    }
    
    func tapSignUPButton() {
        
        register(firstName: signUpView.nameTexField.text,
                 lastname: signUpView.lastnameTexField.text,
                 email: signUpView.emailTexField.text,
                 phoneNomber: signUpView.phoneNomberTexField.text,
                 password: signUpView.passwordTexField.text) { (result) in
            switch result {
            case .success:
                self.showAlert(with: "Successfully", and: "You are registered", completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    
    
}

extension SignUPViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = PhoneNomberFormater().format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
}
