//
//  HomeViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 22.10.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class HomeViewController: UIViewController {
    
    private var homeView: HomeView {
        return self.view as! HomeView
    }
    
    let id = Auth.auth().currentUser!.uid
       let email = Auth.auth().currentUser!.email
    var user = User(firstname: "", lastname: "", phoneNomber: "", email: "", dateOfBirth: "", avatarURL: "", uid: "")
    var photos = AppPhotos.shared.items

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
        print("\(AppPhotos.shared.items)")
        let photo = AppPhotos.shared.items
        self.photos = photo
        homeView.collectionView.reloadData()
    }

    override func loadView() {
        super.loadView()
        let view = HomeView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
//        view.collectionView.reloadData()
        //        view.delegate = self
        self.view = view
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getName { (name) in
            if let name = name {
                self.downloadUsersData(urlString: self.user.avatarURL ?? "")
                self.homeView.userNameLabel.text = "\(self.user.firstname ?? "") \(self.user.lastname ?? "")"
                self.homeView.userAgeLabel.text = "\(self.user.dateOfBirth ?? "")"
                
                print("\(name)")
            }
        }
        
        
    }
    
    // MARK: - private func
    
    private func downloadUsersData(urlString: String) {
        
        let ref = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
                return }
            let image = UIImage(data: imageData)
            self.homeView.avatarImage.image = image
        }
        
    }

    private func getName(completion: @escaping (_ name: String?) -> Void) {
            guard let uid = Auth.auth().currentUser?.uid else {
                completion(nil)
                return
            }

        let docRef = Firestore.firestore().collection("users_\(uid)").document("User_data")
        docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    let firstname = document.get("firstname") as? String
                    let lastname = document.get("lastname") as? String
                    let phoneNomber = document.get("phoneNomber") as? String
                    let email = document.get("email") as? String
                    let dateOfBirth = document.get("dateOfBirth") as? String
                    let avatarURL = document.get("avatarURL") as? String
                    let uid = document.get("uid") as? String
                    self.user = User(firstname: firstname,
                                     lastname: lastname,
                                     phoneNomber: phoneNomber,
                                     email: email,
                                     dateOfBirth: dateOfBirth,
                                     avatarURL: avatarURL,
                                     uid: uid)
                    
//                    self.downloadUsersData(urlString: self.user.avatarURL ?? "")

                } else {
                    print("Document does not exist")
                }
                completion("put the first name data here after we figure out what's in the doc")
            }
        }
    
    // MARK: - private func
    


}

extension HomeViewController: HomeViewProtocol {
    func showPhotoDitail() {
        print("нажата ячейка")
    }
    
    
}


// MARK: - UICollectionViewDelegate
extension HomeView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PhotosCollectionViewCell = collectionView.cell(forRowAt: indexPath) else { return UICollectionViewCell() }

        cell.backgroundColor = .gray
        
        let photo = photos[indexPath.item]
        cell.pictureImageView.image = photo.photo

        cell.layoutIfNeeded()
        return cell
    }
}

// MARK: - DidSelectItemAt
extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.showPhotoDitail()
        print("нажата ячейка \(indexPath.item)")
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.width - 15 - 15)/3,
                     height: (collectionView.frame.width - 15 - 15)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}


