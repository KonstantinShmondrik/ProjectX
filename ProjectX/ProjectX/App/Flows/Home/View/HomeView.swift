//
//  HomeView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

protocol HomeViewProtocol {
    
    func showPhotoDitail()
}
 
class HomeView: UIView {
    
    // MARK: - Properties
   
    var photo: [Photo]?
    var delegate: HomeViewProtocol?
    
    // MARK: - Subviews
    
    private (set) lazy var conteinerView: UIView = {
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private (set) lazy var hederView: UIView = {
        let view = UIView(frame: frame)
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
    
    private(set) lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.borderWidth = 1
        collectionView.layer.backgroundColor = .init(gray: 1, alpha: 0.5)
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layoutIfNeeded()
        collectionView.registerClass(PhotosCollectionViewCell.self)
        
        return collectionView
        
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviewsContent()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    // MARK: - UI
    
    func addSubviewsContent() {
        self.backgroundColor = .white
        self.addSubview(self.conteinerView)
        
        [self.hederView,
         self.collectionView
        ].forEach {
            self.conteinerView.addSubview($0)
        }
        
        [self.avatarImage,
         self.userNameLabel,
         self.userAgeLabel,
        ].forEach {
            self.hederView.addSubview($0)
        }
    }
    
    private func configureUI() {
       
        
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
            
            self.collectionView.topAnchor.constraint(equalTo: self.hederView.bottomAnchor, constant: 0.0),
            self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
        ])
    }
}
