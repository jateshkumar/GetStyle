//
//  MapView.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 12/10/2022.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Map here")
                ZStack(alignment: .bottom) {
                    Color(.white)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewRouter: ViewRouter())
    }
}
