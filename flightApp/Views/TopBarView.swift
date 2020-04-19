//
//  TopBarView.swift
//  flightApp
//
//  Created by Кирилл on 19.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
		ZStack{
			Color.gray.opacity(0.9)
			VStack(spacing:0){
				HStack(spacing:0){
					Text("Дата вылета")
					Spacer()
				}
				
			}.padding(20)
			
		}.cornerRadius(20)
		.padding(17)
		
		
		//.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
