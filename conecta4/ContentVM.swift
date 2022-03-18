//
//  ContentVM.swift
//  conecta4
//
//  Created by Eduardo Martin Lorenzo on 13/3/22.
//

import SwiftUI

final class ContentVM: ObservableObject {
    @Published var finishedPlay = false
    @Published var elements: [Element] = []
    @Published var rows = 7
    @Published var columns = 6
    @Published var team: Team = .none
    @Published var redVictories = 0
    @Published var yellowVictories = 0
    
    @Published var redPercentualVictories = 0.0
    @Published var yellowPercentualVictories = 0.0
    
    @Published var showAlert = false
    
    // Sliding Sheet
    @Published var scroll = CGFloat.zero
    
    init() {
        startGame()
    }
    
    func startGame() {
        finishedPlay = false
        elements = []        
        
        if (redVictories + yellowVictories) % 2 == 0 {
            team = .red
        } else {
            team = .yellow
        }
        
        for row in (1...rows).reversed() {
            for column in 1...columns {
                elements.append(Element(id: "\(row)-\(column)", touched: false, rowNumber: row, columnNumber: column, team: .none))
            }
        }
    }
    
    func initPoints() {
        redVictories = 0
        yellowVictories = 0
        redPercentualVictories = 0.0
        yellowPercentualVictories = 0.0
        
        startGame()
    }
    
    func circleTouched(element: Element) {
        if !finishedPlay {
            let column = element.columnNumber
            
            for e in elements.sorted(by: {$0.id < $1.id}).filter({ $0.columnNumber == column}) {
                if !e.touched {
                    if let index = elements.firstIndex(where: {$0.id == e.id}) {
                        elements[index].touched = true
                        elements[index].team = team
                        break
                    }
                }
            }
            
            if checkWinner(team: team) {
                endGame()
            } else {
                if team == .red {
                    team = .yellow
                } else {
                    team = .red
                }
            }
            
            
        }
    }
    
    func checkWinner(team: Team) -> Bool {
        let elements = elements.filter({$0.team == team})
        if elements.count < 4 {
            return false
        } else {
            let sortedElements = elements.sorted(by: { $0.id < $1.id })
            return (checkHorizontal(elements: sortedElements) || checkVertical(elements: sortedElements) || checkDiagonalRight(elements: sortedElements) || checkDiagonalLeft(elements: elements))
        }
    }
    
    func checkHorizontal(elements: [Element]) -> Bool {
        var auxiliar: Element?
        var count = 0
        
        for e in elements where count < 3 {
            if let aux = auxiliar {
                if ((aux.rowNumber == e.rowNumber) && (aux.columnNumber + 1 == e.columnNumber)) {
                    count += 1
                } else {
                    count = 0
                }
            }
            auxiliar = e
        }
        
        
        if count < 3 {
            return false
        } else {
            return true
        }
        
    }
    
    func checkVertical(elements: [Element]) -> Bool {
        var auxiliar: Element?
        var count = 0
        
        for e in elements where count < 3 {
            if let aux = auxiliar {
                if ((aux.columnNumber == e.columnNumber) && (aux.rowNumber + 1 == e.rowNumber)) {
                    count += 1
                } else {
                    count = 0
                }
            }
            auxiliar = e
        }
        
        
        if count < 3 {
            return false
        } else {
            return true
        }
    }
    
    func checkDiagonalRight(elements: [Element]) -> Bool {
        var count = 0
        var aux = elements[0]
        let elementsAux = elements
        
        for e1 in elements where count < 3 {
            
            elementsAux.forEach { e2 in
                if (aux.rowNumber != e2.rowNumber && aux.columnNumber < e2.columnNumber) {
                    if ((aux.columnNumber + 1 == e2.columnNumber) && (aux.rowNumber + 1 == e2.rowNumber)) {
                        count += 1
                        aux = e2
                    } else {
                        count = 0
                    }
                }
            }
            
            if count >= 3 {
                return true
            }
            
            aux = e1
            count = 0
        }
        
        return false
        
    }
    
    func checkDiagonalLeft(elements: [Element]) -> Bool {
        var count = 0
        var aux = elements[0]
        let elementsAux = elements
        
        for e1 in elements where count < 3 {
            
            elementsAux.forEach { e2 in
                if (aux.rowNumber != e2.rowNumber && aux.columnNumber < e2.columnNumber) {
                    if ((aux.columnNumber + 1 == e2.columnNumber) && (aux.rowNumber - 1 == e2.rowNumber)) {
                        count += 1
                        aux = e2
                    } else {
                        count = 0
                    }
                }
            }
            
            if count >= 3 {
                return true
            }
            
            aux = e1
            count = 0
        }
        
        return false
    }
    
    func endGame() {
        if team == .red {
            redVictories += 1
        } else {
            yellowVictories += 1
        }
        
        yellowPercentualVictories = (Double(yellowVictories) / (Double(redVictories) + Double(yellowVictories))) * 100
        redPercentualVictories = (Double(redVictories) / (Double(redVictories) + Double(yellowVictories))) * 100
        showAlert = true
        finishedPlay = true
    }
}
