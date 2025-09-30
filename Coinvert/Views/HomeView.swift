//
//  HomeView.swift
//  Coinvert
//
//  Created by Evan Plant on 30/09/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var currencyList: [Currency] = []
    @State private var baseCurrency = ""
    
    var body: some View {
        Form {
            Section {
                Picker("Base currency", selection: $baseCurrency) {
                    ForEach(currencyList) { currency in
                        Text(currency.name)
                    }
                }
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
    }
}

#Preview {
    HomeView()
}
