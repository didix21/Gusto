//
//  Restaurant.swift
//  Gusto
//
//  Created by Qustodio
//  

import Foundation
import SwiftData

@Model class Restaurant {
    var name: String
//    var priceRating: Int
//    var qualityRating: Int
//    var speedRating: Int
    
//    init(name: String, priceRating: Int , qualityRating: Int = 0, speedRating: Int = 0) {
//        self.name = name
//        self.priceRating = priceRating
//        self.qualityRating = qualityRating
//        self.speedRating = speedRating
//    }
    
    init(name: String) {
        self.name = name
    }
}
