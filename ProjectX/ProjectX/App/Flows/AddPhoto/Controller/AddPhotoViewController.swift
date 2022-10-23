//
//  AddPhotoViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

class AddPhotoViewController: UIViewController {

    private var addPhoto: AddPhotoView {
        return self.view as! AddPhotoView
    }
    
 
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = AddPhotoView()
//        view.delegate = self
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
