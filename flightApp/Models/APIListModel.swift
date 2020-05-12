//
//  APIListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

class APIListModel: TripListModel {
	func load() -> Bool {
		print("starting load")
		guard let url = URL(string: "https://extendsclass.com/api/json-storage/bin/bdadafd") else {
			print("Error in generating url")
			return false;
		}
		URLSession.shared.dataTask(with: url, completionHandler: {
			data , response, error in
			
				print("competion handler start")
				print(response)
				print(data)
				print("competion handler end")
			
		});
		print("ended")
		return false;
	}
}
