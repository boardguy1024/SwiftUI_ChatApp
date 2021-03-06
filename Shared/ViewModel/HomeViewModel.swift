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
    
    @Published var message = ""
    
    // 右のインスペクターのshow&hide
    @Published var isExpandedInspector = false
    
    @Published var pickedTab = "Media"
    
    // Send Message
    
    func sendMessage(user: RecentMessage) {
        
        guard message != "" else { return }
        
        let index = msgs.firstIndex { currentUser -> Bool in
            return currentUser.id == user.id
        } ?? -1
        
        if index != -1 {
            msgs[index].allMsgs.append(Message(message: message, myMessage: true))
            message = ""
        }
    }
}
