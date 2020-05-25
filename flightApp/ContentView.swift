//
//  ContentView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

class AppVM: ObservableObject {
    @Published var favouriteList = favouriteListModel();
    @Published var apiList = APIListModel()
	@Published var searchBar = TopBarVM()
    @Published var isFavContent:Bool = false
    @State var hasAPIContent = false
	
    init() {
        self.apiList.loadCompletion = { _ in
            
            self.hasAPIContent = !self.apiList.triplist.isEmpty
        }
    }
}


struct ContentView: View {
	

    @State var index:Int = 0

	@ObservedObject var appVm:AppVM;
	
    var body: some View {
        
		HStack(spacing:0){
			
		
            SearchPageView(vm: self.appVm)
            FavPageView(vm: self.appVm)
			
			

		}.offset(x:  self.appVm.isFavContent ? -1 * UIApplication.screenWidth / 2 : UIApplication.screenWidth / 2 )
			.edgesIgnoringSafeArea(.bottom).padding(.top,-10)
			.gesture(TapGesture().onEnded({
				UIApplication.shared.endEditing()
			}))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(appVm: AppVM())
    }
}
