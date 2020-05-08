//
//  TripModel.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

struct TripModel: Encodable,Decodable,Hashable {
	var localID = UUID()
    var days:Int = 0;
    var cityList:[String] = []
	var fligts:[FlightModel] = []
	var price:Int = 0
    
}
