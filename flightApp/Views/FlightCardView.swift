//
//  FlightCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI
class CurveBoxVM : ObservableObject{
	@Published var image:UIImage = UIImage(imageLiteralResourceName: "companyBG")
	
	init(url:String) {
		loadImage(url: url)
	}
	init(){
		
	}
	func loadImage(url:String){
		guard let Url  = URL(string: url) else {return}
		print("loading with \(url)")
		URLSession.shared.dataTask(with: Url, completionHandler: {
			data,response,error in
			guard let data = data else {return}
			if error == nil {
				DispatchQueue.main.async {
					
					self.image = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "companyBG")
				}
					

			}
			}).resume()
	}
}
struct CurveBox : View {
	@ObservedObject var vm = CurveBoxVM();
	init(flight:FlightModel ) {
		self.flight = flight
		self.vm.loadImage(url:flight.companyLogoLink )
	}
	var flight:FlightModel
	
	
	var body: some View {
		VStack{
			Image("flightCurve").padding(.bottom, -30)
			HStack(alignment: .bottom){
				
				Text(flight.startAirport).font(.system(size: 22)).fontWeight(.bold).foregroundColor(.baseBlack).padding(.bottom, 10)
				Spacer()
				VStack{
					Image(uiImage: self.vm.image).cornerRadius(16).frame(width: 32, height: 32, alignment: .center)
					Text(flight.companyName).font(.system(size: 17)).foregroundColor(.cityGray)
				}
				Spacer()
				Text(flight.endAirport).font(.system(size: 22)).fontWeight(.bold).foregroundColor(.baseBlack).padding(.bottom, 10)
			}
		}
	}
	
	
}

struct FlightCardView :View {
	
	var flight: FlightModel
	var takeOffTime: DateComponents { return Calendar.current.dateComponents(in: TimeZone.current, from:self.flight.takeoffTime ?? Date() )  }
	var landingTime: DateComponents { return Calendar.current.dateComponents(in: TimeZone.current, from:self.flight.landingTime ?? Date() )  }
	
	var takeOffDate:String {
		let df = DateFormatter()
		df.dateFormat = "d MMM YYYY, E"
		return df.string(from: self.flight.takeoffTime ?? Date())
	}
	var landingDate:String {
		let df = DateFormatter()
		df.dateFormat = "d MMM YYYY, E"
		return df.string(from: self.flight.takeoffTime ?? Date())
	}
	
    var body: some View {
		GeometryReader{ proxy in
			ZStack(alignment: .topLeading){
				LinearGradient(gradient: .cardBG ,startPoint: .top, endPoint: .bottom).cornerRadius(20)
				
				VStack{
					HStack{
						Text("\(self.flight.cityStart) \n\(self.flight.cityEnd)")
							.font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
						Spacer()
					}//.padding(.bottom,-30)
					
					Spacer()//.frame( maxHeight: 37)
					
					VStack{
						HStack(alignment: .firstTextBaseline){
							Text("Время вылета").font(.headline).fontWeight(.regular).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("\(self.takeOffTime.hour!):\(self.takeOffTime.minute!)").font(.title).fontWeight(.heavy).foregroundColor(.baseWhite)
						}
						HStack(alignment: .firstTextBaseline){
							Text("Дата").font(.subheadline).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("\(self.takeOffDate)").font(.subheadline).foregroundColor(.cityGray)
						}.padding(.top, 5)
					
					
						HStack(alignment: .firstTextBaseline){
							Text("Время прилета").font(.headline).fontWeight(.regular).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("\(self.landingTime.hour!):\(self.landingTime.minute!)").font(.title).fontWeight(.heavy).foregroundColor(.baseWhite)
						}
						HStack(alignment: .firstTextBaseline){
							Text("Дата").font(.subheadline).foregroundColor(.baseBlack)
							Spacer()
							self.dots()
							Spacer()
							Text("\(self.landingDate)").font(.subheadline).foregroundColor(.cityGray)
						}.padding(.top,5)
					}
					self.hrSpacer
					
					CurveBox(flight: self.flight).opacity((proxy.size.height > 650) ? 1 :0)
					 .frame( maxHeight:(proxy.size.height > 650) ? .infinity :0)
						
					   
					if(proxy.size.height > 650) {
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
			FlightCardView(flight: FlightModel(cityStart: "Санкт-Петербург", cityEnd: "Москва", takeoffTime: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", ticketLink: ""))
		}.frame(height:674)
        
    }
}
