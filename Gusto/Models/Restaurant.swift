//
//  Restaurant.swift
//  Gusto
//
//  Created by Qustodio
//  

import Foundation
import SwiftData

@Model class Restaurant {
    @Attribute(.unique) var name: String
    var priceRating: Int
    var qualityRating: Int
    var speedRating: Int
    
    var overallRating: Double {
        Double(priceRating + qualityRating + speedRating) / 3
    }
    
    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
    }
    
    convenience init(name: String) {
        self.init(
            name: name,
            priceRating: .random(in: 0...5),
            qualityRating:.random(in: 0...5),
            speedRating: .random(in: 0...5)
        )
    }
}
