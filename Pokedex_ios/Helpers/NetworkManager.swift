//
//  NetworkManager.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation
import Apollo

class NetworkManager {

    static let shared = NetworkManager()

    lazy var apollo = ApolloClient(url: URL(string: ConstantVariables.pokeApiEndpoint)!)

}
