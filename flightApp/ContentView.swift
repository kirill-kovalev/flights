//
//  ContentView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI


struct ContentView: View {
	init() {
		let model = APIListModel()
		model.load()
		print(model.triplist)
	}
    
    @State var index:Int = 0
	
	@State var isFavContent:Bool = false
	
	
    var body: some View {
        
		HStack(spacing:0){
			
		
			SearchPageView(isFavContent: $isFavContent)
			FavPageView(isFavContent: $isFavContent)
			

		}.offset(x: self.isFavContent ? -1 * UIApplication.screenWidth / 2 : UIApplication.screenWidth / 2 )
			.edgesIgnoringSafeArea(.bottom).padding(.top,-10)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
