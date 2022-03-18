//
//  GameTableView.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 17/3/22.
//

import SwiftUI

struct GameTableView: View {
    @ObservedObject var contentVM: ContentVM
    @State var touched = false
    
    let height:CGFloat
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(contentVM.elements) { element in
                Circle()
                    .strokeBorder(.black)
                    .frame(height: iPad ? height/8	 : height/12)
                    .frame(maxWidth: .infinity)
                    .background(Circle().foregroundColor(element.touched ? (element.team == .red ? .red : .yellow) : .white))
                    .onTapGesture {
                        contentVM.circleTouched(element: element)
                        touched.toggle()
                    }
            }
        }
    }
}

struct GameTableView_Previews: PreviewProvider {
    static var previews: some View {
        GameTableView(contentVM: ContentVM(), height: 600)
.previewInterfaceOrientation(.landscapeLeft)
    }
}
