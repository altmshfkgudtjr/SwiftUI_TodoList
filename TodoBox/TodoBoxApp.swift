//
//  TodoBoxApp.swift
//  TodoBox
//
//  Created by 김형석 on 2021/01/09.
//

import SwiftUI

@main
struct TodoBoxApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
