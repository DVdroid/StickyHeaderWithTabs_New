//
//  HeaderView.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 23/11/23.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var homeData: HomeViewModel
    //For dark mode adoption
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: getButtonSize(), height: getButtonSize())
                        .foregroundColor(.primary)
                }
                
                Text("VA Backery")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Asiatisch . Koreanisch . Japnisch")
                        .font(.caption)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("30-40 Min")
                            .font(.caption)
                        
                        Text("4.3")
                            .font(.caption)
                        
                        Image(systemName: "star.fill")
                            .font(.caption)
                        
                        Text("$6.40 Fee")
                            .font(.caption)
                            .padding(.leading, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .opacity(homeData.offset > 200 ? 1 - Double((homeData.offset - 200) / 50) : 1)
                
                //Automatic scrolling
                ScrollViewReader { proxy in
                    //Custom ScrollView
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(tabsItems) { tab in
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Color.primary.opacity(homeData.selectedtab == tab.id ? 1 : 0))
                                    .clipShape(Capsule())
                                    .foregroundColor(
                                        homeData.selectedtab == tab.id
                                        ? scheme == .dark ? Color.black : Color.white
                                        : .primary
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut){
                                            homeData.onTapCurrentTab = tab.id
                                            proxy.scrollTo(tab.id, anchor: .center)
                                        }
                                    }
                            }
                            .onChange(of: homeData.selectedtab, perform: { value in
                                withAnimation(.easeOut) {
                                    proxy.scrollTo(homeData.selectedtab, anchor: .center)
                                }
                            })
                        }
                    }
                }
                //Visible only when scrolls up...
                .opacity(homeData.offset > 200 ? Double((homeData.offset - 200) / 50) : 0)
            }
            //Default frmae = 60
            // Top frame = 40
            // Total frame = 100
            .frame(height: 60)
            
            if homeData.offset > 250 {
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(scheme == .dark ? Color.black : Color.white)
    }
    
    private func getButtonSize() -> CGFloat {
        if homeData.offset > 200 {
            let progress = (homeData.offset - 200) / 50
            if progress <= 1.0 {
                return progress * 20
            } else {
                return 20
            }
        } else {
            return 0
        }
    }
}

#Preview {
    Home()
}
