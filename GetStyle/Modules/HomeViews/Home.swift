//
//  Home.swift
//  GetStyle
//
//  Created by Jatesh Kumar Maheshwari on 29/09/2022.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @State var currentIndex: Int = 1
    @State var slides: [SliderModel] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Slider(index: $currentIndex, items: slides) { slide in
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Image(slide.slideImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width)
                            .cornerRadius(12)
                            .shadow(color: Color(hex: "#47684f") .opacity(0.7), radius: 5, x: 0, y: 10)
                    }
                }
                .frame(height: 200, alignment: .top)
                .onAppear {
                    for index in 1...3 {
                        slides.append(.init(slideImage: "\(index)"))
                    }
                }
                .padding(.vertical, 20)
                
                HStack(spacing: 10) {
                    ForEach(slides.indices, id: \.self) { index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1: 0.1))
                            .frame(width: 10, height: 10)
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
                
                Spacer()
                
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}


struct SliderModel: Identifiable {
    var id = UUID().uuidString
    var slideImage: String
}
