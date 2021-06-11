//
//  ContentView.swift
//  UseFramework
//
//  Created by Tushar Kalra on 11/06/21.
//

import SwiftUI
import Framework

struct ContentView: View {
    
    @ObservedObject var manager = PokeDexViewModel()
    @State var isShowing = false
    var body: some View {
        
        VStack{
            Button(action: {
                manager.fetch()
                print("C", manager.pokemons.count)
                    self.isShowing.toggle()

            }) {
                Text("Open")
            }
        }
        .sheet(isPresented: self.$isShowing, content: {
            PokemonList(manager: manager)
        })
    }
}


struct PokemonList: View{
    
    let manager: PokeDexViewModel

    
    var body: some View{
        

        return List(manager.pokemons){pokemon in
            VStack(alignment: .leading){
                Text(pokemon.name).fontWeight(.bold)
                Text(pokemon.type)
            }
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
