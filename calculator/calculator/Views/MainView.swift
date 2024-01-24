//
//  MainView.swift
//  calculator
//
//  Created by Константин Государев on 01.12.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var value = "0"
    @State private var number: Double = 0.0
    @State private var currentOperation: Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .nothing1, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .nothing, .decimal, .equel]
    ]
    
    var body: some View {
        ZStack //на задний план
        {
            Color.black.ignoresSafeArea() //цвет фона
            VStack{
                Spacer()//сместить вниз
                HStack { //
                    Spacer() //занимает все место перед Text, без регуляции занимал бы место снизу
                    Text(value).foregroundColor(.white).font(.system(size: 90)).fontWeight(.bold)//настройки текста
                }
                ForEach(buttonsArray, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self, content: { item in
                            Button{
                                self.didTap(item: item)
                            } label: {
                                Text(item.rawValue).frame(width: 90, height: 90).background(item.buttonColor).foregroundStyle(item.buttonColorFont).font(.system(size: 40)).clipShape(.circle)}})
                    }
                }
                
            }
            .padding(.bottom)//небольшое расстояние снизу
            
        }
    }
    func didTap(item: Buttons) {
        switch item {
        case .plus:
            currentOperation = .addition
            number = Double(value) ?? 0
            value = "0"
        case .minus:
            currentOperation = .subtract
            number = Double(value) ?? 0
            value = "0"
        case .multiple:
            currentOperation = .multiply
            number = Double(value) ?? 0
            value = "0"
        case .divide:
            currentOperation = .divide
            number = Double(value) ?? 0
            value = "0"
        case .equel:
            if  let currentValue = Double(value){
                value = String(preformOperation(currentValue))
            }
        case .decimal:
            if !value.contains("."){
                value += "."
            }
        case .clear:
            value = "0"
        default:
            if value == "0" {
                value = item.rawValue
            }
            else {
                value += item.rawValue
            }
        }
    }
    // присваивание операциям операции
    func preformOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtract:
            return number - currentValue
        case .multiply:
            return number * currentValue
        case .divide:
            return number / currentValue
        case .none:
            return number
        default:
            return currentValue
        }
        
    }
    
    //убрать лишний ноль
    /*func formatResult(_ result: Double) -> String{
        return String(format: "%g", result) //в equel заменить string на format Result
    }*/
}


#Preview {
    MainView()
}

