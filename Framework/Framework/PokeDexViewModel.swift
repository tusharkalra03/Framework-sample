//
//  PokeDexViewModel.swift
//  PokeDex
//
//  Created by Tushar Kalra on 01/06/21.
//

import SwiftUI

public class PokeDexViewModel: ObservableObject {
    
    @Published public var pokemons = [Pokemon]()
    @Published var filteredPokemon = [Pokemon]()

    let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
   public init(){
    }
    
    func find(id: String) -> Pokemon?{
        for pokemon in pokemons{
            if String(pokemon.id) == id{
            return pokemon
            }
        }
        return nil
    }
    
    public func fetch(){
        
        guard let url = URL(string: baseURL) else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            guard let data = data?.parseData(removeString: "null,") else {return}
            
            guard let pokemons = try? JSONDecoder().decode([Pokemon].self, from: data) else {
                print("No")
                return}
            
            DispatchQueue.main.async {
                self.pokemons = pokemons
            }
        }.resume()
    }
    
    func shuffle() -> [Pokemon]{
        pokemons = pokemons.shuffled()
        return pokemons
    }
    
    func filterPokemon(by filter: String) {
            filteredPokemon = pokemons.filter({ $0.type == filter })
    }
    
    func evolutionChain(of pokemon: Pokemon) -> [Pokemon] {
        
        var evolutionChain = [Pokemon]()
        guard pokemon.evolutionChain != nil else {return evolutionChain}
        for evolvedPokemon in pokemon.evolutionChain!{
            evolutionChain.append(find(id: evolvedPokemon.identity)!)
        }
        return evolutionChain
    }
    
    
}

public func bgColor(forType type: String) -> UIColor{
    switch type {
    case "poison": return .systemGreen
    case "fire": return .systemRed
    case "water": return .systemTeal
    case "electric": return .systemYellow
    case "psychic": return .systemPurple
    case "normal": return .systemOrange
    case "ground": return .systemGray
    case "flying": return .systemBlue
    case "fairy": return .systemPink
    default: return .systemIndigo
        
    }
}
extension Data {
    
    func parseData(removeString string: String) -> Data? {
        
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        
        guard let data = parsedDataString?.data(using: .utf8) else {return nil}
        
        return data
    }
}
