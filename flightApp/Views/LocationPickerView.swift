//
//  LocationPickerView.swift
//  flightApp
//
//  Created by Кирилл on 16.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI
import CoreLocation

class LPVM: NSObject, ObservableObject, CLLocationManagerDelegate{
	var selected :String = "LED"
	let locationManager = CLLocationManager()
	
	
	override init(){
		super.init()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
			locationManager.requestLocation()
		}else{
			self.didFail = true
		}
		
		
		
		if let path = Bundle.main.path(forResource: "airports", ofType: "json") {
			print(path)
			do{
				let d = try  Data(contentsOf: URL(fileURLWithPath: path))
				let fileAirportList = try JSONDecoder().decode([Airport].self, from: d)
                //self.airportList = Array(fileAirportList[0..<20])
                self.airportList = fileAirportList
			}catch{
				print(error)
			}
		}else{
			print("no file")
		}
		
		
		
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.curCoord = locations[0]
		print(locations)
	}
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		self.didFail = true
		print(error)
	}

	
	func location() {
        locationManager.requestLocation()
		var tmp = self.airportList
       
		let defaultCoordinates = Coord(lon: 0, lat: 0)
		
		DispatchQueue.global(qos: .background).async {
			print("starting")
			tmp.sort(by: {self.countDis(coordinates: $0.coordinates ?? defaultCoordinates) < self.countDis(coordinates: $1.coordinates ?? defaultCoordinates)})
			DispatchQueue.main.async {
				self.airportList = []
			}
			
			DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)){
				print("sorted")
                 self.airportList = []
                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 50)){
                    self.airportList = tmp
                }
                
			}
		}
		
		
	}
	
    func searchText(_ str:String){
	

			var a = self.airportList;
            
			DispatchQueue.global(qos: .background).async {
				a.sort(by: {
					let text = str.lowercased()
					
					return self.levDis(text, $0.name.lowercased()) < self.levDis(text, $1.name.lowercased())
					
				})
				DispatchQueue.main.async {
                    self.airportList = []
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)){
                        self.airportList = a
                    }
					
				}
			}
			
		
		
		
	}
	
	private func levDis(_ w1: String, _ w2: String) -> Int {
		let empty = [Int](repeating:0, count: w2.count)
		var last = [Int](0...w2.count)
		
		for (i, char1) in w1.enumerated() {
			var cur = [i + 1] + empty
			for (j, char2) in w2.enumerated() {
				cur[j + 1] = char1 == char2 ? last[j] : min(last[j], last[j + 1], cur[j]) + 1
			}
			last = cur
		}
		return last.last!
	}
	
	func countDis(coordinates:Coord)->Int{
		let loc = CLLocation(latitude: CLLocationDegrees(exactly: coordinates.lat)!, longitude: CLLocationDegrees(exactly:coordinates.lon)!)
		let dis = self.curCoord.distance(from: loc)
		return Int(dis/1000)
	}
	
	
	@Published  var airportList:[Airport] = []
	@Published var didFail = false
	
	@Published var curCoord = CLLocation()
}

struct LocationPickerView: View {
    
    @ObservedObject var vm:LPVM;
    @Binding var showingModal:Bool
    
    @State var active = true
	@State var text:String = ""
	

    
    
    var body: some View {
        VStack{
            HStack{
                TextField("Название аэропорта", text: self.$text,onEditingChanged:{ edited in
                    if edited {
                        self.vm.searchText(self.text)
                    }
                }).font(.title)
				Button(action: self.vm.location){
                    Image(systemName: "location.fill").padding(5)
                }
            }.padding()
            Divider()
            List(self.vm.airportList,id: \.self){ airport in
                Button(action: {
					self.vm.selected = airport.code
					self.showingModal = false
					
				}){
					HStack(alignment: .center){
						Text(airport.name)
						Spacer()
                        Text("\(self.vm.countDis(coordinates: airport.coordinates!)) КМ").font(.caption).fontWeight(.heavy).foregroundColor(.kirillGray)
					}
				}
                
                
            }
//            Button(action: {}){
//                Spacer()
//                Text("OK").foregroundColor(.baseWhite).font(.title)
//                Spacer()
//            }.padding().background(Color.blue).cornerRadius(10).padding()
        }.foregroundColor(.baseBlack)
		
			.alert(isPresented: .constant(self.vm.didFail)) {
			Alert(title: Text("Не получилось получить геопозицию.\n Проверьте доступ к геолокации в настройках.") )
		}
	}
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
		LocationPickerView( vm:LPVM(),showingModal: .constant(true))
    }
}
