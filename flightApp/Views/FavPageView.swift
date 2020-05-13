//
//  FavPageView.swift
//  flightApp
//
//  Created by Кирилл on 27.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

class FavVM :ObservableObject{
	@Published var trips = favouriteListModel();
	
}

struct FavPageView: View {
	@Binding var isFavContent:Bool
	
	
	@ObservedObject var vm = FavVM()
    var body: some View {
		
		ZStack(alignment: .topLeading){
			
			TrackableScrollView(.vertical, showIndicators: false, contentOffset: .constant(0)){
				ForEach(self.vm.trips.triplist, id: \.self){ tripM in
					TripRowView(tripInfo: tripM)
				}

			}.padding(.top,20)
			
			HStack(spacing:10){
				
				Button(action: {
					withAnimation(){
						self.isFavContent = false
					}
				}){
					Image(systemName: "chevron.left.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(Color.baseWhite).cornerRadius(100).shadow(radius: 10)
				}
				
			}.padding(15)
			
		}.frame(width: UIApplication.screenWidth)
    }
}

struct FavPageView_Previews: PreviewProvider {
    static var previews: some View {
		FavPageView(isFavContent: .constant(true))
    }
}
