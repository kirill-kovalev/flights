//
//  InfoCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct InfoCardView: View {
    var cities:[CityList] = [] ;
	var days:Int
	var price:Int
    var bg:Gradient;
	
	
    var colCount:Int {return (cities.count - 1 )/7 };
    var cityText:String{
        let words = ["город","города","городов"]
        var n = cities.count % 100;
        
        if (n >= 5 && n <= 20) {
          return words[2];
        }
        n = n % 10;
        if (n == 1) {
          return  words[0];
        }
        if (n >= 2 && n <= 4) {
          return  words[1];
        }
        return  words[2];
    }
    var dayText:String{
        let words = ["день","дня","дней"]
        var n = days;
        
        if (n >= 5 && n <= 20) {
          return words[2];
        }
        n = n % 10;
        if (n == 1) {
          return  words[0];
        }
        if (n >= 2 && n <= 4) {
          return  words[1];
        }
        return  words[2];
    }
    @Binding var index:Int;
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            LinearGradient(gradient: bg,startPoint: .top, endPoint: .bottom).cornerRadius(20)
                
            VStack(alignment: .leading){
				Text("\(cities.count) \(cityText)\nза \(days) \(dayText)").font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
				Text("\(price) ₽").font(.system(size: 46)).fontWeight(.heavy).foregroundColor(.baseWhite).padding(.top,15.0)
				Rectangle().frame(height: 1).foregroundColor(.accentFirstLevel).padding(.top,-16).padding(.bottom,-16)

				HStack(alignment:.top,spacing: 20){
                    ForEach( (0...self.colCount) ,id: \.self){ i in
                        VStack(alignment: .leading){
                            ForEach(  ((i*7) ... ( self.cities.count - 1 ))  ,id: \.self){ city in
                                VStack{ if(city < ((i+1)*7)){
                                    Text("\(self.cities[city].cityName)").font(.system(size: 18)).fontWeight(.semibold).foregroundColor(.kirillGray).padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                                }}
                            }
                        }
                    }
                }
                
                
                
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action:{
                        withAnimation{
                            self.index += self.cities.count + 1
                        }
                        
                    }){
                        Image(systemName: "chevron.right.circle").resizable().frame(width: 50, height: 50)
                    }
                }
            }.padding(EdgeInsets(top: 30, leading: 25, bottom: 18, trailing: 25))
            
        }.padding(17)
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
		.frame(width: UIApplication.screenWidth , height:470)
        
    }
}
struct InfoCardView_Previews: PreviewProvider {
    static let cities = ["Москва","Грозный","Махачкала","Магас","Нальчик","Элиста","Геленджик","Санкт-Петербург","2","2"].map { name in
        CityList(partOfTheWorld: "EU", avgTemperature: 0, cityName: name)
    }
    static var previews: some View {
        InfoCardView(cities: cities ,days: 1,price: 1, bg: .cardBG, index:   .constant(0) )
    }
}
