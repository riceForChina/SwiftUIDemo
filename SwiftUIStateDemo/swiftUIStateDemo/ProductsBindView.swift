//
//  ProductsBindView.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

struct FilterView: View {
    @Binding var showFavorited: Bool

    var body: some View {
        Button(
            action: {
                self.showFavorited = !self.showFavorited
            },
            label: { Text("Change filter") }
        )
    }
}

struct ProductsBindView: View {
    let products: [Product] = [Product(id: "测试1")]
    
    @State private var showFavorited: Bool = false

    var body: some View {
        List {
            FilterView(showFavorited: $showFavorited)

            ForEach(products) { product in
                if !self.showFavorited {
                    Text(product.id)
                }
            }
        }
    }
}

struct ProductsBindView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsBindView()
    }
}
