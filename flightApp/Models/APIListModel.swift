//
//  APIListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation
import SwiftUI

enum APIListLoadError{
	case none;
	case networkError;
	case decodeError;
	
}
class APIListModel: TripListModel{
	var error:APIListLoadError = .none
	
	func load(_ budget:Int,_ dateStart:Date,_ dateEnd:Date,_ airport:String,completion: ((Error?)->Void)? = nil){
        self.loadCompletion = completion
		print("starting load")
		print(airport)
		
		self.triplist = []
		
		let df = DateFormatter()
		df.calendar = Calendar.current
		df.dateFormat = "YYYY-MM-dd"
		
		let origin = airport.uppercased()
		let max_price = budget;
		
		
		for i in (5...5) {
			guard var url = URL(string: "http://194.67.113.229:8080/api/route?origin=\(origin)&roundtrip=false&max_price=\(max_price)&number_of_cities=\(i)&departure_date=\(df.string(from: dateStart))&arrival_date=\(df.string(from: dateEnd))") else {
				print("Error in generating url")
				return;
			}
			//url = URL(string: "https://extendsclass.com/api/json-storage/bin/caacacd")!;
			print(url)
			
			//let us = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
			
			
			
			
			URLSession.shared.dataTask(with: url, completionHandler: {
				data , response, error in
				if error == nil, (response as! HTTPURLResponse).statusCode == 200,data != nil {
					UserDefaults.standard.set(data!, forKey: "cache")
					do{
						let decoder = JSONDecoder()
						decoder.dateDecodingStrategy = .formatted(df)
						var decodedJSON =  try decoder.decode([TripModel].self, from: data!)
						if decodedJSON.count > 0 {
							for j in (0..<decodedJSON.count) {
								decodedJSON[j].localID = UUID();
								for i in (0...decodedJSON[j].flights.count-1){
									decodedJSON[j].flights[i].localID = UUID()
								}
							}
						}
						

                        print("decoded -> triplist")
						self.triplist.append(contentsOf:decodedJSON)
						print(self.triplist)
						DispatchQueue.main.async{
							self.error = .none
							if completion != nil {
								completion!(nil)
							}
						}
                        
					}catch{
						self.error = .decodeError
						DispatchQueue.main.async{
							if completion != nil {
								completion!(error)
							}
						}
						print(error)
					}
					
				}else{
					self.error = .networkError
					DispatchQueue.main.async{
						if completion != nil {
							completion!(error)
						}
					}
				}
				
				
				
			}).resume();
		}
		
		
		return;
	}
	
	
}
