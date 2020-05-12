//
//  TripListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

class TripListModel{
	private var _triplist:[TripModel] = []
	var triplist:[TripModel] {
		get{
			return self._triplist
		}
	}
	
	public func add(_ item:TripModel){
		self._triplist.append(item)
		
	}
	
	public func remove(_ id:UUID) -> Bool{
		var i = 0;
		while(i < self._triplist.count){
			if self._triplist[i].localID == id {
				self._triplist.remove(at: i);
			}
			i+=1;
		}
		return false
	}
	
}

