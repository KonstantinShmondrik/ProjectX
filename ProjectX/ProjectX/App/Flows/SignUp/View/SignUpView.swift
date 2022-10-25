//
//  SignUPView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 21.10.2022.
//


import UIKit

protocol SignUpViewProtocol: AnyObject {
    func tapSignUPButton()
    func tapAddAvatarButton()
    
    
}

class SignUpView: UIView {
    
    // MARK: - Subviews
    private (set) lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: self.frame.height - 400, width: self.frame.width, height: 400)
        datePicker.backgroundColor = .white
        
        let yearAgo = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.maximumDate = yearAgo
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        return datePicker
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false
        
        return scrollView
    }()
    
    private(set) lazy var hederLabel: UILabel = {
        let label = UILabel()
        label.text = "[Sign-Up Page]"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private (set) lazy var avatarImage: UIImageView = {
        let image = UIImageView(frame: frame)
        image.image = UIImage(named: "noPhoto")
        image.layer.cornerRadius = 50
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private(set) lazy var addAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        button.setTitle("Add photo", for: .normal)
        button.addTarget(self, action: #selector(addAvatarButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
    private(set) lazy var dateOfBirthTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneAction))
        self.addGestureRecognizer(tapGesture)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpase, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    private(set) lazy var phoneNomberTexField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.attributedPlaceholder = NSAttributedString(string: "Phone nomber", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .black
        textField.keyboardType = .numberPad
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
    
    private(set) lazy var signUpButton: UIButton = {
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
         self.addAvatarButton,
         self.nameTexField,
         self.lastnameTexField,
         self.dateOfBirthTexField,
         self.passwordTexField,
         self.phoneNomberTexField,
         self.emailTexField,
         self.signUpButton
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
            self.avatarImage.heightAnchor.constraint(equalToConstant: 200.0),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 200.0),
            self.avatarImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.addAvatarButton.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 15.0),
            self.addAvatarButton.heightAnchor.constraint(equalToConstant: 20.0),
            self.addAvatarButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.addAvatarButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.nameTexField.topAnchor.constraint(equalTo: self.addAvatarButton.bottomAnchor, constant: 30.0),
            self.nameTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.nameTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.nameTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.lastnameTexField.topAnchor.constraint(equalTo: self.nameTexField.bottomAnchor, constant: 10.0),
            self.lastnameTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.lastnameTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.lastnameTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.dateOfBirthTexField.topAnchor.constraint(equalTo: self.lastnameTexField.bottomAnchor, constant: 10.0),
            self.dateOfBirthTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.dateOfBirthTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.dateOfBirthTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.phoneNomberTexField.topAnchor.constraint(equalTo: self.dateOfBirthTexField.bottomAnchor, constant: 10.0),
            self.phoneNomberTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.phoneNomberTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.phoneNomberTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.emailTexField.topAnchor.constraint(equalTo: self.phoneNomberTexField.bottomAnchor, constant: 10.0),
            self.emailTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.emailTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.emailTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.passwordTexField.topAnchor.constraint(equalTo: self.emailTexField.bottomAnchor, constant: 10.0),
            self.passwordTexField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTexField.widthAnchor.constraint(equalToConstant: 350.0),
            self.passwordTexField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            self.signUpButton.topAnchor.constraint(equalTo: self.passwordTexField.bottomAnchor, constant: 30.0),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.signUpButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
        ])
        
    }
    
    // MARK: - private func
    
    private func setupControls() {
        signUpButton.backgroundColor = UIColor.opaqueSeparator
        signUpButton.isEnabled = false
        
        [nameTexField, lastnameTexField, emailTexField, phoneNomberTexField, dateOfBirthTexField, passwordTexField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }
    
    private func isFormFilled() -> Bool {
        guard nameTexField.text != "",
              lastnameTexField.text != "",
              phoneNomberTexField.text != "",
              dateOfBirthTexField.text != "",
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
    
    private func getDateFromPicer() {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy"
        dateOfBirthTexField.text = formater.string(from: datePicker.date)
        
    }
    
    
    // MARK: - Actions
    
    @objc private func registButtonPressed() {
        
        delegate?.tapSignUPButton()
        
    }
    
    @objc private func addAvatarButtonPressed() {
        
        delegate?.tapAddAvatarButton()
        
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
            signUpButton.backgroundColor = UIColor.opaqueSeparator
            signUpButton.isEnabled = false
            return
        }
        signUpButton.backgroundColor = .blue
        signUpButton.isEnabled = true
    }
    
    @objc func doneAction() {
        getDateFromPicer()
        self.endEditing(true)
    }
    
    @objc func dateChange() {
        getDateFromPicer()
        
    }
    
}
