//
//  Dish.swift
//  Gusto
//
//  Created by Qustodio
//  

import Foundation
import SwiftData

@Model class Dish {
    var name: String
    var review: String
    
    init(name: String, review: String) {
        self.name = name
        self.review = review
    }
}
