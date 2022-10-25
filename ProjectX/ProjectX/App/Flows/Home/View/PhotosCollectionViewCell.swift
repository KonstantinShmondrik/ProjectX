//
//  PhotosCollectionViewCell.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 24.10.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "PhotosCollectionViewCell"
    
    // MARK: - Outlets
    private let conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsContent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Actions
extension PhotosCollectionViewCell {
    
    @objc func favoritPressed() {
        print ("Press button to favorit")
        
    }
}

// MARK: - Configure UI
private extension PhotosCollectionViewCell {
    
    func addSubviewsContent() {
        self.backgroundColor = .white
        self.addSubview(self.conteinerView)
        self.conteinerView.addSubview(self.pictureImageView)
       
    }
    
    func configureUI() {
        
        NSLayoutConstraint.activate([
            self.conteinerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.conteinerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.conteinerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.conteinerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.pictureImageView.topAnchor.constraint(equalTo: self.conteinerView.topAnchor, constant: 0.0),
            self.pictureImageView.leftAnchor.constraint(equalTo: self.conteinerView.leftAnchor,constant: 0.0),
            self.pictureImageView.rightAnchor.constraint(equalTo: self.conteinerView.rightAnchor,constant: 0.0),
            self.pictureImageView.bottomAnchor.constraint(equalTo: self.conteinerView.bottomAnchor,constant: 0.0),
            
        ])
    }
}

