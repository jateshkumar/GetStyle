//
//  Home.swift
//  GetStyle
//
//  Created by Jatesh Kumar Maheshwari on 29/09/2022.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @State var selectedTab = "house"
    
    var body: some View {
        NavigationView {
            VStack {
                Slider()
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

