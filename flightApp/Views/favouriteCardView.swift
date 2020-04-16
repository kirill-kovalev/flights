//
//  favouriteCardView.swift
//  flightApp
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct favouriteCardView: View {
    var body: some View {
        ZStack(alignment: .topLeading){
                   LinearGradient(gradient:
                   Gradient(colors: [Color(UIColor(red: 184/256, green: 236/256, blue: 255/256,alpha: 1)),
                                     Color(UIColor(red: 162/256, green:224/256, blue: 247/256,alpha: 1))]
                   ),startPoint: .top, endPoint: .bottom).cornerRadius(20)
            
        }.padding(.trailing,0)
        .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
        .frame(width: 200 , height:468)
    }
}

struct favouriteCardView_Previews: PreviewProvider {
    static var previews: some View {
        favouriteCardView()
    }
}
