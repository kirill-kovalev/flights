//
//  APIListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation



enum APIListLoadError{
	case none;
	case networkError;
	case decodeError;
}



class APIListModel: TripListModel{
	var error:APIListLoadError = .none
	
    private let searchDelegate = SearchDelegate()
	
	
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
		
		
//		for i in (3...3) {
//			guard let url = URL(string: "http://194.67.113.229:8080/api/randomroute??origin=\(origin)&roundtrip=true&max_price=\(max_price)&departure_date=\(df.string(from: dateStart))&arrival_date=\(df.string(from: dateEnd))&key=IFEuNj9SY2gmZ9x4") else {
//				print("Error in generating url")
//				return;
//			}
			let url = URL(string: "https://extendsclass.com/api/json-storage/bin/cebdece")!;
			print(url)
			
			//let us = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
			
			
			
            URLSession(configuration: .default, delegate: self.searchDelegate, delegateQueue: nil)
			.dataTask(with: url, completionHandler: {
				data , response, error in
				if error == nil, (response as! HTTPURLResponse).statusCode == 200,data != nil {
					UserDefaults.standard.set(data!, forKey: "cache")
					do{
						let decoder = JSONDecoder()
						decoder.dateDecodingStrategy = .formatted(df)
						let decodedJSON =  try decoder.decode([TripModel].self, from: data!)
                        var routes = decodedJSON
						if routes.count > 0 {
							for j in (0..<routes.count) {
								routes[j].localID = UUID();
								for i in (0..<routes[j].flights.count){
									routes[j].flights[i].localID = UUID()
								}
							}
						}
						

                        print("decoded -> triplist")
						self.triplist.append(contentsOf:routes)
						print(self.triplist)
						DispatchQueue.main.async{
							self.error = .none
							if completion != nil {
								completion!(nil)
							}
						}
                        
					}catch{
                        print(data)
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
//		}
		
		
		return;
	}
	
	
}
class SearchDelegate:NSObject, URLSessionDataDelegate{
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//
//    }
//
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(progress)
    }
    
}
