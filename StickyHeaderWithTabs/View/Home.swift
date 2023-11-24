//
//  Home.swift
//  StickyHeaderWithTabs
//
//  Created by Vikash Anand on 23/11/23.
//


import SwiftUI

struct Home: View {
    @StateObject var homeData: HomeViewModel = .init()
    //For dark mode adoption
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    
                    //Parallax Header...
                    getHeaderImageView()
                        .frame(height: 250)
                    
                    //Cards...
                    Section(header: HeaderView()) {
                        
                        // Tabs with Content...
                        getSectionBodyView()
                            .offset(y: homeData.yOffset)
                            .onChange(of: homeData.onTapCurrentTab) { newValue in
                                withAnimation(.easeInOut) {
                                    proxy.scrollTo(newValue, anchor: .topLeading)
                                }
                            }
                    }
                })
            }
            //Setting coordinate space name for offset
            .coordinateSpace(name: "SCROLL")
            .overlay(
                (scheme == .dark ? Color.black : Color.white)
                    .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .ignoresSafeArea(.all, edges: .top)
                    .opacity(homeData.offset > 250 ? 1 : 0)
                ,alignment: .top
            )
            .onAppear {
                homeData.selectedtab = tabsItems.first?.tab ?? ""
            }
        }
        //Used it environment objct for accessing all sub objects...
        .environmentObject(homeData)
    }
    
    @ViewBuilder
    private func getHeaderImageView() -> some View {
        //Parallax Header...
        GeometryReader { reader -> AnyView in
            let offset = reader.frame(in: .global).minY
            if -offset >= 0 {
                DispatchQueue.main.async {
                    self.homeData.offset = -offset
                }
            }
            return AnyView(
                Image("food")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                    .cornerRadius(2)
                    .offset(y: (offset > 0 ? -offset : 0))
                    .overlay(
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "suit.heart.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                            .padding(), alignment: .top
                    )
            )
        }
    }
    
    @ViewBuilder
    private func getSectionBodyView() -> some View {
        ForEach(tabsItems) { tab in
            VStack(alignment: .leading, spacing: 15) {
                Text(tab.tab)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.leading)
                
                ForEach(tab.foods) { food in
                    CardView(food: food)
                }
                
                Divider()
                    .padding(.top)
            }
            .id(tab.id)
            .modifier(OffsetModifier(tab: tab, currentTab: $homeData.selectedtab))
            
            //            .overlay(
            //                GeometryReader { reader -> Text in
            //                    let offset = reader.frame(in: .global).minY
            //                    //Top area plus header size 100
            //                    let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
            //                    if offset < height && offset > 50 && homeData.selectedtab != tab.id {
            //                        DispatchQueue.main.async {
            //                            self.homeData.selectedtab = tab.id
            //                        }
            //                    }
            //
            //                    return Text("")
            //                }
            //            )
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
