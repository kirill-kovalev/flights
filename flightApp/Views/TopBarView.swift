//
//  TopBarView.swift
//  flightApp
//
//  Created by Кирилл on 19.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
	var searchAction : ()->Void 
	var favouriteAction : ()->Void
    var body: some View {
		
			
			VStack(spacing:0){
				HStack(spacing:0){
					Text("Дата вылета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				DatePicker("", selection: .constant(Date()), displayedComponents: .date)
					.frame(height: 65).cornerRadius(0).padding(.leading,-20)
				
				
				HStack(spacing:0){
					Text("Дата прилета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				DatePicker("", selection: .constant(Date()), displayedComponents: .date)
					.frame(height: 65).cornerRadius(0).padding(.leading,-20)
					.cornerRadius(30)
				
				
				HStack(spacing:0){
					Text("Бюджет").font(.headline).padding(.bottom,10)
					Spacer()
				}
				
				HStack{
				TextField("000 ₽", text: .constant(""))
					.textContentType(.creditCardNumber)
					.padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
					.font(.title)
				}.background(Color.baseWhite.opacity(0.8))
				.padding(.bottom,20)
				
				
				
				

				HStack{
					Button(action:searchAction){
						Spacer()
						Text("Поехали!").font(.title).fontWeight(.bold).foregroundColor(Color("BaseWhite")).padding(15)
						Spacer()
					}.background(Color.blue)
						.padding(EdgeInsets(top: 0, leading: -20, bottom: -20, trailing: 0))
					Button(action: favouriteAction){
						Image(systemName: "star.circle").resizable().scaledToFit().foregroundColor(.kirillGray)
							.padding(10)
							.frame(width: 65,height: 65)
					}.background(LinearGradient(gradient: .favouriteBG ,startPoint: .top, endPoint: .bottom))
					.padding(EdgeInsets(top: 0, leading: 0, bottom: -20, trailing: -20))
				}
			}.padding(20)
			.foregroundColor(.kirillGray)
			.background(Color.init(red: 0.8, green: 0.8, blue: 0.8))
			
		.cornerRadius(20)
		.padding(17)
		.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)), radius: 13, x: 0, y: 4)
		
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
		TopBarView(searchAction: {}, favouriteAction: {})
    }
}
