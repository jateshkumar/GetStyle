//
//  Slider.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 09/10/2022.
//

import SwiftUI

struct Slider: View {
    
    private let slides = ["1", "2", "3"]
    
    var body: some View {
        VStack() {
            TabView {
                ForEach(slides, id: \.self) {slide in
                    Image(slide)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(.page)
            .cornerRadius(20)
            .shadow(color: .black, radius: 10)
        }
        .padding(20)
        .frame(height: 300)
    }
}
