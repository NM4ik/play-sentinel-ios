//
//  Game.swift
//  PlaySentinel
//
//  Created by Никита Михайлов on 15.06.2024.
//

import Foundation

struct Game : Codable, Identifiable {
    let id : Int
    var name : String
    var available : Bool
}
