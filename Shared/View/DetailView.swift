//
//  DetailView.swift
//  SwiftUI_ChatApp
//
//  Created by park kyung seok on 2021/10/03.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    var user: RecentMessage
    
    var body: some View {
        
        HStack {
            
            VStack {
                
                HStack {
                    
                    Text(user.userName)
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: { }) {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        withAnimation {
                            viewModel.isExpandedInspector.toggle()
                        }
                    }) {
                        
                        Image(systemName: "sidebar.right")
                            .font(.title2)
                            .foregroundColor(viewModel.isExpandedInspector ? .blue : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                
                // MessageView
                MessageView(user: user)
                
                
                HStack(spacing: 15) {
                    
                    Button(action: { }) {
                        
                        Image(systemName: "paperplane")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    TextField("Enter Message", text: $viewModel.message, onCommit: {
                        viewModel.sendMessage(user: user)
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .clipShape(Capsule())
                        .background(Capsule().strokeBorder(Color.white))
                    
                    Button(action: { }) {
                        
                        Image(systemName: "face.smiling.fill")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { }) {
                        
                        Image(systemName: "mic")
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding([.horizontal, .bottom])
            }
            
            
            InspectorView(user: user)
                .frame(width: viewModel.isExpandedInspector ? 300 : 0)
                .background(BlurView())
                .opacity(viewModel.isExpandedInspector ? 1 : 0)

        }
        .ignoresSafeArea()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
       Home()
    }
}


// MessageView

struct MessageView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel

    var user: RecentMessage

    
    var body: some View {
        
        GeometryReader { reader in
            ScrollView {
                
                //スクロールビューの子要素の位置にスクロールするときなど使う
                ScrollViewReader { proxy in
                    
                    VStack(spacing: 18) {
                        ForEach(user.allMsgs) { message in
                            
                            //MessageCardView
                            MessageCardView(message: message, user: user, screenWidth: reader.frame(in: .global).width)
                                .tag(message.id)
                        }
                        .onAppear(perform: {
                            //この辺が画面描画される(呼ばれる)
                            
                            guard let lastId = user.allMsgs.last?.id else { return }
                            
                            //ここが表示されたらメッセージのラストまでスクロールさせる
                            proxy.scrollTo(lastId, anchor: .top)
                        })
                        .onChange(of: user.allMsgs, perform: { value in
                                                        
                            guard let lastId = user.allMsgs.last?.id else { return }
                            
                            //メッセージのラストまでスクロールさせる
                            proxy.scrollTo(lastId, anchor: .top)
                        })
                      
                    }
                    .padding(.bottom, 30)
                    
                }
                
               
            }
        }
       
    }
}

struct MessageCardView: View {
    
    var message: Message
    var user: RecentMessage
    var screenWidth: CGFloat
    
    var body: some View {
    
        HStack(spacing: 10) {
            
            if message.myMessage {
                //自分のメッセージは右に寄せる
                Spacer()
                
                Text(message.message)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: screenWidth / 2, alignment: .trailing)
            } else {
                
                Image(user.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .offset(y: 20)
                
                Text(message.message)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.primary.opacity(0.2))
                    .clipShape(MessageBubble())
                    .frame(minWidth: 0, maxWidth: screenWidth / 2, alignment: .leading)
                //相手のメッセージは左に寄せる
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        
    }
}

struct MessageBubble: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            let point1 = CGPoint(x: 0, y: 0)
            let point2 = CGPoint(x: rect.width, y: 0)
            let point3 = CGPoint(x: rect.width, y: rect.height)
            let point4 = CGPoint(x: 0, y: rect.height)
            
            path.move(to: point4)
            
            path.addArc(tangent1End: point4, tangent2End: point1, radius: 15)
            path.addArc(tangent1End: point1, tangent2End: point2, radius: 15)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: 15)
            path.addArc(tangent1End: point3, tangent2End: point4, radius: 15)
        }
    }
}



// ExpentedInspectorView

struct InspectorView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel

    var user: RecentMessage

    var body: some View {
        
        HStack(spacing: 0) {
            
            Divider()
            
            VStack(spacing: 25) {
                
                Image(user.userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .padding(.top, 35)
                
                Text(user.userName)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    
                    Button(action: { }) {
                        
                        VStack {
                            Image(systemName: "bell.slash")
                                .font(.title2)
                            
                            Text("Mute")
                        }
                     
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: { }) {
                        
                        VStack {
                            Image(systemName: "hand.raised.fill")
                                .font(.title2)
                            
                            Text("Block")
                        }
                     
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: { }) {
                        
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.title2)
                            
                            Text("Report")
                        }
                     
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Picker(selection: $viewModel.pickedTab, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                    Text("Media")
                        .tag("Media")
                    
                    Text("Links")
                        .tag("Links")
                    
                    Text("Audio")
                        .tag("Audio")
                    
                    Text("Files")
                        .tag("Files")
                })
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
                .padding(.vertical)
                
                ScrollView {
                    
                    if viewModel.pickedTab == "Media" {
                        
                        //Grid of Photos
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), content: {
                            
                            
                            ForEach(1...8, id: \.self) { index in
                                
                                Image("media\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(3)
                            }
                        })
                    }
                }
                
                
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
}
