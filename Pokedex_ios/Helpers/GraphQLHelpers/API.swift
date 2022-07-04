// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class HomePageQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query homePage {
      species: pokemon_v2_pokemonspecies(order_by: {id: asc}) {
        __typename
        id
        name
        generation: pokemon_v2_generation {
          __typename
          id
          name
        }
        pokemon_details: pokemon_v2_pokemons(order_by: {id: asc}, limit: 1) {
          __typename
          name
          height
          weight
          types: pokemon_v2_pokemontypes {
            __typename
            type: pokemon_v2_type {
              __typename
              id
              name
            }
          }
        }
      }
    }
    """

  public let operationName: String = "homePage"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon_v2_pokemonspecies", alias: "species", arguments: ["order_by": ["id": "asc"]], type: .nonNull(.list(.nonNull(.object(Species.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(species: [Species]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "species": species.map { (value: Species) -> ResultMap in value.resultMap }])
    }

    /// An array relationship
    public var species: [Species] {
      get {
        return (resultMap["species"] as! [ResultMap]).map { (value: ResultMap) -> Species in Species(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Species) -> ResultMap in value.resultMap }, forKey: "species")
      }
    }

    public struct Species: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("pokemon_v2_generation", alias: "generation", type: .object(Generation.selections)),
          GraphQLField("pokemon_v2_pokemons", alias: "pokemon_details", arguments: ["order_by": ["id": "asc"], "limit": 1], type: .nonNull(.list(.nonNull(.object(PokemonDetail.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String, generation: Generation? = nil, pokemonDetails: [PokemonDetail]) {
        self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "id": id, "name": name, "generation": generation.flatMap { (value: Generation) -> ResultMap in value.resultMap }, "pokemon_details": pokemonDetails.map { (value: PokemonDetail) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// An object relationship
      public var generation: Generation? {
        get {
          return (resultMap["generation"] as? ResultMap).flatMap { Generation(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "generation")
        }
      }

      /// An array relationship
      public var pokemonDetails: [PokemonDetail] {
        get {
          return (resultMap["pokemon_details"] as! [ResultMap]).map { (value: ResultMap) -> PokemonDetail in PokemonDetail(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: PokemonDetail) -> ResultMap in value.resultMap }, forKey: "pokemon_details")
        }
      }

      public struct Generation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_generation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_generation", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct PokemonDetail: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemon"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("height", type: .scalar(Int.self)),
            GraphQLField("weight", type: .scalar(Int.self)),
            GraphQLField("pokemon_v2_pokemontypes", alias: "types", type: .nonNull(.list(.nonNull(.object(`Type`.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, height: Int? = nil, weight: Int? = nil, types: [`Type`]) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemon", "name": name, "height": height, "weight": weight, "types": types.map { (value: `Type`) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var height: Int? {
          get {
            return resultMap["height"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "height")
          }
        }

        public var weight: Int? {
          get {
            return resultMap["weight"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "weight")
          }
        }

        /// An array relationship
        public var types: [`Type`] {
          get {
            return (resultMap["types"] as! [ResultMap]).map { (value: ResultMap) -> `Type` in `Type`(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: `Type`) -> ResultMap in value.resultMap }, forKey: "types")
          }
        }

        public struct `Type`: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_pokemontype"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pokemon_v2_type", alias: "type", type: .object(`Type`.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(type: `Type`? = nil) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemontype", "type": type.flatMap { (value: `Type`) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// An object relationship
          public var type: `Type`? {
            get {
              return (resultMap["type"] as? ResultMap).flatMap { `Type`(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "type")
            }
          }

          public struct `Type`: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_type"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, name: String) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_type", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}
