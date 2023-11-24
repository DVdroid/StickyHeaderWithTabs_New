//
//  Tab.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 23/11/23.
//

import SwiftUI

//Tab model with Tab items...

struct Tab: Identifiable {
    var id: String = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var tabsItems: [Tab] = [
    .init(tab: "Order again", foods: foods.shuffled()),
    .init(tab: "Picked For You", foods: foods.shuffled()),
    .init(tab: "Starters", foods: foods.shuffled()),
    .init(tab: "Gimpub Sushi", foods: foods.shuffled())
]
