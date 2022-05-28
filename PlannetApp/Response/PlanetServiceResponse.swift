//
//  PlanetServiceResponse.swift
//  PlannetApp
//
//  Created by user on 2022-05-28.
//

import Foundation
import SwiftyJSON

struct PlanetServiceResponse {
    
    var planets : [Planet]?
    var next : String?
    var previous : String?
    var count : Int?
    
    init(json : JSON){
        planets = PlanetServiceResponse.getPlanetList(json: json["results"])
        next = json["next"].stringValue
        previous = json["previous"].stringValue
        count = json["count"].intValue
        
    }
    
    static func getPlanetList(json : JSON) -> [Planet] {
        var planets = [Planet]()
        for(_ , object) in json {
            let planet = Planet.init(json: object)
            planets.append(planet)
        }
        return planets
    }
    
}
