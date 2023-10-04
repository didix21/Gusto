//
//  GustoApp.swift
//  Gusto
//
//  Created by Qustodio
//  

import SwiftUI
import SwiftData

@main
struct GustoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Restaurant.self)
    }
}
