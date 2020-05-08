//
//  TripRowView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TripRowView: View {
	@State var offset:CGFloat = 0
    @State var index:Int = 0
	@State var isFavourite = false;
	@State var gestureActive:Bool = true;
	
	var tripInfo:TripModel
	
	

        

	var body: some View {
		ZStack{
			//Rectangle().foregroundColor(.clear)
		PagedView(.horizontal, maxIndex: 20, index: self.$index, contentOffset: self.$offset,action:{ ended in
			if ended {
				self.gestureActive = true
			} else {
				
				if self.offset > 170 , self.gestureActive {
					withAnimation{
						self.isFavourite.toggle()
					}
					
					self.gestureActive = false
				}
			}
		}){
				favouriteCardView(isSet: self.$isFavourite)
				InfoCardView(cities: self.tripInfo.cityList,days:self.tripInfo.days,price:self.tripInfo.price)
				ForEach( self.tripInfo.fligts , id:\.self ){flight in
					
				FlightCardView(flight:flight).frame(width: UIApplication.screenWidth)
					
				}
			}.frame(width: UIApplication.screenWidth,height: calculateHeight(offset: self.offset))//,height: CGFloat()
			//Text("\(self.offset)\n\(self.isFavourite ? "true" : "false")")
		}



	}

	func calculateHeight(offset:CGFloat) -> CGFloat {
		
		if offset >= UIApplication.screenWidth {
			return  UIApplication.screenHeight
		}else{
			var coef = -1 * offset / UIApplication.screenWidth
			if coef > 1 {
				coef = 1
			}
			if coef < 0 {
				coef = 0
			}
			let height = (UIApplication.screenHeight - 468 ) * coef
			return height + 468;
		}
	}
}


struct TripRowView_Previews: PreviewProvider {

    static var previews: some View {
		TripRowView( tripInfo: TripModel(days: 5, cityList: ["Москва","Грозный","Махачкала","Магас","Нальчик"], fligts: [
			FlightModel(cityStart: "Санкт-Петербург", cityEnd: "Москва", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
			FlightModel(cityStart: "Москва", cityEnd: "Грозный", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
			FlightModel(cityStart: "Грозный", cityEnd: "Махачкала", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
			FlightModel(cityStart: "Махачкала", cityEnd: "Магас", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
			FlightModel(cityStart: "Магас", cityEnd: "Нальчик", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
		]))
    }
}
