//
//  PlanetService.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import Foundation
import SwiftyJSON


class PlanetService {
    
    static let shared : PlanetService = PlanetService()
    
    func fetchPlanets(nextUrl : String?,completion: @escaping(PlanetServiceResponse?,Error?) -> ()){
        
        let url = nextUrl != nil ? nextUrl : Url.GET_PLANETS
        if url == "" { return }
        
        let net = Net(url: url! ,method: .get)
        net.perform()
        
        net.onCompletion = { (data) -> ()  in
            if let jsonResponse = try? JSON(data : data) {
                completion(PlanetServiceResponse.init(json: jsonResponse),nil)
            }
        }
        net.onError = { (error) -> () in
            completion(nil,error)}
    }
    
    func fetchPlanet(url : String,completion: @escaping(Planet?,Error?) -> ()){
        
        let net = Net(url: url, method: .get)
        net.perform()
        
        net.onCompletion = {(data) -> () in
            if let jsonResponse = try? JSON(data : data) {
                completion(Planet.init(json: jsonResponse),nil)
            }
        }
        
        net.onError = {(error) -> () in
            completion(nil,error)
        }
    }
}
