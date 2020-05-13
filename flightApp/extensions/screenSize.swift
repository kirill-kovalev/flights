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
	static public var  screenWidth:CGFloat { return (UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.safeAreaLayoutGuide.layoutFrame.width)}
	static public var screenHeight:CGFloat { return (UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.safeAreaLayoutGuide.layoutFrame.height)}

}

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
