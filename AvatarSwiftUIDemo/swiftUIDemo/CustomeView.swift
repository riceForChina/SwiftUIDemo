//
//  CustomeView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/8.
//

import SwiftUI

struct CustomeView: View {

    var body: some View {
        VStack {
            Image("square_tab_icon")
            Spacer()
            Button {
                
            } label: {
                Image("square_tab_icon")
                Text("title")
            }
        }
        
    }
}

//struct CustomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomeView()
//    }
//}
