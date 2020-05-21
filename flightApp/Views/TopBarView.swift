//
//  TopBarView.swift
//  flightApp
//
//  Created by Кирилл on 19.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI


class TopBarVM:ObservableObject {
	
	var Date1:Date {return rkManager1.selectedDate ?? Date()}
	var Date2:Date {return rkManager2.selectedDate ?? Date()}
	
	var rkManager1:RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate:  Date().addingTimeInterval(60*60*24*30*3), mode: 0)
	var rkManager2:RKManager { return RKManager(calendar: Calendar.current, minimumDate: Date1 , maximumDate: Date().addingTimeInterval(60*60*24*30*3), mode: 0)}
	
	
	init() {
		self.dateFormatter.dateStyle = .long
	}
	
	private let dateFormatter = DateFormatter();
	
	
	var displayDate1:String {
		return self.dateFormatter.string(from: Date1)
	}
	var displayDate2:String {
		let date = rkManager2.selectedDate ?? Date().addingTimeInterval(7*60*60*24)
		return self.dateFormatter.string(from: date)
	}
	

	
	
	
	
	
}



struct TopBarView: View {
	var searchAction : ()->Void 
	var favouriteAction : ()->Void
	
	@State var presentDatePicker1:Bool = false
	@State var presentDatePicker2:Bool = false
	
	var vm = TopBarVM()
	@State var budget:String = ""
	
	

	
	@State var presentLocationPicker:Bool = false
	
		@State var kbSize:CGFloat = 0
	
	var w:CGFloat{ return UIApplication.screenWidth}
    var body: some View {
		
			
			VStack(spacing:0){
				HStack(spacing:0){
					Text("Дата вылета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				Button(action: {self.presentDatePicker1.toggle()}){
					Text("\(vm.displayDate1)")
					Spacer()
					Image(systemName: "calendar").foregroundColor(.kirillGray)
				}.font(.largeTitle).foregroundColor(.cityGray)
				.padding([.top,.bottom],5)
				.sheet(isPresented: self.$presentDatePicker1){
					RKViewController(isPresented: self.$presentDatePicker1, rkManager: self.vm.rkManager1)
				}
				
				
				
				HStack(spacing:0){
					Text("Дата прилета").font(.headline).padding(.bottom,10)
					Spacer()
				}
				Button(action: {self.presentDatePicker2.toggle()}){
					Text("\(vm.displayDate2)")
					Spacer()
					Image(systemName: "calendar").foregroundColor(.kirillGray)
				}.font(.largeTitle).foregroundColor(.cityGray)
					.padding([.top,.bottom],5)
					.sheet(isPresented: self.$presentDatePicker2){
						RKViewController(isPresented: self.$presentDatePicker2, rkManager: self.vm.rkManager2)
				}
				
				
				
				HStack(spacing:0){
					Text("Бюджет").font(.headline).padding(.bottom,10)
					Spacer()
				}
				
				HStack(spacing:0){
					TextField("000 ₽", text: self.$budget)
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
                    LocationPickerView(vm:LPVM())
				}
				
				
				
				
				

				HStack{
					Button(action:searchAction){
						Spacer()
						Text("Поехали!").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).padding(15)
						Spacer()
					}.background(Color.blue)
					.padding(EdgeInsets(top: 0, leading: -20, bottom: -20, trailing: 0))
						//.disabled(!self.vm.readyToGo)
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
				
				.padding(.top,-self.kbSize).onAppear(perform: {
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ noti in
						let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect;
						let height = value.height
						withAnimation{
							self.kbSize = height
							print(height)
						}
						
					}
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ _ in
						withAnimation{
							self.kbSize = 0
							print("hidden")
						}
					}
				})
		
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
		TopBarView(searchAction: {}, favouriteAction: {})
    }
}
