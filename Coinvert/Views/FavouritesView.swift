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
    
    @Binding var mode: Int // 0 is base + wanted, 1 is base, 2 is wanted
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    FavouriteRowItemView(
                        title: .constant("USD to GBP"),
                        baseCurrency: .constant("usd"),
                        wantedCurrency: .constant("gbp")
                    )
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
                        print("opening new favourite view")
                    } label: {
                        Label("New Favourite", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    FavouritesView(mode: .constant(0))
}
