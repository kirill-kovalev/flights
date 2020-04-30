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
	
	@State var presentDatePicker1:Bool = false
	@State var presentDatePicker2:Bool = false
	var rkManager1: RKManager {
		return RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: rkManager2.selectedDate ?? Date().addingTimeInterval(7*60*60*24), mode: 0)
	}
	var rkManager2:RKManager {
		return RKManager(calendar: Calendar.current, minimumDate: Date() , maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
	}
	var displayDate1:String {
		let date = rkManager1.selectedDate ?? Date()
		let df = DateFormatter()
		df.dateStyle = .long
		return df.string(from: date)
	}
	var displayDate2:String {
		let date = rkManager2.selectedDate ?? Date().addingTimeInterval(7*60*60*24)
		let df = DateFormatter()
		df.dateStyle = .long
		return df.string(from: date)
	}
	
	@State var presentLocationPicker:Bool = false
	
	
	var w:CGFloat{ return TripRowView().screenWidth}
    var body: some View {
		
			
			VStack(spacing:0){
				HStack(spacing:0){
					Text("Дата вылета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				Button(action: {self.presentDatePicker1.toggle()}){
					Text("\(displayDate1)")
					Spacer()
					Image(systemName: "calendar").foregroundColor(.kirillGray)
				}.font(.largeTitle).foregroundColor(.cityGray)
				.padding([.top,.bottom],5)
				.sheet(isPresented: self.$presentDatePicker1){
					RKViewController(isPresented: self.$presentDatePicker1, rkManager: self.rkManager1)
				}
				
				
				
				HStack(spacing:0){
					Text("Дата прилета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				Button(action: {self.presentDatePicker2.toggle()}){
					Text("\(displayDate2)")
					Spacer()
					Image(systemName: "calendar").foregroundColor(.kirillGray)
				}.font(.largeTitle).foregroundColor(.cityGray)
					.padding([.top,.bottom],5)
					.sheet(isPresented: self.$presentDatePicker2){
						RKViewController(isPresented: self.$presentDatePicker2, rkManager: self.rkManager2)
				}
				
				
				
				HStack(spacing:0){
					Text("Бюджет").font(.headline).padding(.bottom,10)
					Spacer()
				}
				
				HStack(spacing:0){
					TextField("000 ₽", text: .constant(""))
					.padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 0))
					.font(.title).keyboardType(.numberPad)
					
					Button(action: {self.presentLocationPicker.toggle()}){
						Image(systemName: "location.fill")
							.resizable()
							.scaledToFit()
							.foregroundColor(.kirillGray)
							.padding(10)
							.frame(width: 50, height: 50)
						}.background(Color.gray.opacity(0.3)).cornerRadius(10)
					
				}.background(Color.baseWhite.opacity(0.8))
				.padding(.bottom,15).padding(.trailing,-10)
				.sheet(isPresented: self.$presentLocationPicker){
						Text("Picker")
				}
				
				
				
				
				

				HStack{
					Button(action:searchAction){
						Spacer()
						Text("Поехали!").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).padding(15)
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
			.foregroundColor(.baseBlack)
			.background(Color.baseWhite)
			
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
