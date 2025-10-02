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
    
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 4
    
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
                    // TODO: accent colour shit
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
