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
    @State var isLoading = false
	
	
    @ObservedObject var vm:AppVM;
	
	@State var nothingloaded = false
    
    private var budget:Int { (Int(self.vm.searchBar.budget) ?? 0)*1000 }
    
    func load(){
        self.isLoading = true
        self.vm.apiList.load(self.budget ,self.vm.searchBar.Date1,self.vm.searchBar.Date2,self.vm.searchBar.lpvm.selected) { err in
            self.isLoading = false
            
            if err != nil {
                self.loadErr = true
                self.vm.searchBar.searchActive = true
            }
            
            
            withAnimation{
                self.hasContent = !self.vm.apiList.triplist.isEmpty
                self.vm.searchBar.searchActive = true
                if (self.hasContent){
                    self.nothingloaded = false
                } else{
                    self.nothingloaded = true
                }
            }
            
        }
    }
    
    func check() -> Bool{
//        if self.vm.searchBar.Date1.addingTimeInterval(60*60*24*3) >=  self.vm.searchBar.Date2 {
//
//            return false;
//        }
        if (self.budget*1000) < 1000 {
            return false
        }
//        let airportCodeList = self.vm.searchBar.lpvm.airportList.map { airport in
//            return airport.code
//        }
//        if airportCodeList.contains(self.vm.searchBar.lpvm.selected)  {
//            return false
//        }
        return true
    }

    var body: some View {
		ZStack(alignment: .topTrailing){
            
			
				TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset){
					Spacer()
					TopBarView(vm:self.vm.searchBar,
					searchAction: {
						
						//print("______________________\n\(self.vm.searchBar.budget)")
						
						
						
                        if ( self.check()){
                            print("search ok")
                            withAnimation{
                                self.vm.searchBar.searchActive = false
                            }
                            self.load()
                        } else{
                            print("search bad")
                        }
						
						
						
					}, favouriteAction: {
						withAnimation(){
							self.vm.isFavContent = true
						}
					}).frame(height: (self.hasContent || self.nothingloaded) ? 390 : UIApplication.screenHeight).disabled(self.isLoading)
					
					if(!self.vm.apiList.triplist.isEmpty && !self.vm.isFavContent){
						
							ForEach(self.vm.apiList.triplist, id: \.self){ tripM in
									TripRowView(vm: self.vm,tripInfo: tripM)
							}
						
					}
					if(self.nothingloaded){
						VStack{
							Spacer()
							Text("Маршруты не найдены.\nпоменяйтя парметры запроса.").multilineTextAlignment(.center).font(.title)
                            .onAppear {
                                Timer(timeInterval: 10000, repeats: false) { (timer) in
                                    self.nothingloaded = false
                                    print("timer")
                                }.fire()
                            }
							Spacer()
						}
						
					}
					
					
					
					
				
				
			}
			
			
			if(self.offset > 350){
				withAnimation{
				HStack(spacing:10){

					Button(action: {

						withAnimation(){
							self.vm.isFavContent = true
						}

					}){
						Image(systemName: "star.circle").resizable().frame(width: 50, height: 50).foregroundColor(.kirillGray).padding(5).background(LinearGradient(gradient: .favouriteBG, startPoint: .top, endPoint: .bottom)).cornerRadius(100).shadow(radius: 10)
					}

				}.padding(15).animation(.linear)
				}
			}
            if self.isLoading{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        LoadAnimation()
                        Spacer()
                    }
                    Spacer()
                }
            }
            
			
		}.frame(width: UIApplication.screenWidth)
		.alert(isPresented: self.$loadErr){
			Alert(title:self.vm.apiList.error == APIListLoadError.networkError ? Text("Ошибка подключения") : Text("Ошибка загрузки"),
				  message:self.vm.apiList.error == APIListLoadError.networkError ?  Text("Не удалось получить данные с сервера.") : Text("Некорректный ответ сервера. Повторите попытку позже."), dismissButton: nil)
		}

        
		
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
		SearchPageView(vm: AppVM())
    }
}
