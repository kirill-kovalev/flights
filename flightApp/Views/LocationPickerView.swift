//
//  LocationPickerView.swift
//  flightApp
//
//  Created by Кирилл on 16.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

class LPVM: ObservableObject {
    @Published  var airportList:[String] = ["Пулково","Шереметьево","Аэропорт имени Егора Летова в Омске"]
}

struct LocationPickerView: View {
    
    @ObservedObject var vm:LPVM;
    
    @State var airport = ""
    @State var active = true
    
    func levDis(_ w1: String, _ w2: String) -> Int {
        let empty = [Int](repeating:0, count: w2.count)
        var last = [Int](0...w2.count)

        for (i, char1) in w1.enumerated() {
            var cur = [i + 1] + empty
            for (j, char2) in w2.enumerated() {
                cur[j + 1] = char1 == char2 ? last[j] : min(last[j], last[j + 1], cur[j]) + 1
            }
            last = cur
        }
        return last.last!
    }
    
    var body: some View {
        VStack{
            HStack{
                TextField("Название аэропорта", text: self.$airport,onEditingChanged: {  _ in
                    var a = self.vm.airportList
                    a.sort(by: {
                        let text = self.airport.lowercased()
                       
                        return self.levDis(text, $0.lowercased()) < self.levDis(text, $1.lowercased())
                        
                    })
                    print(a)
                    self.vm.airportList = a
                    
                }).font(.title)
                Button(action: {}){
                    Image(systemName: "location.fill").padding(5).background(Color.white)
                }
            }.padding()
            Divider()
            List(self.vm.airportList,id: \.self){ text in
                //Button(action: {}){
                    
                    Toggle(isOn:self.$active) {
                        Text(text)
                    }
                //}
                
                
            }
            Button(action: {}){
                Spacer()
                Text("OK").foregroundColor(.baseWhite).font(.title)
                Spacer()
            }.padding().background(Color.blue).cornerRadius(10).padding()
        }.foregroundColor(.baseBlack)
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView( vm:LPVM())
    }
}
