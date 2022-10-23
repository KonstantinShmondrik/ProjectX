//
//  User.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import Foundation

class User {
    
    let firstname: String?
    let lastname: String?
    let phoneNomber: String?
    let email: String?
    let dateOfBirth: String?
    let avatarURL: String?
    let uid: String?
    let photos: [String]?
    
    init(firstname: String?, lastname: String?, phoneNomber: String?, email: String?, dateOfBirth: String?, avatarURL: String?, uid: String?, photos: [String]?) {
        self.firstname = firstname
        self.lastname = lastname
        self.phoneNomber = phoneNomber
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.avatarURL = avatarURL
        self.uid = uid
        self.photos = photos
    }
    
}
