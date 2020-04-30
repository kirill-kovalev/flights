//
//  SearchPageView.swift
//  flightApp
//
//  Created by Кирилл on 27.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct SearchPageView: View {
	@State var offset:CGFloat = 10;
	@State var index:Int = 0
	@Binding var isFavContent:Bool

	@State var hasContent:Bool = false;
    var body: some View {
		ZStack(alignment: .topTrailing){
	
			TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
				Spacer()
				TopBarView(searchAction: {
					withAnimation{
						self.hasContent = true
					}
					
				}, favouriteAction: {
					withAnimation(){
						self.isFavContent = true
					}
				}, locationAction: {
					
				}).frame(height: self.hasContent ? 390 : TripRowView().screenHeight)//.animation(.easeInOut)
				
				
				if(self.hasContent){
					ForEach((0...2),id:\.self)
					{ id in
						TripRowView()
					}
				}
				
				
			}
			
			if(self.offset > 350){
				
				HStack(spacing:10){
					Button(action: {}){
						Image(systemName: "magnifyingglass.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(Color.baseWhite).cornerRadius(100).shadow(radius: 10)
					}
					
					Button(action: {
						
						withAnimation(){
							self.isFavContent = true
						}
						
					}){
						Image(systemName: "star.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(LinearGradient(gradient: .favouriteBG, startPoint: .top, endPoint: .bottom)).cornerRadius(100).shadow(radius: 10)
					}
					
				}.padding(15).animation(.linear)
			}
			
			
		}.frame(width: TripRowView().screenWidth)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
		SearchPageView(isFavContent: .constant(true))
    }
}
