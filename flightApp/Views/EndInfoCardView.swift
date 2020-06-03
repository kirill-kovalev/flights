//
//  EndInfoCardView.swift
//  flightApp
//
//  Created by Кирилл on 03.06.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct EndInfoCardView: View {
    var cities:[CityList] = [] ;
    var days:Int
    var price:Int
    var bg:Gradient;
    var link:String;
    @State var showSafari = false
    
    var body: some View {
        
            ZStack(alignment: .topLeading){
                LinearGradient(gradient: self.bg ,startPoint: .top, endPoint: .bottom).cornerRadius(20)
                
                VStack{
 
                    VStack{
                        Text("\(cities.count) городов\nза \(days) дней").font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
                        Text("\(price) ₽").font(.system(size: 46)).fontWeight(.heavy).foregroundColor(.baseWhite).padding(.top,15.0)
                    }
                    
                        Spacer()
                        Rectangle().frame(height: 1).foregroundColor(.accentFirstLevel)
                        Spacer()
                    

                    HStack(alignment:.top,spacing: 20){
                        
                            VStack(alignment: .leading){
                                ForEach(  0..<self.cities.count  ,id: \.self){ city in
                                    
                                        Text("\(self.cities[city].cityName)").font(.system(size: 18)).fontWeight(.semibold).foregroundColor(.kirillGray).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                                    
                                }
                            }
                            Spacer()
                        
                    }
                    Spacer()
                    Rectangle().frame(height: 1).foregroundColor(.accentFirstLevel).padding(.top,-16).padding(.bottom,-16)
                    Spacer()
                    Button(action: {
                       
                    }){
                        Text("Купить билеты на все рейсы").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).multilineTextAlignment(.center).padding(23)
                    }.background(Rectangle().foregroundColor(.accentSecondLevel), alignment: .center)
                    .cornerRadius(15)
                    Spacer()
                    .sheet(isPresented: self.$showSafari){
                        SafariView(url: URL(string: self.link) ?? (URL(string: "aviasales.ru")!))
                    }
                    

                }.padding(EdgeInsets(top: 25, leading: 21, bottom: 18, trailing: 21))
                .frame(idealHeight: 0)
            }.padding(17)
            .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
        
    }
    
}

struct EndInfoCardView_Previews: PreviewProvider {
    static let cities = ["Москва","Грозный","Махачкала","Магас","Нальчик","Элиста","Геленджик","Санкт-Петербург","2","2"].map { name in
           CityList(partOfTheWorld: "EU", avgTemperature: 0, cityName: name)
       }
    static var previews: some View {
        EndInfoCardView(cities: cities ,days: 1,price: 1, bg: .cardBG,link: "yandex.ru")
    }
}
