//
//  TabButton.swift
//  SwiftUI_ChatApp
//
//  Created by park kyung seok on 2021/09/28.
//

import SwiftUI

struct TabButton: View {
    
    var image: String
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        
        Button(action: {
            withAnimation {
                selectedTab = title
            }
        }) {
            
            VStack(spacing: 7) {
                
                Image(systemName: image)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(selectedTab == title ? .white : .gray)
                
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 11))
                    .foregroundColor(selectedTab == title ? .white : .gray)
            }
            .padding(.vertical, 8)
            .frame(width: 70)
            .contentShape(Rectangle()) // contentShapeを使うことで範囲内全てがタップ可能に
            .background(Color.primary.opacity(selectedTab == title ? 0.15 : 0))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//struct TabButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabButton()
//    }
//}
