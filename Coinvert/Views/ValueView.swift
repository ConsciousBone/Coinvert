//
//  ValueView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct Rate: Identifiable {
    let id: String      // currencyCode, the short thing
    let name: String    // full currency name
    let rate: Double    // currency exchange rate, duh
}

struct ValueView: View {
    @State private var currencyList: [Currency] = []
    @State private var ratesList: [Rate] = []
    
    @State private var baseCurrency = "" // "Base Currency", duh
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        currencyList = [] // clear out any existing currencies

        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                if self.baseCurrency.isEmpty, let first = list.first {
                    self.baseCurrency = first.id // pick first
                }
                self.updateRates()
            }
        }
    }
    
    private func updateRates() {
        fetchRates(base: baseCurrency) { ratesDict in
            DispatchQueue.main.async {
                let nameByCode = Dictionary(uniqueKeysWithValues: self.currencyList.map { ($0.id, $0.name) })
                self.ratesList = ratesDict.map { (code, value) in
                    Rate(id: code, name: nameByCode[code] ?? code, rate: value)
                }
                .sorted { $0.name < $1.name }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Base Currency")
                Picker("Base Currency", selection: $baseCurrency) { // base
                    ForEach(currencyList) { currency in
                        Text(currency.name).tag(currency.id)
                    }
                }
            }
            .navigationTitle("Values")
            .navigationBarTitleDisplayMode(.inline)
            .pickerStyle(.menu)
            
            List(ratesList) { rate in // tables are fucky with iphone, list works tho
                HStack {
                    Text(rate.name)
                    Spacer()
                    Text(String(rate.rate))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .onAppear { // get currency list
            loadCurrencies()
        }
        .onChange(of: baseCurrency) {
            updateRates()
        }
    }
}

#Preview {
    ValueView()
}
