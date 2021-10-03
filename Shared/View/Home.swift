//
//  Home.swift
//  SwiftUI_ChatApp (iOS)
//
//  Created by park kyung seok on 2021/09/28.
//

import SwiftUI

var screen = NSScreen.main!.visibleFrame

struct Home: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            //一番左要素 (TabButtons)
            VStack {
                
                // Tab Buttons
                TabButton(image: "message", title: "All Chats", selectedTab: $viewModel.selectedTab)
                
                TabButton(image: "person", title: "Personal", selectedTab: $viewModel.selectedTab)
                
                TabButton(image: "bubble.middle.bottom", title: "Bots", selectedTab: $viewModel.selectedTab)
                
                TabButton(image: "slider.horizontal.3", title: "Edit", selectedTab: $viewModel.selectedTab)
                
                Spacer()
                
                TabButton(image: "gear", title: "Settings", selectedTab: $viewModel.selectedTab)
            }
            .padding()
            .padding(.top, 35)
            .background(BlurView())
            
            // Tab Content Area
            ZStack {
                
                switch viewModel.selectedTab {
                case "All Chats": NavigationView { AllChatsView() } 
                case "Personal": Text("Personal")
                case "Bots": Text("Bots")
                case "Edit": Text("Edit")
                case "Settings": Text("Settings")
                default: Text("")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: screen.width / 2, height: screen.height / 2)
        .environmentObject(viewModel)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
