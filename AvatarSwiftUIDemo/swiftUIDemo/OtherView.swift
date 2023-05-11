//
//  OtherView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

struct OtherView: View {
    
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    private var temp = DeallocPrinter(name: "OtherView")
    
    var body: some View {
        VStack {
            Button("退出登陆") {
                print("loginou")
                self.rootPresentationMode.wrappedValue.dismiss()
            }.foregroundColor(.black)
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .background(.red)
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
