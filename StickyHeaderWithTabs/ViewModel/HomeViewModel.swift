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
    var offset: CGFloat = .zero
    var yOffset: CGFloat = .zero
    @Published var selectedtab: String = "" {
        didSet {
            yOffset = .zero
        }
    }
    @Published var onTapCurrentTab: String = "" {
        didSet {
            yOffset = 150.0
        }
    }
}
