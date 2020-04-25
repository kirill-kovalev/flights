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
			LinearGradient(gradient: .favouriteBG ,startPoint: .top, endPoint: .bottom).cornerRadius(20).frame(width: 250 )

			if (isSet){
				Image(systemName:  "star.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray)
					.transition(.opacity)
			}else{
				Image(systemName: "star.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray)
					.transition(.opacity)
			}
						

        }
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
		.padding(17)
		.padding(.leading,-284)
		//
        
	}
}

struct favouriteCardView_Previews: PreviewProvider {
    static var previews: some View {
		favouriteCardView(isSet: .constant(true)).padding(.leading,250)
    }
}
