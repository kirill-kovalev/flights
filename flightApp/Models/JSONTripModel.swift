//
//  JSONTripModel.swift
//  flightApp
//
//  Created by Кирилл on 02.06.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

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

// MARK: - FlightModel
struct FlightModel: Codable,Hashable {
    let startAirport, endAirport: String
    let price:Float
    let landingTime: Int
    let companyLogoLink: String
    let originCity, destCity:String
    let companyName: String
    let departureDate:Date?
    let visaType: VisaType?
    var localID:UUID?
    let ticketLink:String?
}

enum VisaType: String, Codable,Hashable {
    case schengen = "Schengen"
    case uk = "UK"
}
