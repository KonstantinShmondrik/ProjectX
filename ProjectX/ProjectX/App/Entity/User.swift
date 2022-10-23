//
//  User.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 23.10.2022.
//

import Foundation



class User {
    
    var firstname: String?
    var lastname: String?
    var phoneNomber: String?
    var email: String?
    var dateOfBirth: String?
    var avatarURL: String?
    var uid: String?
    
    init(firstname: String? = nil, lastname: String? = nil, phoneNomber: String? = nil, email: String? = nil, dateOfBirth: String? = nil, avatarURL: String? = nil, uid: String? = nil) {
        self.firstname = firstname
        self.lastname = lastname
        self.phoneNomber = phoneNomber
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.avatarURL = avatarURL
        self.uid = uid
    }

}



