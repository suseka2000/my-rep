//
//  Model.swift
//  calculator
//
//  Created by Константин Государев on 01.12.2023.
//

import SwiftUI

enum Operation{
    case addition, subtract, multiply, divide, none
}


enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case minus = "-"
    case multiple = "x"
    case divide = "/"
    case equel = "="
    case decimal = "."
    case clear = "AC"
    case nothing = " "
    case nothing1 = "  "
    
    var  buttonColor: Color {
        
        switch self {
        case .clear,.nothing1: return Color(red: 0.7, green: 0.7, blue: 0.7)
        case .divide,.minus,.multiple,.equel,.plus: return Color.green
        default : return Color(red: 0.4, green: 0.4, blue: 0.4)
        }
    }
        var  buttonColorFont: Color {
            
            switch self {
            case .clear,.nothing: return Color.black
            default : return Color.white
            }
            
            
        }
        
    }
    

