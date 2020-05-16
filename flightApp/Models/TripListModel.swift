//
//  TripListModel.swift
//  flightApp
//
//  Created by Кирилл on 12.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

class TripListModel{
    var triplist:[TripModel] = [] {
        didSet{
           
            (self.loadCompletion ?? handler)(nil)
        }
    }
    private func handler(er:Error?) -> Void {
        print("set triplist for \(self)")
        print("______________________________")
        print(triplist)
        print("______________________________")
    }
    var loadCompletion:((Error?)->Void)? = nil
	
	
	public func add(_ item:TripModel){
		self.triplist.append(item)
		
	}
	
	public func remove(_ id:UUID) -> Bool{
		var i = 0;
		while(i < self.triplist.count){
			if self.triplist[i].localID == id {
				self.triplist.remove(at: i);
			}
			i+=1;
		}
		return false
	}
	
}

