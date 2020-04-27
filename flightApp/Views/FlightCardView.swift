//
//  FlightCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI


struct FlightCardView :View {
    var body: some View {
		GeometryReader{ proxy in
			ZStack(alignment: .topLeading){
				LinearGradient(gradient: .cardBG ,startPoint: .top, endPoint: .bottom).cornerRadius(20)
				
				VStack{
					HStack{
						Text("Москва \nГрозный").font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
						Spacer()
					}.padding(.bottom,-30)
					Spacer().frame( maxHeight: 37)
					VStack{
						HStack(alignment: .firstTextBaseline){
							Text("Время вылета").font(.headline).fontWeight(.regular).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("01:00").font(.title).fontWeight(.heavy).foregroundColor(.baseWhite)
						}
						HStack(alignment: .firstTextBaseline){
							Text("Дата").font(.subheadline).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("01 Сентября 2000, пт").font(.subheadline).foregroundColor(.cityGray)
						}.padding(.top, 5)
					}
					VStack{
						HStack(alignment: .firstTextBaseline){
							Text("Время прилета").font(.headline).fontWeight(.regular).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("01:00").font(.title).fontWeight(.heavy).foregroundColor(.baseWhite)
						}
						HStack(alignment: .firstTextBaseline){
							Text("Дата").font(.subheadline).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("01 Сентября 2000, пт").font(.subheadline).foregroundColor(.cityGray)
						}.padding(.top,5)
					}
					self.hrSpacer
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
					}.opacity((proxy.size.height > 600) ? 1 :0)
					 .frame( maxHeight:(proxy.size.height > 600) ? .infinity :0)
						
					   
					if(proxy.size.height > 600) {
						self.hrSpacer
					}

					Button(action: {}){
						Text("Купить билет").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).padding(23)
					}.background(Rectangle().foregroundColor(.accentSecondLevel), alignment: .center)
					.cornerRadius(10)
					
					Spacer().frame(idealHeight: 31, maxHeight:31)
					Text("5/6").font(.system(size: 12)).foregroundColor(.baseWhite)

				}.padding(EdgeInsets(top: 25, leading: 21, bottom: 18, trailing: 21))
				.frame(idealHeight: 0)
			}.padding(17)
			.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
			//.frame(idealHeight: .infinity,maxHeight: self.height )
		}.frame(maxWidth: .infinity, maxHeight: .infinity)
    };
    
    func dots() -> some View{
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
            FlightCardView()
		}
        
    }
}
