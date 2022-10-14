//
//  Saloon.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 12/10/2022.
//

import SwiftUI

struct Saloon: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Saloon here")
                ZStack(alignment: .bottom) {
                    Color(.white)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Saloon")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Saloon_Previews: PreviewProvider {
    static var previews: some View {
        Saloon(viewRouter: ViewRouter())
    }
}
