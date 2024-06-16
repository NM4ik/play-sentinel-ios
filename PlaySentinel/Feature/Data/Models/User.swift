//
//  DBUser.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation
import Firebase
import FirebaseAuth


struct AppUser : Codable, Identifiable {
    let id : String
    let email : String?
    let photo : String?
    let name : String?
    
    //    init(auth: AuthDataResultModel) {
    
    //    }
    
    init(fireUser : User) {
        self.id = fireUser.uid
        self.email = fireUser.email
        self.photo = fireUser.photoURL?.absoluteString
        self.name = fireUser.displayName
    }
    
    init(
        id : String,
        email : String?,
        photo : String?,
        name : String?
    ) {
        self.id = id
        self.email = email
        self.photo = photo
        self.name = name
    }
}
