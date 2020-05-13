//
//  SearchPageView.swift
//  flightApp
//
//  Created by Кирилл on 27.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

class SearchVM : ObservableObject{
	@Published var trips = APIListModel()

}

struct SearchPageView: View {
	@State var offset:CGFloat = 10;
	@State var index:Int = 0
	@State var hasContent:Bool = false;
	
	@Binding var isFavContent:Bool
	
	@ObservedObject var vm = SearchVM();
	
	//@ObservedObject var api = APIListModel();
	init(isFavContent:Binding<Bool>) {
		self._isFavContent = isFavContent
		self.vm.trips.load()
		
	}

    var body: some View {
		ZStack(alignment: .topTrailing){
	
			TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
				Spacer()
				TopBarView(searchAction: {
					withAnimation{
						if(self.vm.trips.triplist.count > 0){
							self.hasContent = true
						}
						self.vm.trips.load()
						
					}
					
				}, favouriteAction: {
					withAnimation(){
						self.isFavContent = true
					}
				}).frame(height: self.hasContent ? 390 : UIApplication.screenHeight)
				
				
				if(self.hasContent){

					ForEach(self.vm.trips.triplist, id: \.self){ tripM in
						TripRowView(tripInfo: tripM)
					}
				}
				
				
			}
			
//			if(self.offset > 350){
//				withAnimation{
//				HStack(spacing:10){
//					Button(action: {}){
//						Image(systemName: "magnifyingglass.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(Color.baseWhite).cornerRadius(100).shadow(radius: 10)
//					}
//
//					Button(action: {
//
//						withAnimation(){
//							self.isFavContent = true
//						}
//
//					}){
//						Image(systemName: "star.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(LinearGradient(gradient: .favouriteBG, startPoint: .top, endPoint: .bottom)).cornerRadius(100).shadow(radius: 10)
//					}
//
//				}.padding(15).animation(.linear)
//				}
//			}
			
			
		}.frame(width: UIApplication.screenWidth)
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
		SearchPageView(isFavContent: .constant(true))
    }
}
