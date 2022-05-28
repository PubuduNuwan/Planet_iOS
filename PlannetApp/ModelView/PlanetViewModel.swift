//
//  PlanetViewModel.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import Foundation
import RxSwift
import SwiftyJSON
import RxRelay

class PlanetViewModel {
    
    let items = BehaviorRelay<[Planet]>(value: [])
    var itemsCount : Int {
        guard items.value.count > 0 else {
            return 0
        }
        return items.value.count
    }
    
    public var nextPageUrl : String?
    private var previousPageUrl : String?
    private var count : Int?
    
    func getPlanets() {
        PlanetService.shared.fetchPlanets(nextUrl: nextPageUrl) { data, error in
            
            if let err = error { print(err) }
            if let planetRes = data {
                self.nextPageUrl = planetRes.next
                self.previousPageUrl = planetRes.previous
                self.count = planetRes.count
                
                if let plantsList = planetRes.planets {
                    self.items.accept(self.items.value + plantsList)
                }
            }
        }
    }
}
