//
//  MapView.swift
//  flightApp
//
//  Created by Кирилл on 12.06.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView :UIViewRepresentable {
	private class Landmark:NSObject, MKAnnotation {
		init(coordinates:Coord?,name:String) {
			self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinates?.lat ?? 0), longitude: CLLocationDegrees(coordinates?.lon ?? 0))
			self.title = name
		}
		var title: String?
		var coordinate: CLLocationCoordinate2D
	}
	private class mapDelegate:NSObject, MKMapViewDelegate {
		func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
			print("renderer")
			let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
			
			// Specify the thickness of the line.
			myPolyLineRendere.lineWidth = 3
			
			// Specify the color of the line.
			myPolyLineRendere.strokeColor = UIColor.red
			
			return myPolyLineRendere
		}
	}
	
	
	
	
	let map = MKMapView()
	
	init(cities:[String],show:Binding<Int> ) {
		map.mapType = .hybrid
		
		if let path = Bundle.main.path(forResource: "airports", ofType: "json") {
			print(path)
			do{
				let d = try  Data(contentsOf: URL(fileURLWithPath: path))
				let fileAirportList = try JSONDecoder().decode([Airport].self, from: d)
				
				for airport in fileAirportList {
					if cities.contains(airport.code){
						map.addAnnotation(Landmark(coordinates: airport.coordinates, name: airport.code))
						print(airport)
					}
				}
				
				var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 10, longitudinalMeters: 10)
				switch show.wrappedValue {
					case 0:
						for airport in fileAirportList {
							if (cities[0] ==  airport.code){
								var first = CLLocation(latitude: Double(airport.coordinates!.lat), longitude: Double(airport.coordinates!.lon))
								var second:CLLocation = map.userLocation.location ?? CLLocation(latitude: 0, longitude: 0);
								for airport2 in fileAirportList {
									if (cities[1] ==  airport2.code){
										second = CLLocation(latitude: Double(airport2.coordinates!.lat), longitude: Double(airport2.coordinates!.lon))
									}
								}
								let distance = first.distance(from: second)
								
								
								
								
								region = MKCoordinateRegion(center: first.coordinate, latitudinalMeters: distance / 2, longitudinalMeters: distance / 2)
							}
						}
					break
					case 1:
						for airport in fileAirportList {
							if (cities[0] ==  airport.code){
								var first = CLLocation(latitude: Double(airport.coordinates!.lat), longitude: Double(airport.coordinates!.lon))
								var second:CLLocation = map.userLocation.location ?? CLLocation(latitude: 0, longitude: 0);
								for airport2 in fileAirportList {
									if (cities[1] ==  airport2.code){
										second = CLLocation(latitude: Double(airport2.coordinates!.lat), longitude: Double(airport2.coordinates!.lon))
									}
								}
								let distance = first.distance(from: second)
								
								
								
								
								region = MKCoordinateRegion(center: second.coordinate, latitudinalMeters: distance / 2 , longitudinalMeters: distance / 2)
							}
						}
					break;
					default:
						for airport in fileAirportList {
							if (cities[0] ==  airport.code){
								var first = CLLocation(latitude: Double(airport.coordinates!.lat), longitude: Double(airport.coordinates!.lon))
								var second:CLLocation = map.userLocation.location ?? CLLocation(latitude: 0, longitude: 0);
								for airport2 in fileAirportList {
									if (cities[1] ==  airport2.code){
										second = CLLocation(latitude: Double(airport2.coordinates!.lat), longitude: Double(airport2.coordinates!.lon))
										
										var center = CLLocationCoordinate2D()
										center.latitude = (first.coordinate.latitude + second.coordinate.latitude) / 2
										center.longitude = (first.coordinate.longitude + second.coordinate.longitude) / 2
										
										let distance = first.distance(from: second) * 1.5
										region = MKCoordinateRegion(center: center,
																	latitudinalMeters: distance,
																	longitudinalMeters: distance)
										
										let coordinates = [first.coordinate,second.coordinate]
										let flightline = MKPolyline(coordinates: coordinates, count: coordinates.count)
										
									
										map.addOverlay(flightline)
										
									}
								}
								
								
							}
						}
					break
						
				}
				map.region = region
				
				
				//map.addOverlay()
				
				
				
			}catch{
				print(error)
			}
		}else{
			print("no file")
		}
	}

	
	
	func makeUIView(context: Context) -> MKMapView {
		

		return map
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
	}
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
		MapView(cities: ["LED","DME"], show: .constant (0)).edgesIgnoringSafeArea(.all)
    }
}
