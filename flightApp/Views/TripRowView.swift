//
//  TripRowView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TripRowView: View {
	@State var offset:CGFloat = 0
    @State var index:Int = 0
	@State var isFavourite = false;
        var screenWidth:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!}
        var screenHeight:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.height)!}
        

        var body: some View {
            //ZStack{
                //Rectangle().foregroundColor(.clear)
                PagedView(.horizontal, maxIndex: 20, index: self.$index, contentOffset: self.$offset){
					favouriteCardView(isSet: self.$isFavourite)
                    InfoCardView(cities: ["Москва","Грозный","Махачкала","Магас","Нальчик","Элиста","Геленджик"])
					ForEach( (0...20) , id:\.self ){_ in
						
							FlightCardView().frame(width: self.screenWidth)
						
                    }
                }.frame(width: self.screenWidth,height: calculateHeight(offset: self.offset))//,height: CGFloat()
				//Text("\(self.offset)\n\(self.isFavourite ? "true" : "false")")
            //}



        }
    
        func calculateHeight(offset:CGFloat) -> CGFloat {
            
            if offset >= self.screenWidth {
                return  self.screenHeight
            }else{
                var coef = -1 * offset / self.screenWidth
                if coef > 1 {
                    coef = 1
                }
                if coef < 0 {
                    coef = 0
                }
                let height = (screenHeight - 468 ) * coef
                return height + 468;
            }
        }
}


struct TripRowView_Previews: PreviewProvider {
    static var previews: some View {
        TripRowView()
    }
}
