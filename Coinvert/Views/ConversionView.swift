//
//  HomeView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct ConversionView: View {
    @State private var currencyList: [Currency] = []
    @State private var baseCurrency = ""
    @State private var conversionCurrency = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
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
            }
            .onAppear {
                getCurrencyList { list in
                    DispatchQueue.main.async {
                        self.currencyList = list
                        if self.baseCurrency.isEmpty, let first = list.first {
                            self.baseCurrency = first.id
                        }
                    }
                }
            }
            .navigationTitle("Conversion")
        }
    }
}

#Preview {
    ConversionView()
}
