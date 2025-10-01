//
//  HomeView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

// waa waaaa bad code, its not lazy its just being efficient

import SwiftUI

struct ConversionView: View {
    @FocusState var isInputActive: Bool
    
    @State private var currencyList: [Currency] = []
    
    @State private var baseCurrency = "" // "Base Currency", duh
    @State private var wantedCurrency = "" // "Convert To"
    
    @State private var baseHolding = "" // holds the baseCurrency for swapping
                                        // yes theres better ways but its like 11pm
    
    @State private var baseCurrencyAmount: Double? = nil
    @State private var convertedAmount: Double? = nil
    
    var baseCurrencyFullName: String {
        currencyList.first(where: { $0.id == baseCurrency })?.name ?? "Unknown"
    }
    var wantedCurrencyFullName: String {
        currencyList.first(where: { $0.id == wantedCurrency })?.name ?? "Unknown"
    }
    
    func convert() {
        print("auto converting! from \(baseCurrency) to \(wantedCurrency)")
        
        guard let amount = baseCurrencyAmount else {
            print("No amount entered")
            convertedAmount = nil
            return
        }
        
        convertCurrency(
            base: baseCurrency,
            wanted: wantedCurrency,
            amount: amount)
        { converted in
            DispatchQueue.main.async {
                if let converted = converted {
                    self.convertedAmount = converted
                    print("converted amount: \(converted)")
                } else {
                    print("conversion failed") // error somehow
                }
            }
        }
    }
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        currencyList = [] // clear out any existing currencies
        
        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                if self.baseCurrency.isEmpty, let first = list.first {
                    self.baseCurrency = first.id // pick first
                }
                
                if self.wantedCurrency.isEmpty {
                    if list.count > 1 { // check if more than one currency
                        self.wantedCurrency = list[1].id // pick the second
                    } else if let first = list.first {
                        self.wantedCurrency = first.id // fall back to first
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section { // currencies
                    Picker("Base Currency", selection: $baseCurrency) { // base
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Button {
                        print("swapping currencies")
                        baseHolding = baseCurrency // ew bad code ew ew
                        baseCurrency = wantedCurrency
                        wantedCurrency = baseHolding
                        
                        convert() // why not
                    } label: {
                        Label("Swap", systemImage: "shuffle")
                    }
                    
                    Picker("Convert To", selection: $wantedCurrency) { // wanted
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                    // TODO: have it auto convert when this changes
                }
                
                Section { // base amount
                    Text("Amount in \(baseCurrencyFullName):")
                    TextField("1.00", value: $baseCurrencyAmount, format: .number)
                        .keyboardType(.decimalPad) // stops text being entered
                        .focused($isInputActive) // lets us show the done button in toolbar
                        .onChange(of: baseCurrencyAmount) { _, _ in
                            convert()
                        }
                }
                
               // Section { // convert button, kinda redundant from auto convert
               //     Button {
               //         convert()
               //     } label: {
               //         Label("Convert", systemImage: "shuffle")
               //             .labelStyle(.titleAndIcon) // looks better imo
               //     }
               // }
                
                Section { // wanted amount
                    Text("Amount in \(wantedCurrencyFullName):")
                    if let converted = convertedAmount {
                        Text(converted, format: .number)
                    } else {
                        Text("0.00") // placeholder
                    }
                }
            }
            .onAppear { // get currency list
                loadCurrencies()
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) { // dismiss button, idfk how to do it better so deal with it
                    Button {
                        isInputActive = false
                    } label: {
                        Label("Done", systemImage: "checkmark")
                            .labelStyle(.titleAndIcon) // looks better
                    }
                    .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("refreshing currency list")
                        loadCurrencies()
                    } label: {
                        Label("Refresh", systemImage: "arrow.trianglehead.2.counterclockwise.rotate.90")
                    }
                }
            }
            .navigationTitle("Conversion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ConversionView()
}

