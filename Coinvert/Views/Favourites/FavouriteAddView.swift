//
//  FavouriteAddView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI
import SwiftData

struct FavouriteAddView: View {
    @FocusState var isInputActive: Bool
    
    @Environment(\.modelContext) var modelContext
    @State private var favouritePath = [FavouriteItem]()
    @Query(sort: \FavouriteItem.date, order: .reverse) var favouriteItems: [FavouriteItem]
    
    @State private var loadingCurrencies = false
    @State private var currencyList: [Currency] = []
    
    @State private var title = ""
    @State private var baseCurrency = "" // "Base Currency", duh
    @State private var wantedCurrency = "" // "Convert To"
    
    func addFavourite(title: String, base: String, wanted: String, displayMode: Int = 0, date: Date = .now, id: UUID = UUID()) {
        let favouriteItem = FavouriteItem()
        modelContext.insert(favouriteItem)
        favouritePath = [favouriteItem]
    }
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        withAnimation { // fancy animation maybe?
            loadingCurrencies = true // show loading banner
        }
        print("loading currencies")
        
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
        Form {
            if loadingCurrencies {
                Section {
                    Text("Loading currency list...")
                }
            }
            
            Section {
                TextField("GBP to USD", text: $title)
                    .focused($isInputActive)
            } header: {
                Text("Name")
            }
            
            Section {
                Picker("Base Currency", selection: $baseCurrency) { // base
                    ForEach(currencyList) { currency in
                        Text(currency.name).tag(currency.id)
                    }
                }
                .pickerStyle(.menu)
                Picker("Convert To", selection: $wantedCurrency) { // base
                    ForEach(currencyList) { currency in
                        Text(currency.name).tag(currency.id)
                    }
                }
                .pickerStyle(.menu)
            } header: {
                Text("Currencies")
            }
            
            Section {
                Button {
                    print("saving favourite")
                } label: {
                    Text("Add Favourite")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) { // dismiss button, idfk how to do it better so deal with it
                Button {
                    isInputActive = false
                } label: {
                    Label("Done", systemImage: "checkmark")
                }
                .padding()
            }
        }
        .onAppear {
            loadCurrencies()
        }
    }
}

#Preview {
    FavouriteAddView()
}
