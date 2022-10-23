//
//  SignUPView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//


import UIKit

protocol SignUpViewProtocol: AnyObject {
    func tapSignUPButton()
    
}

class SignUpView: UIView {
    
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
        label.text = "Registration"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private (set) lazy var avatarImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.clipsToBounds = true
        image.layer.cornerRadius = image.bounds.width / 2
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UIGestureRecognizer(target: self, action: #selector(tapAvatarImage))
        image.addGestureRecognizer(tap)
        
        return image
    }()
    
    private(set) lazy var nameTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var lastnameTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var phoneNomberTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Phone nomber", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var emailTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var passwordTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private(set) lazy var registButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Sign Up", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 16.0
        button.addTarget(self, action: #selector(registButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // MARK: - Properties
    weak var delegate: SignUpViewProtocol?
    
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
        
        [self.hederLabel,
         self.avatarImage,
         self.nameTexField,
         self.lastnameTexField,
         self.passwordTexField,
         self.emailTexField,
         self.registButton
        ].forEach {
            self.scrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.hederLabel.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor, constant: 20),
            self.hederLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.hederLabel.widthAnchor.constraint(equalToConstant: 400.0),
            self.hederLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.avatarImage.topAnchor.constraint(lessThanOrEqualTo: self.hederLabel.bottomAnchor, constant: 20),
            self.avatarImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.nameTexField.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 10.0),
            self.nameTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.nameTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.nameTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.lastnameTexField.topAnchor.constraint(equalTo: self.nameTexField.bottomAnchor, constant: 10.0),
            self.lastnameTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.lastnameTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.lastnameTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.emailTexField.topAnchor.constraint(equalTo: self.lastnameTexField.bottomAnchor, constant: 10.0),
            self.emailTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.emailTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.emailTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.passwordTexField.topAnchor.constraint(equalTo: self.emailTexField.bottomAnchor, constant: 10.0),
            self.passwordTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.passwordTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.registButton.topAnchor.constraint(equalTo: self.passwordTexField.bottomAnchor, constant: 30.0),
            self.registButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.registButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.registButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
        ])
        
    }
    
    // MARK: - private func
    
    private func setupControls() {
        registButton.backgroundColor = UIColor.opaqueSeparator
        registButton.isEnabled = false
        
        [nameTexField, lastnameTexField, emailTexField, passwordTexField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }
    
    private func isFormFilled() -> Bool {
        guard nameTexField.text != "",
              lastnameTexField.text != "",
              emailTexField.text != "",
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
    
    @objc private func registButtonPressed() {
        
        delegate?.tapSignUPButton()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
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
            registButton.backgroundColor = UIColor.opaqueSeparator
            registButton.isEnabled = false
            return
        }
        registButton.backgroundColor = .blue
        registButton.isEnabled = true
    }
    
    @objc func tapAvatarImage(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 0.75,
                       options: [.allowUserInteraction],
                       animations: {
            self.bounds = self.bounds.insetBy(dx: 20, dy: 20)
        },
                       completion: nil)
    }
    
}
