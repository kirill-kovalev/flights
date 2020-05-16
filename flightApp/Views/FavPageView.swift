//
//  FavPageView.swift
//  flightApp
//
//  Created by Кирилл on 27.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI




struct FavPageView: View {
	@ObservedObject var vm:AppVM;

    var body: some View {
		
		ZStack(alignment: .topLeading){
            if !self.vm.favouriteList.triplist.isEmpty {
                TrackableScrollView(.vertical, showIndicators: false, contentOffset: .constant(0)){
                    ForEach(self.vm.favouriteList.triplist, id: \.self){ tripM in
                        TripRowView(vm: self.vm, tripInfo: tripM)
                    }

                }.padding(.top,20)
            }else{
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Список избранного пуст").font(.largeTitle).fontWeight(.semibold).foregroundColor(.baseBlack).multilineTextAlignment(.center)
                        
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                }
            }
			
			
			HStack(spacing:10){
				
				Button(action: {
					withAnimation(){
                        self.vm.isFavContent = false
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
        FavPageView(vm: AppVM())
    }
}
