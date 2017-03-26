
import Vapor
//import VaporPostgreSQL



let drop = Droplet()
//drop.preparations.append(Person.self)
//do {
//    try drop.addProvider(VaporPostgreSQL.Provider.self)
//} catch {
//    assertionFailure("Error adding provider: \(error)")
//}


var people = [Person(name: "Bill", favoriteCity: "Medina, WA"),
              Person(name: "Steve", favoriteCity: "Palo Alto, CA"),
              Person(name: "Elon", favoriteCity: "Los Angeles, CA"),
              Person(name: "Daniel", favoriteCity: "Stockholm, SE"),
              Person(name: "Sean", favoriteCity: "Brooklyn")]

var peopleNode = try people.makeNode()
var nodeDictionary = ["people": peopleNode]

drop.get("/people"){req in
    return try JSON(node: nodeDictionary)
}


drop.get("/people", "/1") {request in
    return try JSON(node:[Person(name: "Bill", favoriteCity: "Medina, WA")])
}

drop.get("/people", "/2") {request in
    return try JSON(node:[Person(name: "Steve", favoriteCity: "Palo Alto, CA")])
}

drop.get("/people", "/3") {request in
    return try JSON(node:[Person(name: "Elon", favoriteCity: "Los Angeles, CA")])
}

drop.get("/people", "/4") {request in
    return try JSON(node:[Person(name: "Daniel", favoriteCity: "Stockholm, SE")])
}

drop.get("/people", "/5") {request in
    return try JSON(node:[Person(name: "Sean", favoriteCity: "New York, NY")])
}


drop.post("/people") {request in
    guard let name = request.data["name"]?.string else {
        throw Abort.badRequest
    }
    guard let favoriteCity = request.data["favoriteCity"]?.string else {
        throw Abort.badRequest
    }
    
    people.append(Person(name: name, favoriteCity: favoriteCity))
    var peopleNode = try people.makeNode()
    var nodeDictionary = ["people": peopleNode]
    
    return try JSON(node: nodeDictionary)

}


drop.put("/people") {request in
    guard let name = request.data["name"]?.string else {
        throw Abort.badRequest
    }
    guard let favoriteCity = request.data["favoriteCity"]?.string else {
        throw Abort.badRequest
    }
    
    people.append(Person(name: name, favoriteCity: favoriteCity))
    var peopleNode = try people.makeNode()
    var nodeDictionary = ["people": peopleNode]
    
    return try JSON(node: nodeDictionary)
    
}


//drop.delete("/people", Int.self) { request, int in
//   
//    people.remove(at: int)
//    
//    return try JSON(node: nodeDictionary)
//}
//drop.post("/people") { req in
//    var person = try Person(node: req.json)
//    try person.save()
//    return try person.makeJSON()
//}
//
//drop.get("/people", Int.self) {req, userID in
//    guard let person = try Person.find(userID) else{
//        throw Abort.notFound
//    }
//    return try person.makeJson()
//}




drop.resource("posts", PostController())

drop.run()


