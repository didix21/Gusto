//
//  RestaurantListView.swift
//  Gusto
//
//  Created by Qustodio
//  

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Restaurant.name) var restaurants: [Restaurant]
    
    var body: some View {
        List {
            ForEach(restaurants, id: \.self) { restaurant in
                NavigationLink(value: restaurant) {
                    RestaurantView(restaurant)
                }
            }
            .onDelete(perform: { indexSet in
                deleteRestaurant(indexSet)
            })
        }
    }

    private func deleteRestaurant(_ indexSet: IndexSet) {
        let candidates: [Restaurant] = indexSet.map { index in
            restaurants[index]
        }
        candidates.forEach { item in
            modelContext.delete(item)
        }
    }

}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self,
    configurations: config)
    let restaurants = [Restaurant]()
    return RestaurantListView()
        .modelContainer(container)
}
