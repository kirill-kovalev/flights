//
//  ContentView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var offset:CGFloat = 0;
    @State var index:Int = 0
    var body: some View {
        
//            TrackableScrollView(.vertical,maxIndex: 4, index: $index, contentOffset: $offset){
		ScrollView(.vertical){
			VStack{
				ForEach((0...3),id:\.self)
				{ id in
					TripRowView()
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
