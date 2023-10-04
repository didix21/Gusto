//
//  RestaurantView.swift
//  Gusto
//
//  Created by Qustodio
//  

import SwiftUI
import SwiftData

struct RestaurantView: View {
    var restaurant: Restaurant

    init(_ restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    var body: some View {
        HStack {
            Text("\(restaurant.overallRating, specifier: "%.1f")")
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "fork.knife.circle.fill")
                        .foregroundColor(.orange)
                    Text(restaurant.name)
                        .padding(.trailing)
                }
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.green)
                    Text("\(restaurant.priceRating)")
                        .padding(.trailing)
                }
                HStack {
                    Image(systemName: "speedometer")
                        .foregroundColor(.cyan)
                    Text("\(restaurant.speedRating)")
                }
                HStack {
                    if restaurant.qualityRating == 0 {
                        Image(systemName: "star.slash.fill")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(1...restaurant.qualityRating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self,
    configurations: config)
    return RestaurantView(.init(name: "The amazing new restaurant"))
        .modelContainer(container)
}
