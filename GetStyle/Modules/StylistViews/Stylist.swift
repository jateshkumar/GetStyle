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
                TopRatedStylist()
                Spacer()
            }
            .background(Color(hex: "f0f1f0"))
            .navigationTitle("Stylist")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


struct Stylist_Previews: PreviewProvider {
    static var previews: some View {
        Stylist(viewRouter: ViewRouter())
    }
}
