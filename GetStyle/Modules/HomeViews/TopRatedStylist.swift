//
//  TopRatedStylist.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 05/11/2022.
//

import SwiftUI

struct TopRatedStylist: View {
    var userData: [StylistModel] = [
        .init(id: 0, image: ImagesConstants.tabbar.profile, firstName: "Jatesh", lastName: "Kumar", experties: ["Manicure", "Pedicure", "Hair Styling", "Facial"]),
        .init(id: 1, image: ImagesConstants.tabbar.profile, firstName: "Asad", lastName: "Ali", experties: ["HAirfall", "Pedicure", "Hair Styling", "Kajal"]),
        .init(id: 2, image: ImagesConstants.tabbar.profile, firstName: "Jatesh", lastName: "Kumar", experties: ["Manicure", "Pedicure", "Hair Styling", "Facial"]),
        .init(id: 3, image: ImagesConstants.tabbar.profile, firstName: "Jatesh", lastName: "Kumar", experties: ["Manicure", "Pedicure", "Hair Styling", "Facial"]),
        .init(id: 4, image: ImagesConstants.tabbar.profile, firstName: "Jatesh", lastName: "Kumar", experties: ["Manicure1", "Pedicure1", "Hair Styling1", "Facial1", "Manicure2", "Pedicure2", "Hair Styling2", "Facial2", "Manicure3", "Pedicure3", "Hair Styling3", "Facial3"]),
        .init(id: 5, image: ImagesConstants.tabbar.profile, firstName: "Jatesh", lastName: "Kumar", experties: ["Manicure", "Pedicure", "Hair Styling", "Facial"])
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(userData, id: \.self) { user in
                UserListView(user: user)
            }
        }
        .padding(20)
        .background(Color(hex: "f0f1f0"))
    }
}

struct TopRatedStylist_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedStylist()
    }
}


struct UserListView: View {
    let user: StylistModel
    
    var body: some View {
        
        HStack {
            Image(user.image)
                .resizable()
                .cornerRadius(25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 5) {
                Text(user.firstName + " " + user.lastName)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                let expertise = user.experties.map{String($0)}.joined(separator: ", ")
                
                Text(expertise)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(5)
    }
}

struct StylistModel: Hashable {
    var id: Int
    var image: String
    var firstName: String
    var lastName: String
    var experties: [String]
}
