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
    
    //var screenWidth:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!}
    //var screenHeight:CGFloat { return (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.height)!}
    
    var size:CGSize = CGSize(width: (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width)!,
                             height:468/*(UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.height)!*/)
//    mutating func elementSize(size:CGSize) {
//        self.size = size
//    }
//
//    mutating func elementSize(height:CGFloat? = nil, width:CGFloat? = nil) {
//        size = CGSize(width: height ??  size.height,height: width ?? size.width)
//    }
//
    
    init(_ axes: Axis.Set = .horizontal, showIndicators: Bool = true,maxIndex:Int,index:Binding<Int>, contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        self._contentOffset = contentOffset
        self.content = content()
        self._index = index
        self.maxIndex = maxIndex
    }
    
    var xOffset:CGFloat {self.isGestureActive ? self.contentOffset : CGFloat(self.index) * (-self.size.width)}
    var yOffset:CGFloat {self.isGestureActive ? self.contentOffset : CGFloat(self.index ) * (-self.size.height)}

    var body: some View {
        GeometryReader { outsideProxy in
            
            ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                GeometryReader { insideProxy in
                    Color.clear.padding(0)
                    .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
                }.padding(0)
                if self.axes == .vertical {
                    VStack(spacing:30) {self.content}
                }else{
                    HStack(spacing:0) {self.content}
                }
               
                
            }.padding(0)
                .offset(x: (self.axes != .vertical) ? self.xOffset : 0,
                        y: (self.axes == .vertical) ? self.yOffset : 0 )
            .frame(width: outsideProxy.size.width, alignment: .leading).padding(0)
            .gesture(
                DragGesture(minimumDistance:(self.axes == .vertical) ? 10 : 50, coordinateSpace:(self.axes == .vertical) ? .global :.local)
                .onChanged({ value in
                    
                    self.isGestureActive = true
                    if self.axes == .vertical {
                        self.contentOffset = value.translation.height + -self.size.height * CGFloat(self.index)
                    }else{
                        self.contentOffset = value.translation.width + -self.size.width * CGFloat(self.index)
                    }
                    
                })
                .onEnded({ value in
                    if self.axes == .vertical {
                        if -value.predictedEndTranslation.height > self.size.height / 3, self.index < self.maxIndex {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.height > self.size.height / 3, self.index > 0 {
                            self.index -= 1
                        }
                        
                        withAnimation { self.contentOffset = (-self.size.height ) * CGFloat(self.index) }
                    } else {
                        if -value.predictedEndTranslation.width > self.size.width / 3, self.index < self.maxIndex {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.width > self.size.width / 3, self.index > 0 {
                            self.index -= 1
                        }
                        
                        withAnimation { self.contentOffset = (-self.size.width ) * CGFloat(self.index) }
                        
                    }
                    
                    DispatchQueue.main.async { self.isGestureActive = false }
                })
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self){ value in
                self.contentOffset = value[0]
            }
        }.padding(0).frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
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



