//
//  LocationPickerView.swift
//  flightApp
//
//  Created by Кирилл on 16.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct LocationPickerView: View {
    @State var airport = ""
    var airportList:[String] = ["Пулково","Шереметьево","Аэропорт имени Егора Летова в Омске"]
    var body: some View {
        VStack{
            HStack{
                TextField("Название аэропорта", text: self.$airport).font(.title).keyboardType(.alphabet)
                Button(action: {}){
                    Image(systemName: "location.fill").padding(5).background(Color.white)
                }
            }.padding()
            Divider()
            List(self.airportList,id: \.self){ text in
                Text(text)
            }
        }.foregroundColor(.baseBlack)
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView()
    }
}
