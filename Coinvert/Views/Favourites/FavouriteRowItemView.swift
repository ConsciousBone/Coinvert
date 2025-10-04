//
//  FavouriteRowItemView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI

struct FavouriteRowItemView: View {
    let title: String
    let baseCurrency: String
    let wantedCurrency: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                Divider()
                Text("\(baseCurrency) to \(wantedCurrency)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Image(systemName: "chevron.right") // nice lil indicator, why not
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    FavouriteRowItemView(
        title: "USD to GBP", // example data
        baseCurrency: "usd", // example data
        wantedCurrency: "gbp" // example data
    )
}
