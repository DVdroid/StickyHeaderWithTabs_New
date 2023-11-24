//
//  HomeViewModel.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 23/11/23.
//

import Foundation
final class HomeViewModel: ObservableObject {
    init(offset: CGFloat = .zero) {
        self.offset = offset
    }
    @Published var offset: CGFloat
    @Published var selectedtab = tabsItems.first!.tab
}
