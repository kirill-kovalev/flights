//
//  TrackableScrollView.swift
//  flightApp
//
//  Created by Кирилл on 12.04.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI

struct TrackableScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showIndicators: Bool
    let maxIndex:Int
    
    @Binding var index: Int
    @Binding var contentOffset: CGFloat
    
    @State private var isGestureActive: Bool = false
    let content: Content
    
    var screenWidth:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!}
    var screenHeight:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.height)!}
    
    
    init(_ axes: Axis.Set = .horizontal, showIndicators: Bool = true,maxIndex:Int,index:Binding<Int>, contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        self._contentOffset = contentOffset
        self.content = content()
        self._index = index
        self.maxIndex = maxIndex
    }
    

    var body: some View {
        GeometryReader { outsideProxy in
            
            ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                GeometryReader { insideProxy in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
                        // Send value to the parent
                }
                HStack {
                    self.content
                }
                }.padding(0)
            .offset(x: self.isGestureActive ? self.contentOffset : CGFloat(self.index) * (-self.screenWidth - 8) )
            .frame(width: outsideProxy.size.width, alignment: .leading).padding(0)
                .gesture(DragGesture(minimumDistance: 50, coordinateSpace:.local).onChanged({ value in
                // 4
                
                self.isGestureActive = true
                self.contentOffset = value.translation.width + -self.screenWidth * CGFloat(self.index)
                
            }).onEnded({ value in
                
                if -value.predictedEndTranslation.width > self.screenWidth / 5, self.index < self.maxIndex {
                    self.index += 1
                }
                if value.predictedEndTranslation.width > self.screenWidth / 5, self.index > 0 {
                    self.index -= 1
                }
                
                withAnimation { self.contentOffset = (-self.screenWidth ) * CGFloat(self.index) - 8 }
                
                DispatchQueue.main.async { self.isGestureActive = false }
            }))
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.contentOffset = value[0]
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
    private func calculateHeight(offset:CGFloat) -> CGFloat {
        
        if offset > screenWidth {
            return  screenHeight
        }else{
            let coef = -1 * offset / screenWidth
            let height = (screenHeight - 468 ) * coef
            if height > 0{
                return 468 + height
            } else {
                return 468
            }
            
            
        }
    }
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]
    
    static var defaultValue: [CGFloat] = [0]
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}



