//
//  ProfileView.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/28.
//

import SwiftUI

struct ProfileView: View {
    
    private var temp = DeallocPrinter(name: "ProfileView")
    
    @StateObject fileprivate var viewModel = ProfileViewModel()
    
    @State fileprivate var offsetY: CGFloat = 0
    
    fileprivate var topMagin: CGFloat = 160
    fileprivate var nickeNameTopMargin: CGFloat = 40.0
 
    @State fileprivate var toastStr: String = ""
    @State fileprivate var showToast: Bool = false
    
    var body: some View {
        
        let avatarImageMinWH: CGFloat = 50
        let avatarIamgeMaxWH: CGFloat = 130
        var avatarImageWH: CGFloat = avatarIamgeMaxWH
        
        let avartarMaxTop = topMagin + nickeNameTopMargin - avatarIamgeMaxWH
        var avatarTop = avartarMaxTop
        
        var showMinAvatar: Bool = false
        if offsetY > 0 {
            
            let moveNum:CGFloat = 20
            let scallNum:CGFloat = (moveNum - (offsetY))/moveNum
            
            avatarImageWH = avatarIamgeMaxWH - (1 - scallNum) * (avatarIamgeMaxWH - avatarImageMinWH)
            
            if avatarImageWH <= avatarImageMinWH {
                avatarImageWH = avatarImageMinWH
                
                if (topMagin - (offsetY)) <= (avartarMaxTop + avatarImageMinWH) {
                    avatarTop = avatarTop - (offsetY - 40)
                }
                
                if avatarTop > avartarMaxTop {
                    avatarTop = avartarMaxTop
                }
                
                if avatarTop <= (safeAreaTopMargin() + 10) {
                    showMinAvatar = true
                    avatarTop = safeAreaTopMargin() + 10
                }
            }
        }
      
        return ZStack {
            VStack {
                Image("profile_bg")
                ScrollViewObservertView(offset: $offsetY)
                Spacer()
            }.padding(EdgeInsets(top: offsetY < 0 ? 0 : -(offsetY), leading: 0, bottom: 0, trailing: 0))
            self.getListView()
            if !showMinAvatar {
                VStack {
                    RemoveImage(url: viewModel.user?.avatarUrl ?? "")
                        .frame(width: avatarImageWH,height: avatarImageWH)
                        .background(.red)
                        .padding(EdgeInsets(top: avatarTop, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
            }
            
            VStack {
                if showMinAvatar {
                    HStack {
                        RemoveImage(url: viewModel.user?.avatarUrl ?? "")
                            .frame(width: avatarImageMinWH,height: avatarImageMinWH)
                            .background(.red)
                            .padding(EdgeInsets(top: 10 + safeAreaTopMargin(), leading: 0, bottom: 0, trailing: 0))
                            .ignoresSafeArea()

                    }
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 60)
                    .padding(EdgeInsets(top: safeAreaTopMargin(), leading: 0, bottom: 0, trailing: 0))
                }
                Spacer()
            }
            
        }
        .background(Color(UIColor(hexString: "#F2F2F2")))
        .ignoresSafeArea()
        .onAppear(){
            self.viewModel.reloadData()
        }
        .toast(message: self.toastStr, isShowing: $showToast)
    }
    
    func getListView() -> some View {
        List {
            Section {
                mainView()
                    .removeListRowBackground()
                    .removeListRowInsets()
            }
            
            Section {
                if self.viewModel.list.count > 0 {
                    ForEach(self.viewModel.list, id: \.self) { model in
                        feedCell(model: model)
                    }
                } else {
                    feedEmptyView()
                }
            }.removeListRowInsets()
            
        }
        .listStyle(.plain)
        .frame(minWidth: 0,maxWidth: .infinity)
    }
    
    func mainView() -> some View {//自拍
        return VStack(spacing: 0, content: {
            HStack {
                Text(self.viewModel.user?.nickName ?? "")
                Image("female_icon")
            }.padding(EdgeInsets(top: nickeNameTopMargin, leading: 0, bottom: 0, trailing: 0))
            Text("壳ID：\(self.viewModel.user?.userId ?? "")")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            middleButtonList()
            HStack() {
                Text("我的动态")
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        })
        .frame(minWidth: 0,maxWidth: .infinity)
        .background(RoundedCorners(color: Color(UIColor(hexString: "#F2F2F2")), tl: 20, tr: 20, bl: 0, br: 0))
        .padding(.top,topMagin)
        .listRowSeparator(.hidden)
        
    }
    
    func middleButtonList() -> some View {
        return HStack(spacing: 10) {
            Button {
                self.toastStr = "点击自拍"
                self.showToast = true
            } label: {
                HStack {
                    Image("profile_group_photo")
                    Text("自拍")
                }.frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(13)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            }
            
            Button {
                self.toastStr = "点击邀请好友"
                self.showToast = true
            } label: {
                HStack {
                    Image("profile_share")
                    Text("邀请好友")
                }.frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(13)
                    .padding(.trailing,20)
            }
            

        }
    }
    
    func feedEmptyView() -> some View {
        return VStack(spacing: 20) {
            Image("feed_empty")
                .frame(width: 80,height: 80)
            Text("你还没有发布过动态")
            Button {
                self.toastStr = "点击发布"
                self.showToast = true
            } label: {
                Text("发布")
                    .frame(width: 140,height: 50)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 154/255.0, green: 235/255.0, blue: 39/255.0, alpha: 1)), Color(UIColor(red: 207/255.0, green: 246/255.0, blue: 139/255.0, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20)
                

            }
        }
        .frame(minWidth: 0,maxWidth: .infinity)
        .padding(.vertical,40)
        .listRowSeparator(.hidden)
    }
    
    func feedCell(model: CommentModel) -> some View {
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                RemoveImage(url: model.user.avatarUrl)
                    .frame(width: 60,height: 60)
                    .background(.red)
                    .cornerRadius(13)
                VStack(alignment: .leading) {
                    Text(model.user.nickName)
                    Text(model.createTime)
                }
                Spacer()
            }
            
            RemoveImage(url: model.feedUrl)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 467)
                .background(.red)
                .cornerRadius(13)
                .padding(.top,10)
            
            Text(model.title)
                .padding(.top,10)
            
            HStack() {
                Button {
                    self.toastStr = "点击点赞"
                    self.showToast = true
                } label: {
                    Text("点赞")
                }

                Button {
                    self.toastStr = "点击评论"
                    self.showToast = true
                } label: {
                    Text("评论")
                }
                
                Button {
                    self.toastStr = "点击分享"
                    self.showToast = true
                } label: {
                    Text("分享")
                }
                
                Spacer()
                Button {
                    self.toastStr = "点击更多"
                    self.showToast = true
                } label: {
                    Text("更多")
                }
            }.frame(minWidth: 0,maxWidth: .infinity)
                .frame(height: 60)

        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .background(Color(UIColor(hexString: "#F2F2F2")))
        .listRowSeparator(.hidden)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
