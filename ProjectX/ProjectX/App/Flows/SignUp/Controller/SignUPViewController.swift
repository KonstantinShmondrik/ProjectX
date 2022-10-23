//
//  SignUPViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class SignUPViewController: UIViewController {
    
    private var signUpView: SignUpView {
        return self.view as! SignUpView
    }
    
    var urlString = ""
    
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
    
    func upload(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("phptos").child(currentUserId).child("avatars").child(currentUserId)
        
        guard let imageData = signUpView.avatarImage.image?.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
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
            self.upload(currentUserId: result.user.uid,
                        photo: self.signUpView.avatarImage.image!) { (uploadResult) in
                switch uploadResult {
                case .success(let url):
                    self.urlString = url.absoluteString
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": self.signUpView.nameTexField.text ?? "",
                        "lastname": self.signUpView.lastnameTexField.text ?? "",
                        "phoneNomber": self.signUpView.phoneNomberTexField.text ?? "",
                        "e-mail": self.signUpView.emailTexField.text ?? "",
                        "dateOfBirth": self.signUpView.dateOfBirthTexField.text ?? "",
                        "avatarURL": url.absoluteString,
                        "uid": result.user.uid
                    ]) { (error) in
                        if let error = error {
                            completion(.failure(error))
                        }
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension SignUPViewController: SignUpViewProtocol {
    
    func tapAddAvatarButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
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
// MARK: - UITextFieldDelegate
extension SignUPViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = PhoneNomberFormater().format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SignUPViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        signUpView.avatarImage.image = image
    }
}
