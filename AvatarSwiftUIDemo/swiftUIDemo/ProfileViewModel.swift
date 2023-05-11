//
//  ProfileViewModel.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/5/6.
//

import Foundation

struct User: Hashable {
    var id: String
    var avatarUrl: String
    var nickName: String
    var userId: String
    
    init(id: String, avatarUrl: String, nickName: String, userId: String) {
        self.id = id
        self.avatarUrl = avatarUrl
        self.nickName = nickName
        self.userId = userId
    }
}

struct CommentModel: Hashable {
    var id: String
    var title: String
    var feedUrl: String
    var createTime: String
    var user: User
    
    init(id: String, title: String, feedUrl: String, createTime: String, user: User) {
        self.id = id
        self.title = title
        self.feedUrl = feedUrl
        self.createTime = createTime
        self.user = user
    }
}

class ProfileViewModel: ObservableObject {
    
    @Published var list:[CommentModel] = []
    
    @Published var user: User?
    
    func reloadData() {
        
        print("reloadData")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.handleData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                let tempUser = User(
                    id:"1137896",
                    avatarUrl: "https://avatarcdn.imkaka.com/album2d/EB/40/EB40DDFC-1AEF-4484-2C37-79C1636106EA20230427_M.webp",
                    nickName: "nickname341243",
                    userId: "1137896")
                self.user = tempUser
            })
        })
        
    }
 
    func handleData() {
        let tempUser = User(
            id:"1137896",
            avatarUrl: "https://avatarcdn.imkaka.com/album2d/EB/40/EB40DDFC-1AEF-4484-2C37-79C1636106EA20230427_M.webp",
            nickName: "nickname",
            userId: "1137896")
        self.user = tempUser
        
        var tempList: [CommentModel] = []
        for item in 0..<10 {
            tempList.append(CommentModel(id: "\(item)",
                                         title: "测试",
                                         feedUrl: "https://avatarcdn.imkaka.com/moment/A2/AB/A2AB38B8-460E-62D4-C9A9-FF74FC47682620230504_B.webp",
                                         createTime: "以前",
                                         user: tempUser))
        }
        self.list = tempList
    }
}
