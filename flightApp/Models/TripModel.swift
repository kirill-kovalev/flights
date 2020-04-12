//
//  TripModel.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

struct TriptModel:Decodable {
    var cities:Int = 0;
    var days:Int = 0;
    var CityList:[String] = []
    var loadId:Int = -1
}
