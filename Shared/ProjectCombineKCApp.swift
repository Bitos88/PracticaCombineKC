//
//  ProjectCombineKCApp.swift
//  Shared
//
//  Created by Alberto Alegre Bravo on 23/9/21.
//

import SwiftUI

@main
struct ProjectCombineKCApp: App {
    
    @StateObject var herosViewModel = ViewModelHeros()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(herosViewModel)
            
        }
    }
}
