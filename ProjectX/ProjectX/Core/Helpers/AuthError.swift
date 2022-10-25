//
//  AuthError.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 22.10.2022.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidFirstName
    case invalidLastName
    case invalidPassword
    case invalidEmail
    case invalidPhoneNomber
    case unknownError
    case serverError
    case photoNotExist
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("email is not valid", comment: "")
        case .invalidFirstName:
            return NSLocalizedString("Enter the name in Latin alphabet letters", comment: "")
        case .invalidLastName:
            return NSLocalizedString("Enter the lastname in Latin alphabet letters", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Password must contain at least 6 characters, must be number, lower case letter, upper case letter", comment: "")
        case .invalidPhoneNomber:
            return NSLocalizedString("Phone nomber is not valid", comment: "")
        case .unknownError:
            /// we will use server_error key to display user internal error
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Upload profile photo", comment: "")
        }
    }
}
