//
//  conecta4App.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 13/3/22.
//

import SwiftUI

@main
struct conecta4App: App {
    var body: some Scene {
        WindowGroup {
            Group {
                if (!iPad) {
                    ContentView(contentVM: ContentVM())
                } else {
                    ContentViewiPad(contentVM: ContentVM())
                }
            }
            
        }
    }
}
