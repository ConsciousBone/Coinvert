//
//  FavouritesView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \modelContext.date, order: .reverse) var favouriteItems: [FavouriteItem]
    
    @Binding var mode: Int // 0 is base + wanted, 1 is base, 2 is wanted
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .toolbar {
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

#Preview {
    FavouritesView(mode: .constant(0))
}
