//
//  ContentView.swift
//  heath app but mine
//
//  Created by Константин Государев on 11.06.2023.
//

import SwiftUI

struct o21 : View {
    var body : some View{
        Text("Привычки образуются благодаря механизмам, называемым \"привыканием или\" \"автоматизацией\". Когда мы выполняем определенное действие в течение какого-то времени с повторением, наше мозг создает новые нейронные связи и паттерны активности, связанные с этим действием. 21 день часто упоминается как приблизительный срок, необходимый для формирования привычки. Однако, этот период может варьироваться в зависимости от конкретной привычки и человеческой индивидуальности. Исследования, проведенные в области психологии и нейронауки, показывают, что формирование привычки связано с повторением определенного действия и его влиянием на нашу мозговую активность. Повторение помогает закрепить эту активность и создать более эффективные нейронные связи, что делает это действие более автоматическим и менее требующим сознательного усилия. Таким образом, 21 день является примерным сроком, за который многие люди могут создать новую привычку, но для некоторых это может потребовать большего времени или же в некоторых случаях новая привычка может сформироваться быстрее.").multilineTextAlignment(.leading).padding()
        Text("Нажимайте на зеленую кнопку каждый раз когда вы соблюли правила вашей привычки (не больше одного раза в день). Если пропустите день - нажимайте на красную, иначе привычка не образуется").multilineTextAlignment(.leading).padding()
    }
}
struct ocalc : View {
    var body : some View{
        Text("Выберите коэффициэнт вашей активности двигая ползунок из значений:").font(.headline).multilineTextAlignment(.leading).padding()
        Text("  1.2 — почти нет активности, сидячий образ жизни, человек не занимается спортом;\n   1,38 — слабая активность. Это сидячий образ жизни и немного спорта — до трех малоинтенсивных тренировок в неделю;\n   1,55 — средняя активность. Чтобы выбрать этот коэффициент, человек должен тренироваться три-четыре раза в неделю, тренировки должны быть интенсивными, но не тяжелыми;\n   1,73 — высокая активность. Это ежедневные занятия спортом или ежедневная работа, связанная с большим количеством перемещений и ручного труда, например — занятие сельским хозяйством;\n   1,9 — экстремальная активность. Это скорее для профессиональных спортсменов и людей, активно трудящихся: работа с тяжестями и т.д.").multilineTextAlignment(.leading).padding()
    }
}

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var privichka = ""
    @State private var day = UserDefaults.standard.integer(forKey: "Day")
    @State private var ura = false
    @State private var ves = ""
    @State private var rost = ""
    @State private var vozrast = ""
    @State private var o21sheet = false
    @State private var ocalcsheet = false
    @State private var pol = ["мужчина","женщина"]
    @State private var selectedpol = 0
    @State private var A = 1.2
    let marks: [Double] = [1.2, 1.375, 1.55, 1.73, 1.9]
    init() {
        // Загружаем сохраненное значение из UserDefaults при инициализации
        if let savedPrivichka = UserDefaults.standard.string(forKey: "Privichka") {
            self._privichka = State(initialValue: savedPrivichka)
        }
    }
    var colorii : Double{
        let vesD = Double(ves) ?? 0
        let rostD = Double(rost) ?? 0
        let vozrastD = Double(vozrast) ?? 0
        let itogom = (vesD*10 + 6.25*rostD - 5*vozrastD + 5)*A
        let itogow = (vesD*10 + 6.25*rostD - 5*vozrastD - 161)*A
        if (rostD == 0 && vesD == 0 && vozrastD == 0) {return 0}
        else if selectedpol == 0 {return itogom}
        else {return itogow}
    }
    
    
    var body: some View {
        
        TabView{
            VStack{
                Button (action: {
                    self.o21sheet = true
                }){Image(systemName: "info.circle").font(.title)}.offset(x: 150) .sheet(isPresented: $o21sheet){o21()}
                Text("Осталось всего дней: \(day)").padding(30).background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15) .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1)
                    ).font(.largeTitle).padding().offset(x: 0, y: 100)
                Spacer()
                Button(action: {
                    if self.day != 0{
                        self.day -= 1}
                    else {
                        self.ura = true
                    }
                    UserDefaults.standard.set(self.day, forKey: "Day")
                }) {
                    Text("Условия выполнены").foregroundStyle(Color(red: 0.0, green: 0.3, blue: 0.4)).padding().background(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5), Color.green]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15) .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.green, lineWidth: 2) // Цвет и толщина обводки
                        ).font(.title)}
                Button(action: {self.day = 21}) {
                    Text("Обнулить").foregroundStyle(Color(red: 0.0, green: 0.3, blue: 0.4)).font(.title).padding().background(LinearGradient(gradient: Gradient(colors: [Color.red, Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5)]), startPoint: .leading, endPoint: .trailing)) .cornerRadius(15) .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red, lineWidth: 2) // Цвет и толщина обводки
                    ).font(.title)}
                Spacer()
                TextField ("Какую вы хотите привычку?", text: $privichka ).padding().onChange(of: privichka) { newValue in
                    // Сохраняем значение в UserDefaults при изменении текста в TextField
                    UserDefaults.standard.set(newValue, forKey: "Privichka")}
                
            }
            .tabItem { Image(systemName: "bubbles.and.sparkles.fill")
                Text("Привычки")
            }
            VStack{
                NavigationView{
                    
                    Form {
                        
                        Picker(selection: $selectedpol, label: Text("Выберите пол")){ForEach(0..<pol.count){
                            Text (self.pol[$0])
                        }
                        }.pickerStyle(SegmentedPickerStyle()).navigationBarTitle(Text("Калькулятор КБЖУ"))
                        
                        TextField ("Ваш вес (кг)", text: $ves)
                        TextField ("Ваш рост (см)", text: $rost)
                        TextField ("Ваш возраст", text: $vozrast)
                        
                        Slider(value: $A, in: 1.2...1.9, step: 0.175) // Настройка Slider с шагом 25 и диапазоном от 0 до 100
                            .accentColor(.blue) // Цвет слайдера
                        
                        // Отображение пометок с определенными значениями
                        HStack {
                            ForEach(marks, id: \.self) { mark in
                                Text("\(Double(mark), specifier: "%.2f")")
                                    .padding(.horizontal, 9)
                                    .frame(height: 30)
                            }
                            
                        }
                        .padding()
                        
                        
                        Text("Ваша дневная норма белков: \(colorii*0.3, specifier: "%.2f")")
                        Text("Ваша дневная норма жиров: \(colorii*0.3, specifier: "%.2f")")
                        Text("Ваша дневная норма углеводов: \(colorii*0.4, specifier: "%.2f")")
                        Text("Итого калорий: \(colorii, specifier: "%.2f")").font(.largeTitle)
                        
                        
                    }
                    
                    
                }
                Button (action: {
                    self.ocalcsheet = true
                }){Image(systemName: "info.circle").font(.title)}.offset(x: 150, y: -678) .sheet(isPresented: $ocalcsheet){ocalc()}
            }
            
            .tabItem {
                Image(systemName: "fork.knife")
                Text("Питание")
            }
           
            
        }.alert(isPresented: $ura) {
            Alert(title: Text("Поздравляем!"), message: Text("У вас теперь есть привычка: \(privichka)"), dismissButton: .default(Text("OK")))
        }
        
        
    }
}




#Preview {
    ContentView()
}
