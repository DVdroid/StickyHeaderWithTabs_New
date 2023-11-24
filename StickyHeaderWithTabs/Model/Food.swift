//
//  Food.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 23/11/23.
//

import Foundation
struct Food: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

var foods: [Food] = [
    .init(title: "Choclate Cake", description: "Chocolate cake or chocolate gateau is a cake flavoured with mealted chocolate, cocoa powder, or both", price: "$19", image: "chocolates"),
    .init(title: "Cookies", description: "A biscuit is a flour-based baked food product. Outside North America the biscuit is typically hard, flat, and unleavened", price: "$10", image: "cookies"),
    .init(title: "Sandwich", description: "Trim the bread from all sides and apply butter on one bread, then apply the greeen chutney all over.", price: "$9", image: "sandwich"),
    .init(title: "French Fries", description: "French fries, or simply fries, chips, finger chips, or French-fired potatoes, are batonnent or allumette-cut deep-fried potatoes.", price: "$15", image: "fries"),
    .init(title: "Pizza", description: "Pizza is a savory dish of Italian origin consisting of a usually round, falttened based of leavened wheat-based dough topped", price: "$39", image: "pizza")
]
