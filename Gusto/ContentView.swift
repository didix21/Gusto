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

enum FilterOption {
    case name
}


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Restaurant]()
    @State private var sortOption: SortOption = .name
    @State private var filterOption: FilterOption = .name
    @State private var searchTyped: String = ""

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
    
    private var predicateOption: Predicate<Restaurant> {
        let search = searchTyped.lowercased()
        switch filterOption {
        case .name:
            return #Predicate {
                searchTyped.isEmpty ? true : $0.name.contains(search)
            }
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
            RestaurantListView(sortDescriptor: sortDescriptor, predicate: predicateOption)
            .navigationDestination(for: Restaurant.self) { restaurant in
                EditRestaurantView(restaurant: restaurant)
            }
            .searchable(text: $searchTyped)
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
