//
//  LoginView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @Environment(\.dismiss) var dismiss
    
    @State var title: String = ""
    
    @State private var isActive : Bool = false
    
    private var temp = DeallocPrinter(name: "LoginView")
    
    @StateObject var textFileWrapper: TextFileObservable = TextFileObservable(limiteNum: 11, limiteIsNum: true)
    
    @StateObject var codeObservalbe: TextFileObservable = TextFileObservable(limiteNum: 6, limiteIsNum: true)
    
    @FocusState private var focusUser:Bool;
    
    var body: some View {
        mainView()
    }
    
    func mainView() -> some View {
        
        print("textFile = \(self.textFileWrapper.text)")
        
        return VStack {
            Image("login_logo_light").padding(.vertical,50)
            createTextFile(text: $textFileWrapper.text, placeholder: "请输入手机号")
                .focused($focusUser)
                .onAppear {
                    self.focusUser = true
                }
            ZStack {
                createTextFile(text: $codeObservalbe.text, placeholder: "请输入验证码")
                AnyView(HStack(content: {
                    Spacer()
                    Button {
                        print("onClickCode")
                    } label: {
                        Text("获取验证码")
                            .frame(height: 60)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.horizontal, 30)
                    }
                }))
            }
            HStack {
                AnyView(getSomeText())
                    .padding(.horizontal,30)
                Spacer()
            }
            
//            Button {
//                dismiss()
//            } label: {
//
//            }

            NavigationLink(destination: TabbarView().navigationBarBackButtonHidden(), isActive: self.$isActive) {
                Text("登录")
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 60)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 154/255.0, green: 235/255.0, blue: 39/255.0, alpha: 1)), Color(UIColor(red: 207/255.0, green: 246/255.0, blue: 139/255.0, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
            }
            Spacer()
        
        }
        .frame(minHeight: 0,maxHeight: .infinity)
        .background(Color(UIColor(hexString: "#F2F2F2")))
    }
    
    func createTextFile(text: Binding<String>, placeholder: String) -> some View {
        TextField(text: text, axis: .horizontal) {
            Text(placeholder)
                .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                .font(.system(size: 16))
                .fontWeight(.medium)
            
        }
        .foregroundColor(.black)
        .font(.system(size: 16))
        .fontWeight(.medium)
        .keyboardType(.numberPad)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .frame(minWidth: 0,maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(16)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
    
    func getSomeText() -> some View {
        return Text("已阅读并同意")
                .font(.system(size: 13))
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                + Text("《用户协议》")
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(Color.red)
                + Text("和")
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
                + Text("《隐私政策》")
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(Color.red)
                + Text("。未注册用户将会自动注册成为新用户。")
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(hexString: "#3C3C3C")))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
