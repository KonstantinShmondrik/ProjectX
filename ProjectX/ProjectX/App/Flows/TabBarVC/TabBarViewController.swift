//
//  TabBarViewController.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        let addPhotoVC = AddPhotoViewController()
        
        let tabBarItemAddPhoto = UITabBarItem(title: "",
                                              image: UIImage(systemName: "plus.app"),
                                              selectedImage: UIImage(systemName: "plus.fill"))
        
        addPhotoVC.tabBarItem = tabBarItemAddPhoto
        
        
        let homeVC = HomeViewController()
        
        let tabBarItemHome = UITabBarItem(title: "",
                                          image: UIImage(systemName: "person.crop.circle"),
                                          selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        homeVC.tabBarItem = tabBarItemHome
        
        self.viewControllers = [addPhotoVC, homeVC]
        
        self.selectedIndex = 1

    }
}
