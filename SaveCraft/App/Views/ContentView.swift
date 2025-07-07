//
//  ContentView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-06-30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.currentUser != nil {
                MainAppView()
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    ContentView()
}
