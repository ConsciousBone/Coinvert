//
//  FavouriteItem.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import Foundation
import SwiftData

@Model class FavouriteItem {
    var title: String = "" // name of fav
    var baseCurrency: String = "" // base currency obviously, currencyCode format
    var wantedCurrency: String = "" // convert to, currencyCode format
    var date: Date // for sorting purposes
    var id = UUID() // good practice i guess??
    
    init(title: String = "", baseCurrency: String = "", wantedCurrency: String = "", date: Date = .now, id: UUID = UUID()) {
        self.title = title
        self.baseCurrency = baseCurrency
        self.wantedCurrency = wantedCurrency
        self.date = date
        self.id = id
    }
}
