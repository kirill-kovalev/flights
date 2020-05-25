//
//  screenSize.swift
//  flightApp
//
//  Created by Кирилл on 08.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
	static public var  screenWidth:CGFloat { return (UIScreen.screens.first?.bounds.width)!}
	static public var screenHeight:CGFloat { return (UIScreen.screens.first?.bounds.height)!}

}

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
