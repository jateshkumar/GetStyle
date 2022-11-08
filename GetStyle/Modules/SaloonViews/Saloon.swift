//
//  Saloon.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 12/10/2022.
//

import SwiftUI

struct Saloon: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @State var selectedSaloon: SaloonsModel?
    
    var saloons: [SaloonsModel] = [
        .init(id: 0, name: "Saloon 1", image: "1"),
        .init(id: 1, name: "Saloon 2", image: "2"),
        .init(id: 2, name: "Saloon 3", image: "3"),
        .init(id: 3, name: "Saloon 4", image: "2"),
        .init(id: 4, name: "Saloon 5", image: "1")
    ]
    
    var body: some View {
        NavigationView {
            List(saloons, id: \.self, selection: $selectedSaloon) { saloon in
                SaloonView(saloon: saloon)
                    .listRowBackground(Color(.clear))
            }
            .listStyle(.plain)
            .navigationTitle("Saloon")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SaloonView: View {
    @State var saloon: SaloonsModel
    
    var myGradient = Gradient(
        colors: [
            Color(.systemTeal),
            Color(.systemPurple)
        ]
    )
    
    var body: some View {
        VStack() {
            Image(saloon.image)
                .resizable()
                .frame(height: 200)
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
            Text(saloon.name)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Saloon Specialities, Manicure, Pedicure, Hair styling, Shampoo, Cooling")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding(10)
        .border(.linearGradient(.init(colors: [Color(hex: "#415d59"), Color(hex: "#9aa659"), Color(hex: "#47684f"), Color(hex: "#FFFFFF")]), startPoint: .topLeading, endPoint: .bottomTrailing), width: 5)
//        .border(, width: 10)
        .cornerRadius(12)
    }
}


struct Saloon_Previews: PreviewProvider {
    static var previews: some View {
        Saloon(viewRouter: ViewRouter())
    }
}

struct SaloonsModel: Hashable {
    var id: Int
    var name: String
    var image: String
}
