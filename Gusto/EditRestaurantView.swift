//
//  EditRestaurantView.swift
//  Gusto
//
//  Created by Qustodio
//  

import SwiftUI
import SwiftData

struct EditRestaurantView: View {
    @Bindable var restaurant: Restaurant
    var body: some View {
        Form {
            TextField("Restaurant name", text: $restaurant.name)
            Picker("Price Rating", selection: $restaurant.priceRating) {
                ForEach(0...5, id: \.self) { index in
                    Text("\(index)")
                }
            }
            Picker("Speed", selection: $restaurant.speedRating) {
                ForEach(0...5, id: \.self) { index in
                    Text("\(index)")
                }
            }
            Picker("Quality rating", selection: $restaurant.qualityRating) {
                ForEach(0...5, id: \.self) { index in
                    Text("\(index)")
                }
            }
        }
//        .navigationTitle("Edit the Restaurant")
//        .toolbar {
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                Text("Save")
//            })
//        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Restaurant.self,
    configurations: config)
    let example = Restaurant(name: "The Restaurant Example")
    
    return EditRestaurantView(restaurant: example)
        .modelContainer(container)
}
