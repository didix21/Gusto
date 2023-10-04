//
//  Restaurant.swift
//  Gusto
//
//  Created by Qustodio
//  

import Foundation
import SwiftData

@Model // Must be a class
class Restaurant {
    let name: String
    let priceRating: Int
    let qualityRating: Int
    let speedRating: Int
    
    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
    }
}
