//
//  SettingsView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var currencyList: [Currency] = []
    
    @State private var loadingCurrencies = false
    
    // default currencies, these will set the base and convert to automatically
    @AppStorage("defaultBaseCurrency") private var defaultBaseCurrency = ""
    @AppStorage("defaultWantedCurrency") private var defaultWantedCurrency = ""
    
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
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        withAnimation { // fancy animation maybe?
            loadingCurrencies = true // show loading banner
        }
        print("loading currencies")
        
        currencyList = [] // clear out any existing currencies
        
        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                if self.defaultBaseCurrency.isEmpty, let first = list.first {
                    self.defaultBaseCurrency = first.id // pick first
                }
                
                if self.defaultWantedCurrency.isEmpty {
                    if list.count > 1 { // check if more than one currency
                        self.defaultWantedCurrency = list[1].id // pick the second
                    }
                }
                
                // this is here cos the async shit finishes after
                // the loadCurrencies() func does
                withAnimation {
                    loadingCurrencies = false // hide the loading banner
                }
                print("finished loading currencies")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                if loadingCurrencies {
                    Section {
                        Text("Loading currency list...")
                    }
                }
                
                Section { // default currencies
                    Picker("Base", selection: $defaultBaseCurrency) {
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Convert To", selection: $defaultWantedCurrency) {
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
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
            .onAppear { // get currency list
                loadCurrencies()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
