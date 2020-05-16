//
//  APIListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

class APIListModel: TripListModel{
	
    func load(completion: ((Error?)->Void)? = nil){
        self.loadCompletion = completion
		print("starting load")
		
		
		self.triplist = []
		
		for i in (0...0) {
            let _ = i
			guard let url = URL(string: "https://extendsclass.com/api/json-storage/bin/cdfabfc") else {
				print("Error in generating url")
				return;
			}
			
			URLSession.shared.dataTask(with: url, completionHandler: {
				data , response, error in
				if error == nil, (response as! HTTPURLResponse).statusCode == 200,data != nil {
					UserDefaults.standard.set(data!, forKey: "cache")
					do{
						var decodedJSON =  try JSONDecoder().decode([TripModel].self, from: data!)
						
						for j in (0...decodedJSON.count-1) {
							decodedJSON[j].localID = UUID();
							for i in (0...decodedJSON[j].fligts.count-1){
								decodedJSON[j].fligts[i].localID = UUID()
							}
						}
//                        self.triplist = decodedJSON
                        print("decoded -> triplist")
						self.triplist.append(contentsOf:decodedJSON)
                        
					}catch{
						print(error)
					}
					
				}
				
				
				
			}).resume();
		}
		
		
		return;
	}
}
