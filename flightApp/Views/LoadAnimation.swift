//
//  LoadAnimation.swift
//  flightApp
//
//  Created by Кирилл on 07.06.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct LoadAnimation: View {
    @State var rotation:Double = 0;
    @State var viewOpacity:Double = 0
    func planeImage() -> UIImage{
        let image = UIImage(imageLiteralResourceName: "plane").maskWithColor(color: UIColor(named: "accentFirstLevel")!)
        
        
        return image!
    }
    var body: some View {
        VStack{
            ZStack {
                Circle().foregroundColor(.accentColor).frame(width: 90, height: 90)
                Circle().foregroundColor(.accentSecondLevel).frame(width: 60, height: 60)
//                Image(systemName: "xmark").resizable().scaledToFit().frame(width: 30, height: 40)
//                    .foregroundColor(.baseBlack)
                Image(uiImage: planeImage())
                    .resizable().scaledToFit().frame(width: 30, height: 30)
                    .padding(.bottom, 55)
                    .foregroundColor(.accentSecondLevel)
                    .rotationEffect(Angle(degrees: self.rotation))
                    .animation(.easeIn(duration: 60))
               
            }.frame(width: 90, height: 90, alignment: .center)
                .opacity(self.viewOpacity)
                .animation(.easeInOut(duration: 0.5))
                .onAppear {
                    withAnimation{
                        self.viewOpacity = 1
                        self.rotation += 360*12
                    }
                }
                .onDisappear {
                    withAnimation{
                        self.viewOpacity = 0
                    }
                }
        }
        
    }
}


struct LoadAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            VStack{
                LoadAnimation()
            }
        }
    }
}
