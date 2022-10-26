//
//  PhotoDitailView.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 25.10.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class PhotoDitailView: UIView  {
    
    // MARK: - Subviews
    
    private (set) lazy var hederView: UIView = {
        let view = UIView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20.0)
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
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.numberOfLines = 1
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private (set) lazy var photoImage: UIImageView = {
        let image = UIImageView(frame: frame)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
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
    
    // MARK: - ConfigureView
    
    func configure(user: User, photo: Photo) {
        self.userNameLabel.text = "\(user.firstname ?? "") \(user.lastname ?? "")"
        self.photoImage.image = photo.photo ?? UIImage(named: "noPhoto")
        
        let ref = Storage.storage().reference(forURL: user.avatarURL ?? "")
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
                return }
            let image = UIImage(data: imageData)
            self.avatarImage.image = image
        }
        
        let dateFormater: DateFormatter = {
            let result = DateFormatter()
            result.dateFormat = "dd.MM.yyyy HH.mm"
            return result
        }()
        
        let stringDate = dateFormater.string(from: photo.dateUpload ?? Date())
        self.dateLabel.text = stringDate
        
        print(photo.videoUrl)
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(self.photoImage)
        self.addSubview(self.hederView)
        self.hederView.addSubview(self.userNameLabel)
        self.hederView.addSubview(self.avatarImage)
        self.photoImage.addSubview(self.dateLabel)
        
        NSLayoutConstraint.activate([
            
            self.hederView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.hederView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.hederView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.hederView.heightAnchor.constraint(equalToConstant: 150),
            
            self.avatarImage.leftAnchor.constraint(equalTo: self.hederView.leftAnchor, constant: 10),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImage.heightAnchor.constraint(equalToConstant: 100),
            self.avatarImage.centerYAnchor.constraint(equalTo: self.hederView.centerYAnchor),
            
            self.userNameLabel.leftAnchor.constraint(equalTo: self.avatarImage.rightAnchor, constant: 20),
            self.userNameLabel.centerYAnchor.constraint(equalTo: self.hederView.centerYAnchor),
            
            self.photoImage.topAnchor.constraint(equalTo: self.hederView.bottomAnchor, constant: 0.0),
            self.photoImage.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 0.0),
            self.photoImage.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: 0.0),
            self.photoImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0.0),
            
            self.dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.photoImage.bottomAnchor, constant: -20),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 30.0),
            self.dateLabel.rightAnchor.constraint(lessThanOrEqualTo: self.photoImage.rightAnchor, constant: -10)
        ])
        
    }
    
}
