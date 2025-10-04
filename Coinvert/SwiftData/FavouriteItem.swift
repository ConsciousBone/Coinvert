//
//  FavouriteItem.swift
//  Coinvert
//
//  Created by Evan Plant on 04/10/2025.
//

import Foundation
import SwiftData

@Model class FavouriteItem {
    var base: String = ""
    var wanted: String = ""
    var displayMode: Int = 0 // 0 is base + want, 1 is base, 2 is want
    var id = UUID()
    
    init(base: String = "", wanted: String = "", displayMode: Int = 0, id: UUID = UUID()) {
        self.base = base
        self.wanted = wanted
        self.displayMode = displayMode
        self.id = id
    }
}
