//
//  PassGuardApp.swift
//  PassGuard
//

import SwiftUI

@main
struct PassGuardApp: App {
    
    @AppStorage ("onboardingStatus") public var onboarded = false                               //Stores whether or not the user has onboarded
    
    var body: some Scene {
        WindowGroup {
            
            //If the user hasen't onboarded, then give them the tutorial
            if !onboarded {
                OnboardingView()
            }
            //Once the user has onboarded, continue to the main app
            else {
                ContentView()
            }
        }
    }
}
