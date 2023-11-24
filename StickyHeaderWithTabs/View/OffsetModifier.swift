//
//  OffsetModifier.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 24/11/23.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    var tab: Tab
    @Binding var currentTab: String
    func body(content: Content) -> some View {
        content
            .overlay(
                //Getting scroll offset using geometry reader
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: OffsetKey.self,
                            value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self, perform: { proxy in
                //If minY is b/w 20 to -half of the midX
                //then updating current tab...
                let offset = proxy.minY
                //Top area plus header size 100
                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 60
                DispatchQueue.main.async {
                    currentTab = (
                        offset < 100 && -offset < (proxy.midX / 2) && currentTab != tab.id
                    )
                    ? tab.id
                    : currentTab
                }
            })
    }
}

#Preview {
    Home()
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

