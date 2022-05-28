//
//  PlanetInfoViewModel.swift
//  PlannetApp
//
//  Created by user on 2022-05-28.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

struct PlanetInfoViewModel {
    
    var planet = BehaviorRelay<Planet>(value: Planet())
    
    func getPlanetById(url : String){
        
        PlanetService.shared.fetchPlanet(url: url) {
            data,error in
            
            if let dataResponse = data {
                planet.accept(dataResponse)
            }
            
            if let err = error {
                print(err)
            }
        }
    }
}

