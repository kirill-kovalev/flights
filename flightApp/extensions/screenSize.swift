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
	static public var  screenWidth:CGFloat { return UIWindow(frame:UIScreen.screens.first!.bounds).safeAreaLayoutGuide.layoutFrame.width}
	static public var screenHeight:CGFloat { return UIWindow(frame:UIScreen.screens.first!.bounds).safeAreaLayoutGuide.layoutFrame.height}

}

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
