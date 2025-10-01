//
//  ValueView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct ValueView: View {
    @State private var currencyList: [Currency] = []
    
    @State private var baseCurrency = "" // "Base Currency", duh
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        currencyList = [] // clear out any existing currencies
        
        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                if self.baseCurrency.isEmpty, let first = list.first {
                    self.baseCurrency = first.id // pick first
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Picker("Base Currency", selection: $baseCurrency) { // base
                ForEach(currencyList) { currency in
                    Text(currency.name).tag(currency.id)
                }
            }
            .navigationTitle("Values")
            .navigationBarTitleDisplayMode(.inline)
            .pickerStyle(.menu)
            // TODO: put a table in here
        }
        .onAppear { // get currency list
            loadCurrencies()
        }
    }
}

#Preview {
    ValueView()
}
