//
//  ContentViewiPad.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 17/3/22.
//

import SwiftUI

struct ContentViewiPad: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var contentVM: ContentVM
    
    var body: some View {
        GeometryReader { proxy in
          let height = proxy.frame(in: .global).height
            let width = proxy.frame(in: .global).width
            HStack {
                VStack {
                    Text("Connect4!")
                        .font(.title)
                        .padding()
                    
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
                    
                    HStack {
                        Button {
                            contentVM.startGame()
                            
                        } label: {
                            (Label("Restart game", systemImage: "gamecontroller.fill"))
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(Capsule())
                        }
                        Button {
                            contentVM.initPoints()
                        } label: {
                            (Label("Reset score", systemImage: "arrow.counterclockwise"))
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(Capsule())
                        }
                    }
                }
                .frame(width: 400)
                .padding(.trailing, 80)
                
                VStack {
                    GameTableView(contentVM: contentVM, height: height)
                        .padding()
                    
                    Spacer()
                }
            }
            .frame(width: width)
        }
        .alert(isPresented: $contentVM.showAlert) {
            Alert(title: Text("Victory!"), message: Text("The \(contentVM.team.rawValue) team won"), primaryButton: .default(Text("New Game"), action: {
                contentVM.startGame()
            }), secondaryButton: .cancel())
        }
        
    }
}

struct ContentViewiPad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewiPad(contentVM: ContentVM())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
