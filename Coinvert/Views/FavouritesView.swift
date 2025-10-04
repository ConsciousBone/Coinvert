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
    
    let mode: Int // 0 is base + wanted, 1 is base, 2 is wanted, not used atm
    @Binding var conversionBaseCurrency: String
    @Binding var conversionWantedCurrency: String
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
                    .buttonStyle(.borderedProminent)
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
                            } label: {
                                FavouriteRowItemView(
                                    title: item.title,
                                    baseCurrency: item.baseCurrency,
                                    wantedCurrency: item.wantedCurrency
                                )
                            }
                        }
                    }
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
