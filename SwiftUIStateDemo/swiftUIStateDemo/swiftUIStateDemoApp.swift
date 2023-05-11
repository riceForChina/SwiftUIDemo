//
//  swiftUIStateDemoApp.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

@main
struct swiftUIStateDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        let player = PodcastPlayer()
        WindowGroup {
            EpisodesViewEnvironmentObject()
                .environmentObject(player)
        }
    }
}
