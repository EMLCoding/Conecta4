//
//  model.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 13/3/22.
//

import SwiftUI

enum Team: String {
    case red, yellow, none
}

struct Element: Identifiable {
    let id: String
    var touched: Bool
    var rowNumber: Int
    var columnNumber: Int
    var team: Team
}

let iPad = UIDevice.current.userInterfaceIdiom == .pad

