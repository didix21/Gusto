//
//  ContentView.swift
//  Gusto
//
//  Created by Qustodio
//

import SwiftUI
import SwiftData

enum SortOption {
    case name
    case quality
    case speed
    case price
}


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Restaurant]()
    @State private var sortOption: SortOption = .name

    private var sortDescriptor: SortDescriptor<Restaurant> {
        switch sortOption {
        case .name:
            return .init(\.name)
        case .quality:
            return .init(\.qualityRating, order: .reverse)
        case .speed:
            return .init(\.speedRating, order: .reverse)
        case .price:
            return .init(\.priceRating, order: .reverse)
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Picker("Sort By", selection: $sortOption) {
                    Text("Name").tag(SortOption.name)
                    Text("Price").tag(SortOption.price)
                    Text("Quality").tag(SortOption.quality)
                    Text("Speed").tag(SortOption.speed)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            RestaurantListView()
            .navigationDestination(for: Restaurant.self) { restaurant in
                EditRestaurantView(restaurant: restaurant)
            }
            .navigationTitle("Restaurant list")
            .toolbar {
                // Create a random restaurants
                Button(action: {
                    addRestaurants()
                }) {
                    Image(systemName: "wineglass")
                }
                Button(action: {
                    let restaurant: Restaurant = .init(name: "My new restaurant")
                    modelContext.insert(restaurant)
                    path.append(restaurant)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
                EditButton()
            }
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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self,
    configurations: config)
    return ContentView()
        .modelContainer(container)
}
