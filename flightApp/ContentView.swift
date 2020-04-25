//
//  ContentView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var offset:CGFloat = 10;
    @State var index:Int = 0
	
	@State var isFavContent:Bool = false
    var body: some View {
        
		HStack{
			
		
			ZStack(alignment: .top){
			
			
				TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
					VStack{
						Rectangle().foregroundColor(.clear).frame(height: 370)
						ForEach((0...2),id:\.self)
						{ id in
							TripRowView()
						}
					}.padding(.top,20)
				}
								
				TopBarView(searchAction: {
					
				}, favouriteAction: {
					withAnimation(){
						self.isFavContent = true
					}
				}).frame(height: 390).offset(y:  -offset)

			}
			
				

		}.offset(x: self.isFavContent ? -1 * TripRowView().screenWidth / 2 : 0  )

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
