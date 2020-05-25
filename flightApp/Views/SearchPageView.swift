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
	@State var loadErr:Bool = false;
	
	
    @ObservedObject var vm:AppVM;
	
	


    var body: some View {
		ZStack(alignment: .topTrailing){
			
				TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
					Spacer()
					TopBarView(vm:self.vm.searchBar,
					searchAction: {
						
						print("______________________\n\(self.vm.searchBar.budget)")
						
						self.vm.apiList.load(Int(self.vm.searchBar.budget) ?? 0 ,self.vm.searchBar.Date1,self.vm.searchBar.Date2) { err in
							if err != nil {
								self.loadErr = true
							}
							withAnimation{
								self.hasContent = !self.vm.apiList.triplist.isEmpty
							}
							
						}
						
						
					}, favouriteAction: {
						withAnimation(){
							self.vm.isFavContent = true
						}
					}).frame(height: self.hasContent ? 390 : UIApplication.screenHeight)
					
					if(!self.vm.apiList.triplist.isEmpty ){
						if(!self.vm.isFavContent){
							ForEach(self.vm.apiList.triplist, id: \.self){ tripM in
									TripRowView(vm: self.vm,tripInfo: tripM)
							}
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
		
		.alert(isPresented: self.$loadErr){
			Alert(title: Text("Ошибка подключения"), message: Text("Не удалось получить данные с сервера"), dismissButton: nil)
		}
		
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
		SearchPageView(vm: AppVM())
    }
}
