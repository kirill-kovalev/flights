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
	@State var hasContent:Bool = false;
	
	
    @ObservedObject var vm:AppVM;
	
	


    var body: some View {
		ZStack(alignment: .topTrailing){
	
			TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
				Spacer()
				TopBarView(searchAction: {
					
                    self.vm.apiList.load { _ in
                        withAnimation{
                            self.hasContent = !self.vm.apiList.triplist.isEmpty
                        }
                        
                    }
					

				}, favouriteAction: {
					withAnimation(){
                        self.vm.isFavContent = true
					}
                }).frame(height: self.hasContent ? 390 : UIApplication.screenHeight)
				
                if(!self.vm.apiList.triplist.isEmpty){
                    ForEach(self.vm.apiList.triplist, id: \.self){ tripM in
                        TripRowView(vm: self.vm,tripInfo: tripM)
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
		SearchPageView(vm: AppVM())
    }
}
