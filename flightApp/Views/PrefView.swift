//
//  PrefView.swift
//  flightApp
//
//  Created by Кирилл on 25.05.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI


struct PrefView: View {
	//@State var order:
    var body: some View {
		Picker(selection: Binding<Bool>.constant(true), label: EmptyView()) {
			Text("Production").tag(0)
			Text("Sandbox").tag(1)
		}//.pickerStyle()//.pickerStyle(P)
		
    }
}

struct PrefView_Previews: PreviewProvider {
    static var previews: some View {
        PrefView()
    }
}
