//
//  favouriteListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation
class favouriteListModel :TripListModel{
	override init() {
		super.init()
		load()
	}
	func load() {
		print("loading favourites")
		
		//self.triplist = (UserDefaults.standard.object(forKey: "Favourites") as! [TripModel]?) ?? []
		do{
			self.triplist = try JSONDecoder().decode([TripModel].self, from: UserDefaults.standard.data(forKey: "Favourites") ?? Data())
		}catch{
			print(error)
		}
	}
	func save() {
		print("saving favourites")
		do{
			UserDefaults.standard.set(try JSONEncoder().encode(self.triplist), forKey: "Favourites")
		}catch{
			print(error)
		}
		
	}
	deinit {
		save()
	}
}
