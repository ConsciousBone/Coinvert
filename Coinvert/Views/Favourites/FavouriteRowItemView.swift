//
//  FavouriteRowItemView.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import SwiftUI

struct FavouriteRowItemView: View {
    @Binding var title: String
    @Binding var baseCurrency: String
    @Binding var wantedCurrency: String
    
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
        title: .constant("USD to GBP"), // example data
        baseCurrency: .constant("usd"), // example data
        wantedCurrency: .constant("gbp") // example data
    )
}
