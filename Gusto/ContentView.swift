//
//  ContentView.swift
//  Gusto
//
//  Created by Qustodio
//  

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")

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
            }
        }
    }
}

#Preview {
    ContentView()
}
