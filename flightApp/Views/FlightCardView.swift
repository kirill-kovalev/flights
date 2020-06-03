//
//  FlightCardView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI
import SafariServices

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
                    Image(uiImage: self.vm.image).resizable().scaledToFit().frame(minWidth: 32, maxHeight: 32, alignment: .center).cornerRadius(16)
					Text(flight.companyName).font(.system(size: 17)).foregroundColor(.cityGray)
				}
				Spacer()
				Text(flight.endAirport).font(.system(size: 22)).fontWeight(.bold).foregroundColor(.baseBlack).padding(.bottom, 10)
			}
        }
//        .onAppear {
//            self.vm.loadImage(url:self.flight.companyLogoLink )
//        }
	}
	
	
}

struct FlightCardView :View {
	
	var flight: FlightModel
    var bg:Gradient;
	
	var curCount:Int;
	var totalCount:Int;
	
    @State var showSafari = false
	
	var takeOffDate:String {
		let df = DateFormatter()
		df.dateFormat = "d MMM YYYY, E"
		return df.string(from: self.flight.departureDate ?? Date())
	}
	var landingDate:String {
		let df = DateFormatter()
		df.dateFormat = "d MMM YYYY, E"
		return df.string(from: self.flight.departureDate ?? Date())
	}
	
    var body: some View {
		GeometryReader{ proxy in
			ZStack(alignment: .topLeading){
                LinearGradient(gradient: self.bg ,startPoint: .top, endPoint: .bottom).cornerRadius(20)
				
				VStack{
					VStack{
						HStack{
							Text("\(self.flight.originCity)")
								.font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).lineLimit(2).frame(minHeight: 82)
							Spacer()
						}
						HStack{
						Text("\(self.flight.destCity)")
						.font(.largeTitle).fontWeight(.heavy).foregroundColor(.baseBlack).frame(minHeight: 82)
						Spacer()
						}
						
					}
					
					VStack{
						self.hrSpacer()
						HStack{
							Text("\(Int(self.flight.price)) ₽").font(.system(size: 44)).fontWeight(.heavy).foregroundColor(.baseWhite)
						}
						self.hrSpacer()
					}
					
                    if(proxy.size.height > 700) {
                        VStack{
                            HStack{
                                Text("Дата вылета").font(.headline).foregroundColor(.white).shadow(radius: 10)
                                Spacer()
                                self.dots()
                                Spacer()
                                Text("\(self.takeOffDate)").font(.body).foregroundColor(.cityGray)
                            }
                            HStack{
                                Text("Виза").font(.headline).foregroundColor(.white).shadow(radius: 10)
                                Spacer()
                                self.dots()
                                Spacer()
                                Text("\(self.flight.visaType?.rawValue ?? "Не нужна") ").font(.body).foregroundColor(.cityGray)
                            }
                        }
                        self.hrSpacer()
				
					
					
					
					CurveBox(flight: self.flight).opacity((proxy.size.height > 650) ? 1 :0)
					 .frame( maxHeight:(proxy.size.height > 650) ? .infinity :0)
						
					   
					
						self.hrSpacer()
					}

					Button(action: {
                        self.showSafari.toggle()
                        
                    }){
						Text("Купить билет").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).padding(23)
					}.background(Rectangle().foregroundColor(.accentSecondLevel), alignment: .center)
					.cornerRadius(10)
                        .sheet(isPresented: self.$showSafari){
                            SafariView(url: URL(string: self.flight.ticketLink ?? "") ?? (URL(string: "http://aviasales.ru")!))
                    }
					
					Spacer().frame(idealHeight: 31, maxHeight:31)
					Text("\(self.curCount)/\(self.totalCount)").font(.system(size: 12)).foregroundColor(.baseWhite)

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
    
    func hrSpacer() -> some View{
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
            FlightCardView(flight: FlightModel(startAirport: "LED", endAirport: "DMD", price: 1000, landingTime: 0, companyLogoLink: "", originCity: "Санкт-Петербур", destCity: "Москва", companyName: "S7", departureDate: Date(), visaType: .none, localID: nil, ticketLink: nil), bg: .cardBG,curCount: 0,totalCount: 1)
//            FlightCardView(flight: FlightModel(originCity: "Санкт-Петербург", destCity: "Москва", departureDate: Date(), landingTime: Date(), startAirport: "LED", endAirport: "DMD", companyLogoLink: "", companyName: "S7 airlines", visaType: ""), bg: .favouriteBG,curCount: 0,totalCount: 1)
		}
        
    }
}
