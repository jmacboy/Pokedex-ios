//
//  NetworkManager.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation
import Apollo

class NetworkManager {
    
    private let pokeApiEndpoint = "https://beta.pokeapi.co/graphql/v1beta"
    
    static let shared = NetworkManager()
    lazy var apollo = ApolloClient(url: URL(string: pokeApiEndpoint)!)
    
}
