//
//  FlightModel.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation

struct FlightModel: Encodable,Decodable,Hashable {
	var localID = UUID()
    var cityStart:String = ""
    var cityEnd:String = ""
    var takeoffTime:Date?
    var landingTime:Date?
    var startAirport:String = "XXX"
    var endAirport:String = "XXX"
    
    var companyLogoLink:String = ""
    var companyName:String = ""
    
    var ticketLink:String = ""
    
}
