//
//  ContentView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Values", systemImage: "dollarsign") {
                ValueView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        .tint(Color(.green))
    }
}

#Preview {
    ContentView()
}
