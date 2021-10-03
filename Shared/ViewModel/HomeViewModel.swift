//
//  HomeViewModel.swift
//  SwiftUI_ChatApp
//
//  Created by park kyung seok on 2021/09/28.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab = "All Chats"
    
    @Published var msgs: [RecentMessage] = recentMsgs
    
    // Selected Recent Tab
    @Published var selectedRecentMsg: String? = recentMsgs.first?.id
    
    // Search
    @Published var search = ""
}
