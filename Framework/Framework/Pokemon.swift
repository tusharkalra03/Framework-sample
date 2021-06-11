//
//  Pokemon.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import Foundation

public struct Pokemon: Codable, Identifiable{
    
    public let id: Int
    public let name: String
    public let type: String
    let imageUrl: String
    let description: String
    let evolutionChain: [Evolution]?
    let height: Int
    let weight: Int
    let attack: Int
    let defense: Int
    
    
   public struct Evolution: Codable{
        
        let identity: String
        let nameOfEvolved: String
        
        enum CodingKeys: String, CodingKey{
            
            case identity = "id"
            case nameOfEvolved = "name"
        }
    }
}

