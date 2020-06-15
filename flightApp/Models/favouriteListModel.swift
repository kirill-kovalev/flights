//
//  favouriteListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation
import CloudKit


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
	override func add(_ item: TripModel) {
		super.add(item)
		save()
	}
	override func remove(_ id: UUID?) {
		super.remove(id)
		save()
	}
	func save() {
		print("saving favourites")
		do{
			UserDefaults.standard.set(try JSONEncoder().encode(self.triplist), forKey: "Favourites")
		}catch{
			print("____________________________________\nFavourite List Save Error:")
			print(error)
			print("____________________________________")
		}
		
	}
	deinit {
		save()
	}
}
