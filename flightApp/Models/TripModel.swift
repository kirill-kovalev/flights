//
//  TripModel.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.


import Foundation

struct TripModel: Codable,Hashable {
    let totalPrice:Float
    let days: Int
    let ticketLink: String
    var cityList: [CityList]
    var flights: [FlightModel]
    let visa: Bool
    var localID:UUID?
}

// MARK: - CityList
struct CityList: Codable,Hashable {
    let partOfTheWorld: String?
    let avgTemperature: Int
    let cityName: String
}
