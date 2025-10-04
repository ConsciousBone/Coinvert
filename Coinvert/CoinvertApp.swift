//
//  CoinvertApp.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI
import SwiftData

@main
struct CoinvertApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FavouriteItem.self]) // swiftdata shit
    }
}
