//
//  ProductsView.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

struct Product: Identifiable {

    var id: String
}

struct ProductsView: View {
    let products: [Product] = [Product(id: "测试1")]

    @State private var showFavorited: Bool = false
    
    var body: some View {
        List {
            Button(
                action: {
                    
                    self.showFavorited = !self.showFavorited
                },
                label: { Text("Change filter") }
            )

            ForEach(products) { product in
                if !self.showFavorited {
                    Text(product.id)
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
