//
//  SlidingSheet.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 14/3/22.
//

import SwiftUI

struct SlidingSheet: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var contentVM: ContentVM
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    
    @GestureState var gestureOffset: CGFloat = 0
    
    @State var showMediumInfo = false
    
    var height: CGFloat
    
    var body: some View {
        ZStack {
            BlurView(style: .systemThinMaterial)
                .cornerRadius(30)
            
            VStack {
                Capsule()
                    .fill(colorScheme == .dark ? .white : .black)
                    .frame(width: 60, height: 4)
                    .padding(.top)
                
                if (showMediumInfo) {
                    VStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .overlay {
                                HStack {
                                    Text("Red team's victories: \(contentVM.redVictories)")
                                        .font(.headline)
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                        .frame(width: 60, height: 60)
                                        .padding(10)
                                        .overlay {
                                            Text("\(contentVM.redPercentualVictories.formatted(.number.precision(.fractionLength(0))))%")
                                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                            
                                        }
                                        .overlay {
                                            Circle()
                                                .trim(from: 0.0, to: contentVM.redPercentualVictories / 100)
                                                .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                                .rotationEffect(.degrees(-90))
                                                .frame(width: 60, height: 60)
                                        }
                                }
                            }
                            .frame(height: 80)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .overlay {
                                HStack {
                                    Text("Yellow team's victories: \(contentVM.yellowVictories)")
                                        .font(.headline)
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                        .frame(width: 60, height: 60)
                                        .padding(10)
                                        .overlay {
                                            Text("\(contentVM.yellowPercentualVictories.formatted(.number.precision(.fractionLength(0))))%")
                                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                            
                                        }
                                        .overlay {
                                            Circle()
                                                .trim(from: 0.0, to: contentVM.yellowPercentualVictories / 100)
                                                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                                .rotationEffect(.degrees(-90))
                                                .frame(width: 60, height: 60)
                                        }
                                    
                                    
                                }
                            }
                            .frame(height: 80)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .padding([.top, .trailing, .leading], 30)
                    
                }
                
                
                HStack {
                    Button {
                        offset = 0
                        lastOffset = 0
                        showMediumInfo = false
                        contentVM.startGame()
                        
                    } label: {
                        (Label("Restart game", systemImage: "gamecontroller.fill"))
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    Button {
                        offset = 0
                        lastOffset = 0
                        showMediumInfo = false
                        contentVM.initPoints()
                    } label: {
                        (Label("Reset score", systemImage: "arrow.counterclockwise"))
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                
                .padding(.top)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .offset(y: height - 130)
        .offset(y: -offset > 0 ? -offset <= (height - 130) ? offset : -(height - 130) : 0)
        .gesture(
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                })
                .onEnded({ value in
                    let maxHeight = height - 130
                    withAnimation {
                        if -offset > 100 && -offset < maxHeight / 2 {
                            offset = -(maxHeight / 3)
                        } else if -offset > maxHeight / 2 {
                            offset = -maxHeight
                        } else {
                            offset = 0
                        }
                    }
                    
                    lastOffset = offset
                }))
    }
    
    func onChange() {
        DispatchQueue.main.async {
            offset = gestureOffset + lastOffset
            let maxHeight = height - 100
            if -offset > 100 && -offset < maxHeight / 2 {
                withAnimation {
                    showMediumInfo = true
                }
            } else if -offset > maxHeight / 2 {
                withAnimation {
                    showMediumInfo = true
                }
            } else {
                withAnimation {
                    showMediumInfo = false
                }
            }
        }
    }
}

struct SlidingSheet_Previews: PreviewProvider {
    static var previews: some View {
        SlidingSheet(contentVM: ContentVM(), offset: 300, lastOffset: 300, gestureOffset: 0, showMediumInfo: true, height: 700)
    }
}
