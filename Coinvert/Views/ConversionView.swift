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
    @State private var conversionCurrency = ""
    
    @State private var baseCurrencyAmount: Double? = nil
    
    var baseCurrencyFullName: String {
        currencyList.first(where: { $0.id == baseCurrency })?.name ?? "Unknown"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section { // currencies
                    Picker("Base Currency", selection: $baseCurrency) {
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Convert To", selection: $baseCurrency) {
                        ForEach(currencyList) { currency in
                            Text(currency.name).tag(currency.id)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section { // base amount
                    Text("Amount in \(baseCurrencyFullName):")
                    TextField("1.00", value: $baseCurrencyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                }
            }
            .onAppear { // fetch list of currencies and give it to a var
                getCurrencyList { list in
                    DispatchQueue.main.async {
                        self.currencyList = list
                        if self.baseCurrency.isEmpty, let first = list.first {
                            self.baseCurrency = first.id
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
                            .labelStyle(.titleAndIcon)
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
