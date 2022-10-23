//
//  HomeView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Subviews
    
    private (set) lazy var conteinerView: UIView = {
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private (set) lazy var hederView: UIView = {
        let view = UIView(frame: frame)
//        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var userAgeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private (set) lazy var avatarImage: UIImageView = {
        let image = UIImageView(frame: frame)
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
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
        
        [self.hederView
        ].forEach {
            self.conteinerView.addSubview($0)
        }
        
        [self.avatarImage,
         self.userNameLabel,
         self.userAgeLabel,
        ].forEach {
            self.hederView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.conteinerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.conteinerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.conteinerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.conteinerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.hederView.topAnchor.constraint(equalTo: self.conteinerView.topAnchor, constant: 0),
            self.hederView.trailingAnchor.constraint(equalTo: self.conteinerView.trailingAnchor, constant: 0),
            self.hederView.leadingAnchor.constraint(equalTo: self.conteinerView.leadingAnchor, constant: 0),
            self.hederView.heightAnchor.constraint(equalToConstant: 150),
            
            self.avatarImage.leftAnchor.constraint(equalTo: self.hederView.leftAnchor, constant: 10),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImage.heightAnchor.constraint(equalToConstant: 100),
            self.avatarImage.centerYAnchor.constraint(equalTo: self.hederView.centerYAnchor),
            
            self.userNameLabel.leftAnchor.constraint(equalTo: self.avatarImage.rightAnchor, constant: 20),
            self.userNameLabel.topAnchor.constraint(equalTo: self.avatarImage.topAnchor, constant: 20),
            
            self.userAgeLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 10),
            self.userAgeLabel.leftAnchor.constraint(equalTo: self.avatarImage.rightAnchor, constant: 20),
            
        ])
        
    }
    
}
