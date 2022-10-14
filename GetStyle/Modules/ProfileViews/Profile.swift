//
//  Profile.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 12/10/2022.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile here")
                ZStack(alignment: .bottom) {
                    Color(.white)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(viewRouter: ViewRouter())
    }
}
