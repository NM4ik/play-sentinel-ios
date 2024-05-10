//
//  DBUser.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation
import Firebase


struct DBUser : Codable {
    let userId : String
    let email : String?
    let photo : String?
    let dateCreated : Timestamp?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photo = auth.photoUrl
        self.dateCreated = Timestamp()
    }
    
    init(id : String,
        email : String,
        photo : String) {
        self.userId = id
        self.email = email
        self.photo = photo
        self.dateCreated = Timestamp()
    }
}
