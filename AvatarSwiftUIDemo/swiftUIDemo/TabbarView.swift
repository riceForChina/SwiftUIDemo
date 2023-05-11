//
//  TabbarView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/28.
//

import SwiftUI

struct TabbarView: View {
    
    @State var selectedTab = Tab.profile
    
    private var temp = DeallocPrinter(name: "TabbarView")
    
    enum Tab: Int {
        case other, profile
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(image)
                .resizable()
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OtherView().tabItem{
                self.tabbarItem(text: "Other", image: "square_tab_icon")
            }.tag(Tab.other)
            ProfileView().tabItem{
                self.tabbarItem(text: "Profile", image: "square_tab_icon")
            }.tag(Tab.profile)
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
