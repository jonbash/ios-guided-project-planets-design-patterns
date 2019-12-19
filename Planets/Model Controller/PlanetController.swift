//
//  PlanetController.swift
//  Planets
//
//  Created by Andrew R Madsen on 8/2/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class PlanetController {
    var planets: [Planet] {
        var output = planetsWithoutPluto
        if shouldShowPluto { output.append(pluto) }
        
        return output
    }
    
    var shouldShowPluto = UserDefaults.standard.bool(forKey: .shouldShowPlutoKey)
    
    private let planetsWithoutPluto = [
        Planet(name: "Mercury", imageName: "mercury"),
        Planet(name: "Venus", imageName: "venus"),
        Planet(name: "Earth", imageName: "earth"),
        Planet(name: "Mars", imageName: "mars"),
        Planet(name: "Jupiter", imageName: "jupiter"),
        Planet(name: "Saturn", imageName: "saturn"),
        Planet(name: "Uranus", imageName: "uranus"),
        Planet(name: "Neptune", imageName: "neptune")
    ]
    
    private let pluto = Planet(name: "Pluto", imageName: "pluto")
}
