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

//        if self.vm.favouriteList.contains(self.tripInfo) {
//            self.isFavourite = State<Bool>(initialValue: true)
//        }
        
    }
	
	

        

	var body: some View {
		ZStack{
			PagedView(.horizontal, maxIndex: tripInfo.flights.count+1 , index: self.$index, contentOffset: self.$offset,action:{ ended in
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
                            self.vm.favouriteList.remove(self.tripInfo.localID)
							
							
							
                        }
					}
					
					self.gestureActive = false
				}
			}
		}){
				favouriteCardView(isSet: self.$isFavourite)
            InfoCardView(cities: self.tripInfo.cityList,days:self.tripInfo.days,price:Int(self.tripInfo.totalPrice),bg: self.isFavourite ? .favouriteBG: .cardBG, index: self.$index)
            
				ForEach( (0..<self.tripInfo.flights.count) , id:\.self ){id in
					FlightCardView(flight:self.tripInfo.flights[id], bg: self.isFavourite ? .favouriteBG: .cardBG, curCount: id+1,totalCount: self.tripInfo.flights.count)
					.frame(width: UIApplication.screenWidth)
				}
            EndInfoCardView(cities: self.tripInfo.cityList, days: self.tripInfo.days, price: Int(self.tripInfo.totalPrice), bg: self.isFavourite ? .favouriteBG: .cardBG, link: self.tripInfo.ticketLink).frame(width: UIApplication.screenWidth)
            
			}.frame(width: UIApplication.screenWidth,height: calculateHeight(offset: self.offset))
		}.onAppear(perform: {
			
				self.isFavourite = self.vm.favouriteList.contains(self.tripInfo)

		})



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
    static var tripmodel = TripModel(totalPrice:0, days: 5, ticketLink:"", cityList: InfoCardView_Previews.cities, flights: [
        FlightModel(startAirport: "LED", endAirport: "DMD", price: 1000, landingTime: 0, companyLogoLink: "", originCity: "Санкт-Петербур", destCity: "Москва", companyName: "S7", departureDate: Date(), visaType: .none, localID: nil, ticketLink: ""),
        FlightModel(startAirport: "LED", endAirport: "DMD", price: 1000, landingTime: 0, companyLogoLink: "", originCity: "Санкт-Петербур", destCity: "Москва", companyName: "S7", departureDate: Date(), visaType: .none, localID: nil, ticketLink: ""),
        FlightModel(startAirport: "LED", endAirport: "DMD", price: 1000, landingTime: 0, companyLogoLink: "", originCity: "Санкт-Петербур", destCity: "Москва", companyName: "S7", departureDate: Date(), visaType: .none, localID: nil, ticketLink: "")
    ],visa:false)
    
   
    
    static var previews: some View {
        TripRowView( vm: AppVM(), tripInfo: tripmodel)
    }
}
