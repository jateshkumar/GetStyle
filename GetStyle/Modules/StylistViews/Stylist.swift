//
//  Stylist.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 09/10/2022.
//

import SwiftUI

struct Stylist: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Stylist here")
                ZStack(alignment: .bottom) {
                    Color(.white)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Stylist")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
