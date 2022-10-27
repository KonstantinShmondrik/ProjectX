//
//  AddPhotoViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit
import Firebase
import AVKit

class AddPhotoViewController: UIViewController {
    
    var videoURL: NSURL?
    var photo: Photo?
    
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
        navigationController?.navigationItem.hidesBackButton = true
    }
    
}

// MARK: - AddPhotoViewProtocol
extension AddPhotoViewController: AddPhotoViewProtocol {
    
    func tapAddPhotoButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func tapUploadPhotoButton() {
        
        photo = Photo(userID: Auth.auth().currentUser!.uid,
                      photo: addPhotoView.photoImage.image,
                      dateUpload: Date(),
                      videoUrl: videoURL)
        if photo?.photo != nil {
            AppPhotos.shared.items.append(photo ?? Photo())

            self.photo = nil
            self.videoURL = nil
            
            addPhotoView.photoImage.image = nil
            self.tabBarController?.selectedIndex = 1
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension AddPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL else {
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            addPhotoView.photoImage.image = image
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.videoURL = videoURL
        do {
            let asset = AVURLAsset(url: videoURL as URL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            addPhotoView.photoImage.image = thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}

