//
//  AddPhotoViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

class AddPhotoViewController: UIViewController {

    private var addPhotoView: AddPhotoView {
        return self.view as! AddPhotoView
    }
    
 
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = AddPhotoView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }
   

}

// MARK: - AddPhotoViewProtocol
extension AddPhotoViewController: AddPhotoViewProtocol {
    
    func tapAddPhotoButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func tapUploadPhotoButton() {
        print("tap upload photo")
        addPhotoView.photoImage.image = nil
        self.tabBarController?.selectedIndex = 1
    }
}

// MARK: - UIImagePickerControllerDelegate

    extension AddPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        addPhotoView.photoImage.image = image
    }
}

