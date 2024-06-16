//
//  UserFirestoreService.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 26.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class UserFirestoreService {
    
    static let shared = UserFirestoreService()
    
    static let usersCollectionKey = "users"
    
    private let userCollection = Firestore.firestore().collection(UserFirestoreService.usersCollectionKey)
    
    private func userDocument(id : String) -> DocumentReference {
        userCollection.document(id)
    }
    
    private let encoder : Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder : Firestore.Decoder = {
        let encoder = Firestore.Decoder()
        encoder.keyDecodingStrategy = .convertFromSnakeCase
        return encoder
    }()
    
    func createNewUser(user: AppUser) async throws -> Bool {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                fatalError("Failed to convert JSON data to dictionary")
            }
            
            try await userDocument(id: user.id).setData(jsonObject)
            return true
        } catch {
            print("Error encoding struct: \(error)")
            return false
        }
    }
    
    
    
    func getUser(id : String) async throws -> AppUser? {
        print("id - \(id)")
        return try await userDocument(id: id).getDocument(as: AppUser.self, decoder: decoder)
    }
    
    func getUsers() async throws -> [AppUser] {
        
        var users = [AppUser]()
        let querySnapshot = try await userCollection.getDocuments()
        for doc in querySnapshot.documents {
            do {
                if let model = try? doc.data(as: AppUser.self) {
                    users.append(model)
                }
            }
        }
        
        return users
    }
    
}

