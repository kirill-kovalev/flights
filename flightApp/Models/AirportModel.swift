//
//  AirportModel.swift
//  flightApp
//
//  Created by Кирилл on 21.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation
struct Coord: Encodable,Decodable,Hashable{
	let lon:Float;
	let lat:Float;
}
struct Airport : Encodable, Decodable,Hashable {	
	var name:String
	var code:String
	var coordinates:Coord?
}
