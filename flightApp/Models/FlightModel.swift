//
//  FlightModel.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

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
