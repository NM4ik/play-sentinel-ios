//
//  Hub.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 11.05.2024.
//

import Foundation


struct Hub : Codable, Hashable {
    let title : String
    let users : [String]
    let game : String
    let authorId : String
    let image : String
    var id  = UUID()
}
