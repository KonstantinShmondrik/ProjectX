//
//  AppPhotos.swift
//  ProjectX
//
//  Created by Константин Шмондрик on 24.10.2022.
//

import Foundation

class AppPhotos {
    static let shared = AppPhotos()
    init(){}
    
    var items: [Photo] = []
}
