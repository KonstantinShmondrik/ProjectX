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
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }
    
    override func loadView() {
        super.loadView()
        let view = HomeView()
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
    

    
    func getName(completion: @escaping (_ name: String?) -> Void) {
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
    
    

    
}
