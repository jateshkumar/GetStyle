//
//  Slider.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 09/10/2022.
//

import SwiftUI

struct Slider<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(
        spacing: CGFloat = 15,
        trailingSpace: CGFloat = 100,
        index: Binding<Int>,
        items: [T],
        @ViewBuilder content: @escaping (T) -> Content) {
            self.list = items
            self.spacing = spacing
            self.trailingSpace = trailingSpace
            self._index = index
            self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 1
    
    var body: some View {
        GeometryReader { proxy in
            let width = (proxy.size.width - (trailingSpace - spacing))
            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + adjustmentWidth + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        // Updating current index...
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        currentIndex = index
                    })
                    .onChanged({ value in
                        // Updating current index...
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}


struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
