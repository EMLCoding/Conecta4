//
//  ContentView.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 13/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentVM: ContentVM
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let height = proxy.frame(in: .global).height
                VStack {
                    Text("Connect4!")
                        .font(.title)
                        .padding()
                    
                    GameTableView(contentVM: contentVM, height: height)
                        .padding()
                    
                    Spacer()
                    
                }
                
                SlidingSheet(contentVM: contentVM, height: height)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        
        .alert(isPresented: $contentVM.showAlert) {
            Alert(title: Text("Victory!"), message: Text("The \(contentVM.team.rawValue) team won"), primaryButton: .default(Text("New Game"), action: {
                contentVM.startGame()
            }), secondaryButton: .cancel())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentVM())
    }
}
