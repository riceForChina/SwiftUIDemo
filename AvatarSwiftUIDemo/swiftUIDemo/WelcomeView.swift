//
//  WelcomeView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI
import AVKit
import AVFoundation

struct WelcomeView: View {
    
    @State private var isActive : Bool = false
    
    @State var showModal = false
    
    @Environment(\.isPresented) private var isPresented
    
    var body: some View {
        return NavigationView {
            mainView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$isActive)
        .fullScreenCover(isPresented: $showModal) {
            LoginView()
        }
    }
    
    func mainView() -> some View {
        
        return ZStack {
            Image("onboard.bg.light")
            PlayerView()
            VStack {
                Image("logo_onboard").padding(EdgeInsets(top: 99, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
            //底部
            VStack {
                Spacer()
                VStack {
                    VStack {
                        Text("欢迎来到壳儿")
                            .font(.system(size: 30))
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor.black))
                        Spacer()
                        Text("立即开启全新社交体验")
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor.gray))
                    }.frame(height: 64)
                    Spacer()
//                    Button {
//                        self.showModal.toggle()
//                    } label: {
//
//                    }

                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(), isActive: self.$isActive) {
                        Text("登录/注册")
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .frame(height: 60)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 154/255.0, green: 235/255.0, blue: 39/255.0, alpha: 1)), Color(UIColor(red: 207/255.0, green: 246/255.0, blue: 139/255.0, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                    }
                }
                .frame(height: 213)
                .padding(.vertical, 50)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
