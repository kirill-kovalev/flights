//
//  FlightCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI


struct FlightCardView :View {
    @Binding var height:CGFloat;
    var fullSize:Bool {
        return self.height > 550
    }
    var body: some View {
        
        ZStack(alignment: .topLeading){
            LinearGradient(gradient:
            Gradient(colors: [Color(UIColor(red: 184/256, green: 236/256, blue: 255/256,alpha: 1)),
                              Color(UIColor(red: 162/256, green:224/256, blue: 247/256,alpha: 1))]
            ),startPoint: .top, endPoint: .bottom).cornerRadius(20)
            
            VStack{
                HStack{
                    Text("Москва \nГрозный").font(.system(size: 34)).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
                    Spacer()
                }.padding(.bottom,-30)
                Spacer().frame( maxHeight: 37)
                VStack{
                    HStack(alignment: .firstTextBaseline){
                        Text("Время вылета").font(.system(size: 20)).foregroundColor(.baseBlack)
                        Spacer()
                        dots
                        Spacer()
                        Text("01:00").font(.system(size: 28)).fontWeight(.heavy).foregroundColor(.baseWhite)
                    }
                    HStack(alignment: .firstTextBaseline){
                        Text("Дата").font(.system(size: 16)).foregroundColor(.baseBlack)
                        Spacer()
                        dots
                        Spacer()
                        Text("01 Сентября 2000, пт").font(.system(size: 17)).foregroundColor(.cityGray)
                    }.padding(.top, 5)
                }
                VStack{
                    HStack(alignment: .firstTextBaseline){
                        Text("Время прилета").font(.system(size: 20)).foregroundColor(.baseBlack)
                        Spacer()
                        dots
                        Spacer()
                        Text("01:00").font(.system(size: 28)).fontWeight(.heavy).foregroundColor(.baseWhite)
                    }
                    HStack(alignment: .firstTextBaseline){
                        Text("Дата").font(.system(size: 18)).foregroundColor(.baseBlack)
                        Spacer()
                        dots
                        Spacer()
                        Text("01 Сентября 2000, пт").font(.system(size: 17)).foregroundColor(.cityGray)
                    }.padding(.top,5)
                }
                hrSpacer
                VStack{
                    Image("flightCurve").padding(.bottom, -30)
                    HStack(alignment: .bottom){
                        
                           Text("LED").font(.system(size: 22)).fontWeight(.bold).foregroundColor(.baseBlack).padding(.bottom, 10)
                           Spacer()
                           VStack{
                               Image("companyBG").background(Color(.brown)).cornerRadius(16).frame(width: 32, height: 32, alignment: .center)
                               Text("Company name").font(.system(size: 17)).foregroundColor(.cityGray)
                           }
                           Spacer()
                           Text("LED").font(.system(size: 22)).fontWeight(.bold).foregroundColor(.baseBlack).padding(.bottom, 10)
                    }
                }.opacity(self.fullSize ? 1 :0).frame( maxHeight:self.fullSize ? .infinity :0)
                    
                   
                if(self.fullSize) {
                    hrSpacer
                }

                Button(action: {}){
                    Text("Купить билет").font(.system(size: 28)).fontWeight(.bold).foregroundColor(.baseWhite).padding(23)
                }.background(Rectangle().foregroundColor(.accentSecondLevel), alignment: .center)
                .cornerRadius(10)
                
                Spacer().frame(idealHeight: 31, maxHeight:31)
                Text("5/6").font(.system(size: 12)).foregroundColor(.baseWhite)

            }.padding(EdgeInsets(top: 25, leading: 21, bottom: 18, trailing: 21))
        }.padding(17)
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
            .frame(width: (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!)//, height: self.height )
        
    };
    
    var dots : some View{
        HStack{
            Circle().foregroundColor(.accentFirstLevel).scaledToFit().frame(width: 3, height: 3)
            Circle().foregroundColor(.accentFirstLevel).scaledToFit().frame(width: 3, height: 3)
            Circle().foregroundColor(.accentFirstLevel).scaledToFit().frame(width: 3, height: 3)
        }.frame(width: 21, height: 3)
    }
    
    var hrSpacer: some View{
        VStack{
            Spacer().frame(minHeight: 26,idealHeight: 26)
            HStack{ Spacer();Rectangle().foregroundColor(.accentFirstLevel).frame(width: 208, height: 1, alignment: .center);Spacer()}
            Spacer().frame(minHeight: 26,idealHeight: 26)
        }
    }
}


struct FlightCardView_Previews: PreviewProvider {
    var fullsize = true
    static var previews: some View {
        
        VStack{
            FlightCardView(height: .constant(570) )
        }
        
    }
}
