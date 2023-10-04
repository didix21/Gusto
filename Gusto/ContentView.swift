//
//  ContentView.swift
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

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Restaurant.name) var restaurants: [Restaurant]
    @State private var path = [Restaurant]()

    var body: some View {
        NavigationStack(path: $path) {
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
                    deleteAllRestaurants()
                }, label: {
                    Image(systemName: "xmark.bin.fill")
                        .foregroundColor(.red)
                })
                Button(action: {
                    let restaurant: Restaurant = .init(name: "My new restaurant")
                    modelContext.insert(restaurant)
                    path.append(restaurant)
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
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
    return ContentView()
        .modelContainer(container)
}
