//
//  HubRepository.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 11.05.2024.
//

import Foundation
import FirebaseFirestore

struct HubRepository {
    static let instance = HubRepository()
    
    static private let hubsCollectionKey = "hubs"
    static private let gamesCollectionKey = "games"
    private let hubsCollection = Firestore.firestore().collection(HubRepository.hubsCollectionKey)
    private let gamesCollection = Firestore.firestore().collection(HubRepository.gamesCollectionKey)
    
    func getHubs(userId : String) async throws -> [Hub] {
        guard let response = try? await hubsCollection.whereField("users", arrayContains: userId).getDocuments() else {
            throw URLError(.badServerResponse)
        }
        let docsSnapshot = response.documents
        var hubs: [Hub] = []
        
        print("docsSnapshot.count - \(docsSnapshot.count)")
        
        for val in docsSnapshot {
            do {
                print("ITERATION START - \(val.data())")
                
                // Попытка декодирования документа в объект Hub
                let hub = try val.data(as: Hub.self)
                print("item = \(String(describing: hub))")
                // Добавление объекта в массив
                hubs.append(hub)
            } catch {
                // Обработка ошибок декодирования
                print("Error decoding document: \(error)")
            }
        }
        print("docsSnapshot = \(docsSnapshot)")
        return hubs
    }
    
    func createHub(hub: Hub) async -> Bool {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(hub)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                fatalError("Failed to convert JSON data to dictionary")
            }
            
            let ref = try await hubsCollection.addDocument(data: jsonObject)
            print("Document added with ID: \(ref.documentID)")
            return true
        } catch {
            print("Error encoding struct: \(error)")
            return false
        }
    }
    
    func isAvaialbleToCreateHub(userId : String) async -> Bool {
        guard let querySnapshot = try? await hubsCollection.whereField("user_id", isEqualTo: userId).getDocuments() else {
            return false
        }
        
        if querySnapshot.documents.isEmpty {
            return true
        } else if querySnapshot.documents.count > 1 {
            return false
        } else {
            return false
        }
    }
    
    func getAvailableGames() async -> [Game] {
        guard let querySnapshot = try? await gamesCollection.getDocuments() else {
            return []
        }
        
        var games : [Game] = []
        
        for doc in querySnapshot.documents {
            do {
                print("ITERATION START - \(doc.data())")
                // Попытка декодирования документа в объект Hub
                let game = try doc.data(as: Game.self)
                print("item = \(String(describing: game))")
                // Добавление объекта в массив
                games.append(game)
            } catch {
                // Обработка ошибок декодирования
                print("Error decoding document: \(error)")
            }
        }
        
        return games
    }
    
    
    
    private let encoder : Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
