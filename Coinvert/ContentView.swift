//
//  ContentView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 3 // Color.green
    let accentColours = [ // i robbed this from Searchino, i cba doing accent shit again
        Color.red.gradient,     Color.orange.gradient,
        Color.yellow.gradient,  Color.green.gradient,
        Color.mint.gradient,    Color.blue.gradient,
        Color.purple.gradient,  Color.brown.gradient,
        Color.white.gradient,   Color.black.gradient
    ]
    
    @AppStorage("onboardingShowing") private var onboardingShowing = true
    
    var body: some View {
        TabView {
            Tab("Conversion", systemImage: "shuffle") {
                ConversionView()
            }
            Tab("Rates", systemImage: "dollarsign") {
                RatesView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        .tint(accentColours[selectedAccentIndex])
        .sheet(isPresented: $onboardingShowing) {
            OnboardingView()
                .presentationDetents([.large])
        }
    }
}

#Preview {
    ContentView()
}
