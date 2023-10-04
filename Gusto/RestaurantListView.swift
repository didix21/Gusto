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
    
    private func addRestaurants() {
        print("Adding restaurants")
        let restaurants: [Restaurant] = [
            .init(name: "Wok this Way"),
            .init(name: "Thyme Square"),
            .init(name: "Pasta la Vista"),
            .init(name: "Life of Pie"),
            .init(name: "Lord of the Wings")
        ]
        for restaurant in restaurants {
            modelContext.insert(restaurant)
        }
    }

    private func deleteAllRestaurants() {
        print("Deleting all restaurants")
        for restaurant in restaurants {
            modelContext.delete(restaurant)
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
    return RestaurantListView()
        .modelContainer(container)
}
