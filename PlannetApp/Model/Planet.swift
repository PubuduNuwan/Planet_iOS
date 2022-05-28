//
//  Planet.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import Foundation
import SwiftyJSON


struct Planet : Encodable,Decodable {
    
    var name, rotationPeriod, orbitalPeriod, diameter: String?
    var climate, gravity, terrain, surfaceWater: String?
    var population: String?
    var residents, films: [String]?
    var created, edited: String?
    var url: String?
    
    init(){}
    
    init(json : JSON){
        name = json["name"].stringValue
        rotationPeriod = json["rotation_period"].stringValue
        orbitalPeriod = json["orbital_period"].stringValue
        diameter = json["diameter"].stringValue
        climate = json["climate"].stringValue
        gravity = json["gravity"].stringValue
        terrain = json["terrain"].stringValue
        surfaceWater = json["syrfaceWater"].stringValue
        population = json["population"].stringValue
        
        residents =  Planet.jsonToStringList(json: json["residents"])
        films = Planet.jsonToStringList(json: json["films"])
        created = json["created"].stringValue
        edited = json["edited"].stringValue
        url = json["url"].stringValue
        
    }
    
    
    static func jsonToStringList(json : JSON) -> [String] {
        var temArra = [String]()
        for (_, value) in json {
            temArra.append(value.rawValue as! String)
        }
        return temArra
    }
}
