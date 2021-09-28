//
//  BlurView.swift
//  SwiftUI_ChatApp
//
//  Created by park kyung seok on 2021/09/28.
//

import SwiftUI

struct BlurView: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow // MacOSの半透明モード
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) { }
}
