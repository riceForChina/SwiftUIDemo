//
//  MyParclesView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/5.
//

import SwiftUI
// 无法优雅的实现富文本点击，
struct MyParclesView: View {
    
    var body: some View {
        VStack{

                HStack(spacing: 0) {
                    Group {
                        Text("已阅读并同意")
                                .font(.system(size: 13))
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                    }
                    Group {
                        Text("《用户协议》")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                print("《隐私政策》 ")
                            }
                    }
                    
                    Group {
                        Text("和")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                    }
                    
                    Group {
                        Text("《隐私政策》")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                print("《隐私政策》 ")
                            }
                    }
                    
                    Group {
                        Text("。未注册用户将会自动注册成为新用户。")
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                    }
                    Spacer()
                }
        }
        
    }
}

struct MyParclesView_Previews: PreviewProvider {
    static var previews: some View {
        MyParclesView()
    }
}
