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
        var screenWidth:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!}
        var screenHeight:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.height)!}
        

        var body: some View {
        
            TrackableScrollView(.horizontal, showIndicators: false, maxIndex: 6, index: self.$index, contentOffset: self.$offset){

               
                    InfoCardView(cities: .constant(["Москва","Грозный","Махачкала","Магас","Нальчик","Элиста","Геленджик","2","2","2","2","2","2","2"]))
                    ForEach( (0...5) , id:\.self ){_ in
                        withAnimation{
                            FlightCardView(height: .constant(self.calculateHeight(offset: self.offset)))
                        }
                    }
                

            }.frame(width: self.screenWidth,height: calculateHeight(offset: self.offset))//,height: CGFloat()



        }
    
        func calculateHeight(offset:CGFloat) -> CGFloat {
            
            if offset > self.screenWidth {
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
