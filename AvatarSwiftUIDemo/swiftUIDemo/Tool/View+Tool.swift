//
//  View+Tool.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/5.
//

import SwiftUI

extension View {
    func removeListRowBackground() -> some View {
        return self.listRowBackground(//去掉背景色。。
                Text("")
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .background(.gray)
            )
    }
    
    func removeListRowInsets() -> some View {
        return self.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))//去掉间距
    }
}

extension View {
    func safeAreaTopMargin() -> CGFloat {
        return 47
    }
}
