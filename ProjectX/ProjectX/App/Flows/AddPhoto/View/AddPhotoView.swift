//
//  AddPhotoView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

protocol AddPhotoViewProtocol: AnyObject {
    
    func tapAddPhotoButton()
    func tapUploadPhotoButton()
    
}

class AddPhotoView: UIView {
    
    // MARK: - Subviews
    
    private (set) lazy var conteinerView: UIView = {
        let image = UIView(frame: frame)
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    private(set) lazy var hederLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Photo"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private (set) lazy var photoImage: UIImageView = {
        let image = UIImageView(frame: frame)
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private(set) lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        button.setTitle("Add photo", for: .normal)
        button.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private(set) lazy var uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .systemBlue
        button.setTitle("Upload", for: .normal)
        button.addTarget(self, action: #selector(uploadPhotoButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
//     MARK: - Properties
    weak var delegate: AddPhotoViewProtocol?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(self.conteinerView)
        
        [self.hederLabel,
         self.photoImage,
         self.addPhotoButton,
         self.uploadPhotoButton,
        ].forEach {
            self.conteinerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.conteinerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.conteinerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.conteinerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.conteinerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.hederLabel.topAnchor.constraint(lessThanOrEqualTo: self.conteinerView.topAnchor, constant: 20),
            self.hederLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.hederLabel.widthAnchor.constraint(equalToConstant: 400.0),
            self.hederLabel.centerXAnchor.constraint(equalTo: self.conteinerView.centerXAnchor),
            
            self.photoImage.topAnchor.constraint(lessThanOrEqualTo: self.hederLabel.bottomAnchor, constant: 20),
            self.photoImage.heightAnchor.constraint(equalToConstant: 350),
            self.photoImage.widthAnchor.constraint(equalToConstant: 350),
            self.photoImage.centerXAnchor.constraint(equalTo: self.conteinerView.centerXAnchor),
            
            self.addPhotoButton.topAnchor.constraint(equalTo: self.photoImage.bottomAnchor, constant: 30.0),
            self.addPhotoButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.addPhotoButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.addPhotoButton.centerXAnchor.constraint(equalTo: self.conteinerView.centerXAnchor),
            
            self.uploadPhotoButton.topAnchor.constraint(equalTo: self.addPhotoButton.bottomAnchor, constant: 30.0),
            self.uploadPhotoButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.uploadPhotoButton.widthAnchor.constraint(equalToConstant: 250.0),
            self.uploadPhotoButton.centerXAnchor.constraint(equalTo: self.conteinerView.centerXAnchor)
        ])
        
    }
    
    // MARK: - private func
    
  
    
    private func isFormFilled() -> Bool {
        guard photoImage.image != nil else {
            return false
        }
        return true
    }
    
    // MARK: - Actions
    
    @objc private func addPhotoButtonPressed() {
        
        delegate?.tapAddPhotoButton()
        
    }
    
    @objc private func uploadPhotoButtonPressed() {
        
        delegate?.tapUploadPhotoButton()
        
    }
    
    

    
   
   

}
