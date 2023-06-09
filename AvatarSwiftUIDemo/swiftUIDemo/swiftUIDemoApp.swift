//
//  swiftUIDemoApp.swift
//  swiftUIDemo
//
//  Created by fan.qile on 2023/4/17.
//

import SwiftUI

@main
struct swiftUIDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WelcomeView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
