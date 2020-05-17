//
//  TripRowView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TripRowView: View {
    
    @ObservedObject var vm:AppVM;
    var tripInfo:TripModel
    
    @State var offset:CGFloat = 0;
    @State var index:Int = 0;
	@State var isFavourite = false;
	@State var gestureActive:Bool = true;
	
    init(vm:AppVM,tripInfo:TripModel) {
        self.vm = vm
        self.tripInfo = tripInfo

        if self.vm.favouriteList.contains(self.tripInfo) {
            self._isFavourite = State<Bool>(initialValue: true)
        }
        
    }
	
	

        

	var body: some View {
		ZStack{
			PagedView(.horizontal, maxIndex: tripInfo.fligts.count , index: self.$index, contentOffset: self.$offset,action:{ ended in
			if ended {
				self.gestureActive = true
			} else {
				
				if self.offset > 170 , self.gestureActive {
					withAnimation{
						self.isFavourite.toggle()
                        if self.isFavourite {
                            self.vm.favouriteList.add(self.tripInfo)
                        }else{
                            print("___________________________________________________\nfavourites (\(self.vm.favouriteList.triplist.count)):\n")
                            print(self.vm.favouriteList.triplist)
                            
                            let _ = self.vm.favouriteList.remove(self.tripInfo.localID)
                        }
					}
					
					self.gestureActive = false
				}
			}
		}){
				favouriteCardView(isSet: self.$isFavourite)
				InfoCardView(cities: self.tripInfo.cityList,days:self.tripInfo.days,price:self.tripInfo.price,bg: self.isFavourite ? .favouriteBG: .cardBG)
            
				ForEach( self.tripInfo.fligts , id:\.self ){flight in
                    FlightCardView(flight:flight, bg: self.isFavourite ? .favouriteBG: .cardBG).frame(width: UIApplication.screenWidth)
				}
            
			}.frame(width: UIApplication.screenWidth,height: calculateHeight(offset: self.offset))
		}



	}

	private func calculateHeight(offset:CGFloat) -> CGFloat {
		
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
        TripRowView( vm: AppVM(), tripInfo: TripModel(days: 5, cityList: ["Москва","Грозный","Махачкала","Магас","Нальчик"], fligts: [
            FlightModel(cityStart: "Санкт-Петербург", cityEnd: "Москва", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
            FlightModel(cityStart: "Москва", cityEnd: "Грозный", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
            FlightModel(cityStart: "Грозный", cityEnd: "Махачкала", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
            FlightModel(cityStart: "Махачкала", cityEnd: "Магас", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
            FlightModel(cityStart: "Магас", cityEnd: "Нальчик", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""),
        ]))
    }
}
