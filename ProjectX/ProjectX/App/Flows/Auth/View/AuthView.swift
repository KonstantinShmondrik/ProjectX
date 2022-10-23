//
//  AuthView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//

import UIKit


protocol AuthViewProtocol: AnyObject {
    func tapLoginButton(userName: String, password: String)
    func tapRegistButton()
    
}

class AuthView: UIView {
    
    // MARK: - Subviews
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false

        return scrollView
    }()
    
    private(set) lazy var hederLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to ProjectX"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var loginTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "e-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var passwordTexField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .bezel
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Sign In", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 16.0
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private(set) lazy var signUPButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 16.0
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(registButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Properties
    weak var delegate: AuthViewProtocol?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.setupControls()
        self.registerNotifications()
        self.hideKeyboardGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.loginTexField)
        self.scrollView.addSubview(self.hederLabel)
        self.scrollView.addSubview(self.passwordTexField)
        self.scrollView.addSubview(self.loginButton)
        self.scrollView.addSubview(self.signUPButton)
        
        NSLayoutConstraint.activate([
            
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.hederLabel.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 20),
            self.hederLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.hederLabel.widthAnchor.constraint(equalToConstant: 400.0),
            self.hederLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.loginTexField.topAnchor.constraint(lessThanOrEqualTo: self.hederLabel.bottomAnchor, constant: 50),
            self.loginTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.loginTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.loginTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.passwordTexField.topAnchor.constraint(equalTo: self.loginTexField.bottomAnchor, constant: 20.0),
            self.passwordTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.passwordTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTexField.bottomAnchor, constant: 30.0),
            self.loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.loginButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.loginButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.signUPButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20.0),
            self.signUPButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.signUPButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.signUPButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
        ])
    }
    
    // MARK: - private func
    
    private func setupControls() {
        loginButton.backgroundColor = UIColor.opaqueSeparator
        loginButton.isEnabled = false
        
        [loginTexField, passwordTexField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }
    
    private func isFormFilled() -> Bool {
        guard loginTexField.text != "",
              passwordTexField.text != "" else {
            return false
        }
        return true
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func hideKeyboardGesture() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonPressed() {
        let userName = loginTexField.text ?? ""
        let password = passwordTexField.text ?? ""
        delegate?.tapLoginButton(userName: userName, password: password)
        loginTexField.text = ""
        passwordTexField.text = ""
        
    }
    
    @objc private func registButtonPressed() {
        delegate?.tapRegistButton()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        
        keyboardFrame = self.scrollView.convert(keyboardFrame, from: nil)
        
        contentInset.bottom = keyboardFrame.size.height + 50
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard isFormFilled() else {
            loginButton.backgroundColor = UIColor.opaqueSeparator
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
}
