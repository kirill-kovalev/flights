//
//  favouriteCardView.swift
//  flightApp
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct favouriteCardView: View {
	@Binding var isSet:Bool
	
    var body: some View {
		ZStack(alignment: .center){
			LinearGradient(gradient:
				Gradient(colors: [Color(UIColor(red: 256/256, green: 232/256, blue: 139/256,alpha: 1)),
								  Color(UIColor(red: 256/256, green:213/256, blue: 101/256,alpha: 1))]
			),startPoint: .top, endPoint: .bottom).cornerRadius(20).frame(width: 250 , height:468)
			VStack{
				HStack{
					withAnimation{
						Image(systemName: isSet ? "star.circle.fill" : "star.circle").resizable().frame(width: 75, height: 75).foregroundColor(.kirillGray)
					}
				}
			}
        }
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
		.padding(.leading,-250)
        
    }
}

struct favouriteCardView_Previews: PreviewProvider {
    static var previews: some View {
		favouriteCardView(isSet: .constant(true)).padding(.leading,250)
    }
}
