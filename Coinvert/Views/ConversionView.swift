//
//  HomeView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct ConversionView: View {
    @FocusState var isInputActive: Bool
    
    @State private var currencyList: [Currency] = []
    
    @State private var baseCurrency = ""
    @State private var wantedCurrency = ""
    
    @State private var baseCurrencyAmount: Double? = nil
    @State private var convertedAmount: Double? = nil
    
    var baseCurrencyFullName: String {
        currencyList.first(where: { $0.id == baseCurrency })?.name ?? "Unknown"
    }
    var wantedCurrencyFullName: String {
        currencyList.first(where: { $0.id == wantedCurrency })?.name ?? "Unknown"
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
                    Picker("Convert To", selection: $wantedCurrency) { // wanted
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section { // base amount
                    Text("Amount in \(baseCurrencyFullName):")
                    TextField("1.00", value: $baseCurrencyAmount, format: .number)
                        .keyboardType(.decimalPad) // stops text being entered
                        .focused($isInputActive) // lets us show the done button in toolbar
                }
                
                Section {
                    Button {
                        print("converting! from \(baseCurrency) to \(wantedCurrency)")
                        guard let amount = baseCurrencyAmount else {
                            print("No amount entered")
                            return
                        }
                        convertCurrency(
                            base: baseCurrency,
                            wanted: wantedCurrency,
                            amount: amount) { converted in
                                DispatchQueue.main.async {
                                    if let converted = converted {
                                        self.convertedAmount = converted
                                        print("converted amount: \(converted)")
                                    } else {
                                        print("conversion failed") // error somehow
                                    }
                                }
                            }
                    } label: {
                        Label("Convert", systemImage: "shuffle")
                            .labelStyle(.titleAndIcon) // looks better imo
                    }
                }
                
                Section { // wanted amount
                    Text("Amount in \(wantedCurrencyFullName):")
                    if let converted = convertedAmount {
                        Text(converted, format: .number)
                    } else {
                        Text("0.00")
                    }
                }
            }
            .onAppear { // fetch list of currencies and give it to a var
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
            .toolbar {
                ToolbarItem(placement: .keyboard) { // dismiss button
                                                    // idfk how to do it better so deal with it
                    Button {
                        isInputActive = false
                    } label: {
                        Label("Done", systemImage: "checkmark")
                            .labelStyle(.titleAndIcon) // looks better
                    }
                    .padding()
                }
            }
            .navigationTitle("Conversion")
        }
    }
}

#Preview {
    ConversionView()
}

