//
//  MainAppView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-06-30.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        
        TabView {
            Tab.init("Dashboard", systemImage: "chart.line.uptrend.xyaxis") {
                DashboardView()
            }
            
            Tab.init("Accounts", systemImage: "creditcard") {
                AccountsView()
            }
            
            Tab.init("Bills", systemImage: "list.bullet.rectangle.portrait") {
                FixedExpensesView()
            }
            
            
            Tab.init("Settings", systemImage: "gearshape", role: .search) {
                SettingsView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MainAppView()
}

