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
    
    init(sortDescriptor: SortDescriptor<Restaurant>, predicate: Predicate<Restaurant>? = nil) {
        guard let predicate = predicate else {
            _restaurants = Query(sort: [sortDescriptor])
            return
        }
        
        _restaurants = Query(filter: predicate, sort: [sortDescriptor] ,animation: .bouncy)
    }
    
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
    
    return RestaurantListView(sortDescriptor: .init(\.qualityRating, order: .reverse))
        .modelContainer(container)
}
