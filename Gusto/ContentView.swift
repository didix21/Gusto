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
                                .foregroundColor(.yellow)
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
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Restaurants")
                List(restaurants) { restaurant in
                   RestaurantView(restaurant)
                }

            }
            .padding()
            .navigationTitle("GustoApp")
            .toolbar {
                    Button(action: {
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
                        // Add your refresh action here
                        // This closure will be called when the button is tapped
                        print("Refresh button tapped")
                    }) {
                        Image(systemName: "wineglass")
                    }
                Button(action: {
                    print("Delete")
                    for restaurant in restaurants {
                        modelContext.delete(restaurant)
                    }
                    
                }, label: {
                    Image(systemName: "xmark.bin.fill")
                        .foregroundColor(.red)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
