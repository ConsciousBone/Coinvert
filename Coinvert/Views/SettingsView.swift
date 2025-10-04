//
//  SettingsView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct SettingsView: View {
    // default currencies, these will set the base and convert to automatically
    @AppStorage("defaultBaseCurrency") private var defaultBaseCurrency = ""
    @AppStorage("defaultBaseCurrency") private var defaultWantedCurrency = ""
    
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 3 // Color.green
    let accentColours = [ // i robbed this from Searchino, i cba doing accent shit again
        Color.red.gradient,     Color.orange.gradient,
        Color.yellow.gradient,  Color.green.gradient,
        Color.mint.gradient,    Color.blue.gradient,
        Color.purple.gradient,  Color.brown.gradient,
        Color.white.gradient,   Color.black.gradient
    ]
    let accentColourNames = [ // again, robbed from Searchino, dw i own Searchino haha its not been in a YSWS either
        String(localized: "Red"),     String(localized: "Orange"),
        String(localized: "Yellow"),  String(localized: "Green"),
        String(localized: "Mint"),    String(localized: "Blue"),
        String(localized: "Purple"),  String(localized: "Brown"),
        String(localized: "White"),   String(localized: "Black")
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section { // default currencies
                    Picker("Base", selection: $defaultBaseCurrency) {
                        // TODO: fill this with actual data
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Convert To", selection: $defaultWantedCurrency) {
                        // TODO: fill this with actual data
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Default Currencies")
                }
                
                Section { // accent
                    Picker(selection: $selectedAccentIndex, label: Label("Accent Colour", systemImage: "paintpalette")) {
                        ForEach(accentColours.indices, id: \.self) { index in
                            HStack {
                                Circle()
                                    .fill(accentColours[index])
                                    .frame(width: 15)
                                Text(accentColourNames[index])
                            }
                            .tag(index)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
