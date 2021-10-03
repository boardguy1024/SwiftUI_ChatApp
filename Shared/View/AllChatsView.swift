//
//  AllChatsView.swift
//  SwiftUI_ChatApp
//
//  Created by park kyung seok on 2021/10/03.
//

import SwiftUI

struct AllChatsView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        
    
        VStack {
            
            
            HStack {
                
                Spacer()
                
                Button(action: { }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $viewModel.search)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.15))
            .cornerRadius(10)
            .padding()
            
            List(selection: $viewModel.selectedRecentMsg) {
                ForEach(viewModel.msgs) { message in
                    
                    NavigationLink(
                        destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                        label: {
                            RecentCardView(recentMsg: message)

                        })
                    
                }
            }
            .listStyle(SidebarListStyle())
        }
        
       
       
    }
}

struct AllChatsView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
