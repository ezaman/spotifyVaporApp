//
//  Person.swift
//  spotifyChallenge
//
//  Created by Ehsan Zaman on 3/25/17.
//
//

import Foundation
import Vapor

class Person: Model {
    
    var id: Node?
    let name: String
    let favoriteCity: String

    init(name: String, favoriteCity: String) {
        //self.id = id
        self.name = name
        self.favoriteCity = favoriteCity
    }
    
    // NodeInitializable
    required init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        favoriteCity = try node.extract("favoriteCity")
    }
    
    //NodeRepresentable
   
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "name": name,
                               "favoriteCity": favoriteCity])
    }
    
    // Preparation
    static func prepare(_ database: Database) throws {
        try database.create("people") { people in
            people.id()
            people.string("name")
            people.string("favoriteCity")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("people")
    }
}
