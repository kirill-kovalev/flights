//
//  InfoCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct InfoCardView: View {
    @Binding var cities:[String] ;
    var colCount:Int {return (cities.count - 1 )/7 };
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            LinearGradient(gradient: .cardBG,startPoint: .top, endPoint: .bottom).cornerRadius(20)
                
            VStack(alignment: .leading){
                Text("10 городов\nза 10 дней").font(.system(size: 34)).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
				Text("170000 ₽").font(.system(size: 46)).fontWeight(.heavy).foregroundColor(.baseWhite).padding(.top,20)
				Rectangle().frame(height: 1).foregroundColor(.accentFirstLevel).padding(.top,-16).padding(.bottom,-16)

                HStack(spacing: 20){
                    ForEach( (0...self.colCount) ,id: \.self){ i in
                        VStack(alignment: .leading){
                            ForEach(  ((i*7) ... ( self.cities.count - 1 ))  ,id: \.self){ city in
                                VStack{ if(city < ((i+1)*7)){
                                        Text("\(self.cities[city])").font(.system(size: 20)).fontWeight(.bold).foregroundColor(.kirillGray)
                                }}
                            }
                        }
                    }
                }
                
                
                
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "chevron.right.circle").resizable().frame(width: 50, height: 50)
                    }
                }
            }.padding(EdgeInsets(top: 30, leading: 25, bottom: 18, trailing: 25))
            
        }.padding(17)
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
        .frame(width: (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)! , height:470)
        
    }
}
struct InfoCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        InfoCardView(cities: .constant(["Москва","Грозный","Махачкала","Магас","Нальчик","Элиста","Геленджик","2","2","2","2","2","2","2"]))
    }
}
