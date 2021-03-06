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
	
    var rkManager1:RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate:  Date().addingTimeInterval(60*60*24*30*3))
    var rkManager2:RKManager = RKManager(calendar: Calendar.current, minimumDate: Date() , maximumDate: Date().addingTimeInterval(60*60*24*30*3))
	
	
	init() {
		self.dateFormatter.dateStyle = .long
		self.dateFormatter.locale = Locale(identifier: "ru_RU")
		
		self.rkManager1.selectedDate = Date()
		self.rkManager2.selectedDate = Date().addingTimeInterval(60*60*24*7)
		
        self.rkManager1.onSelected = { date in
            self.rkManager2.minimumDate = date
            self.rkManager2.maximumDate = date.addingTimeInterval(60*60*24*30*3)
			if self.rkManager2.selectedDate < date {
				self.rkManager2.selectedDate = date.addingTimeInterval(60*60*24*4)
			}
        }
        
        self.rkManager2.onSelected = { date in
            self.rkManager1.maximumDate = date
			if self.rkManager1.selectedDate > self.rkManager1.maximumDate{
				self.rkManager1.selectedDate = self.rkManager1.maximumDate
			}
        }
	}
	
	private let dateFormatter = DateFormatter();
	
	
	var displayDate1:String {
		return self.dateFormatter.string(from: Date1)
	}
	var displayDate2:String {
		return self.dateFormatter.string(from: Date2)
	}
	
	func check() ->Bool {
		if Date1 < Date2{
			self.readyToGo = true
		}
		return false
	}
	
	@Published var readyToGo = false
	@Published var budget:String = "20"
	
	
	@Published var lpvm = LPVM();
	
	@Published var searchActive = true
	
}



struct TopBarView: View {
	@ObservedObject var vm:TopBarVM
	var searchAction : ()->Void 
	var favouriteAction : ()->Void
	
	@State var presentDatePicker1:Bool = false
	@State var presentDatePicker2:Bool = false
	
	
	
	
	
	
	

	
	@State var presentLocationPicker:Bool = false
	
	@State var kbSize:CGFloat = 0
	
	var w:CGFloat{ return UIApplication.screenWidth}
    var body: some View {
		
		VStack{
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
					TextField("20", text: self.$vm.budget).multilineTextAlignment(.trailing)
					.padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 0))
						.font(.title).keyboardType(.numberPad)
					Text("  000 ₽       ").font(.title)
					Button(action: {self.presentLocationPicker.toggle()}){
						Image(systemName: "mappin.and.ellipse")
							.resizable()
							.scaledToFit()
							.foregroundColor(.kirillGray)
							.padding(5)
							.frame(width: 50, height: 50)
						}//.background(Color.gray.opacity(0.3)).cornerRadius(10)
					
				}.background(Color.baseWhite.opacity(0.8))
				.padding(.bottom,15).padding(.trailing,-10)
				.sheet(isPresented: self.$presentLocationPicker){
					LocationPickerView(vm:self.vm.lpvm,showingModal: self.$presentLocationPicker)
				}
				
				HStack{
					Button(action:searchAction){
						Spacer()
						Text("Поехали!").font(.title).fontWeight(.bold).foregroundColor(.baseWhite).padding(15)
						Spacer()
					}.background(self.vm.searchActive ? Color.blue : Color.gray  )
					.padding(EdgeInsets(top: 0, leading: -20, bottom: -20, trailing: 0))
					.disabled(!self.vm.searchActive)
					
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
			.padding(.top,-self.kbSize)
			.onAppear(perform: {
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
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
		TopBarView(vm: TopBarVM(), searchAction: {}, favouriteAction: {})
    }
}
