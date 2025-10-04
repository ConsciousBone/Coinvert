//
//  FavouritesView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    @Environment(\.presentationMode) var presentationMode // lets us dismiss the sheet
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \FavouriteItem.date, order: .reverse) var favouriteItems: [FavouriteItem]
    
    @State var showingAddFavouriteSheet = false
    
    @State private var loadingCurrencies = false
    @State private var currencyList: [Currency] = []
    
    let mode: Int // 0 is base + wanted, 1 is base, 2 is wanted, not used atm
    @Binding var conversionBaseCurrency: String
    @Binding var conversionWantedCurrency: String
    
    func loadCurrencies() { // fetch list of currencies and give it to a var
        withAnimation { // fancy animation maybe?
            loadingCurrencies = true // show loading banner
        }
        print("loading currencies")
        
        currencyList = [] // clear out any existing currencies
        
        getCurrencyList { list in
            DispatchQueue.main.async {
                self.currencyList = list
                
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
            if favouriteItems.count == 0 {
                ContentUnavailableView {
                    Label("No favourites", systemImage: "star")
                } description: {
                    Text("You don't have any favourites yet.")
                } actions: {
                    Button("Add Favourite") {
                        print("opening favouritesview")
                        showingAddFavouriteSheet.toggle()
                    }
                    .buttonStyle(.bordered)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            print("closing sheet")
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
                }
            } else {
                Form {
                    ForEach(favouriteItems) { item in
                        Section {
                            Button {
                                print("favourite clicked: name is \(item.title)")
                                conversionBaseCurrency = item.baseCurrency
                                conversionWantedCurrency = item.wantedCurrency
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                FavouriteRowItemView(
                                    title: item.title,
                                    baseCurrency: currencyList.first(where: { $0.id == item.baseCurrency })?.name ?? "Unknown",
                                    wantedCurrency: currencyList.first(where: { $0.id == item.wantedCurrency })?.name ?? "Unknown"
                                )
                            }
                        }
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            indexSet.map{favouriteItems[$0]}.forEach(modelContext.delete)
                        }
                    }
                }
                .tint(.primary)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            print("closing sheet")
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("Close", systemImage: "xmark")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            print("opening favouritesview")
                            showingAddFavouriteSheet.toggle()
                        } label: {
                            Label("New Favourite", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .onAppear {
            loadCurrencies()
        }
        .sheet(isPresented: $showingAddFavouriteSheet) {
            FavouriteAddView()
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    FavouritesView(
        mode: 0,
        conversionBaseCurrency: .constant("usd"),
        conversionWantedCurrency: .constant("gbp")
    )
}
