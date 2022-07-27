// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PokemonDetailsStatsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query pokemonDetails($lang_id: Int = 9, $id: Int = 1) {
      pokemonDetail: pokemon_v2_pokemon_by_pk(id: $id) {
        __typename
        name
        pokemon_species_id
        specy: pokemon_v2_pokemonspecy {
          __typename
          pokemon_v2_pokemonspeciesnames(where: {language_id: {_eq: $lang_id}}) {
            __typename
            genus
          }
        }
        stats: pokemon_v2_pokemonstats {
          __typename
          effort
          base_stat
          stat: pokemon_v2_stat {
            __typename
            name
          }
        }
      }
    }
    """

  public let operationName: String = "pokemonDetails"

  public var lang_id: Int?
  public var id: Int?

  public init(lang_id: Int? = nil, id: Int? = nil) {
    self.lang_id = lang_id
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["lang_id": lang_id, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon_v2_pokemon_by_pk", alias: "pokemonDetail", arguments: ["id": GraphQLVariable("id")], type: .object(PokemonDetail.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemonDetail: PokemonDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "pokemonDetail": pokemonDetail.flatMap { (value: PokemonDetail) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "pokemon_v2_pokemon" using primary key columns
    public var pokemonDetail: PokemonDetail? {
      get {
        return (resultMap["pokemonDetail"] as? ResultMap).flatMap { PokemonDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "pokemonDetail")
      }
    }

    public struct PokemonDetail: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["pokemon_v2_pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("pokemon_species_id", type: .scalar(Int.self)),
          GraphQLField("pokemon_v2_pokemonspecy", alias: "specy", type: .object(Specy.selections)),
          GraphQLField("pokemon_v2_pokemonstats", alias: "stats", type: .nonNull(.list(.nonNull(.object(Stat.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, pokemonSpeciesId: Int? = nil, specy: Specy? = nil, stats: [Stat]) {
        self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemon", "name": name, "pokemon_species_id": pokemonSpeciesId, "specy": specy.flatMap { (value: Specy) -> ResultMap in value.resultMap }, "stats": stats.map { (value: Stat) -> ResultMap in value.resultMap }])
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

      public var pokemonSpeciesId: Int? {
        get {
          return resultMap["pokemon_species_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "pokemon_species_id")
        }
      }

      /// An object relationship
      public var specy: Specy? {
        get {
          return (resultMap["specy"] as? ResultMap).flatMap { Specy(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "specy")
        }
      }

      /// An array relationship
      public var stats: [Stat] {
        get {
          return (resultMap["stats"] as! [ResultMap]).map { (value: ResultMap) -> Stat in Stat(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Stat) -> ResultMap in value.resultMap }, forKey: "stats")
        }
      }

      public struct Specy: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pokemon_v2_pokemonspeciesnames", arguments: ["where": ["language_id": ["_eq": GraphQLVariable("lang_id")]]], type: .nonNull(.list(.nonNull(.object(PokemonV2Pokemonspeciesname.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pokemonV2Pokemonspeciesnames: [PokemonV2Pokemonspeciesname]) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "pokemon_v2_pokemonspeciesnames": pokemonV2Pokemonspeciesnames.map { (value: PokemonV2Pokemonspeciesname) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An array relationship
        public var pokemonV2Pokemonspeciesnames: [PokemonV2Pokemonspeciesname] {
          get {
            return (resultMap["pokemon_v2_pokemonspeciesnames"] as! [ResultMap]).map { (value: ResultMap) -> PokemonV2Pokemonspeciesname in PokemonV2Pokemonspeciesname(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: PokemonV2Pokemonspeciesname) -> ResultMap in value.resultMap }, forKey: "pokemon_v2_pokemonspeciesnames")
          }
        }

        public struct PokemonV2Pokemonspeciesname: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_pokemonspeciesname"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("genus", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(genus: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspeciesname", "genus": genus])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var genus: String {
            get {
              return resultMap["genus"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "genus")
            }
          }
        }
      }

      public struct Stat: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemonstat"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("effort", type: .nonNull(.scalar(Int.self))),
            GraphQLField("base_stat", type: .nonNull(.scalar(Int.self))),
            GraphQLField("pokemon_v2_stat", alias: "stat", type: .object(Stat.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(effort: Int, baseStat: Int, stat: Stat? = nil) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonstat", "effort": effort, "base_stat": baseStat, "stat": stat.flatMap { (value: Stat) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var effort: Int {
          get {
            return resultMap["effort"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "effort")
          }
        }

        public var baseStat: Int {
          get {
            return resultMap["base_stat"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "base_stat")
          }
        }

        /// An object relationship
        public var stat: Stat? {
          get {
            return (resultMap["stat"] as? ResultMap).flatMap { Stat(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "stat")
          }
        }

        public struct Stat: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_stat"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_stat", "name": name])
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
        }
      }
    }
  }
}
