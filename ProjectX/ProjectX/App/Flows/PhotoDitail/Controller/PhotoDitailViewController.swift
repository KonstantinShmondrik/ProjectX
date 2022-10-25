//
//  PhotoDitailViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 25.10.2022.
//

import UIKit

class PhotoDitailViewController: UIViewController {
    
    private var photoDitailView: PhotoDitailView {
        return self.view as! PhotoDitailView
    }
    
    var user: User
    var photo: Photo
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = PhotoDitailView()
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        photoDitailView.configure(user: user, photo: photo)
        
    }
    
    init(user: User, photo: Photo) {
        self.user = user
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
