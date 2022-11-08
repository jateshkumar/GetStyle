//
//  TopServices.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 03/11/2022.
//

import SwiftUI

struct TopServices: View {
    
    var services: [ServicesList] = [
        .init(id: 0, serviceName: "Service Name 1", serviceIcon: ImagesConstants.tabbar.profile),
        .init(id: 0, serviceName: "Service Name Here", serviceIcon: ImagesConstants.tabbar.stylist),
        .init(id: 0, serviceName: "Service Name there", serviceIcon: ImagesConstants.tabbar.saloon),
        .init(id: 0, serviceName: "No Name 1", serviceIcon: ImagesConstants.tabbar.profile),
        .init(id: 0, serviceName: "Service Ser Here", serviceIcon: ImagesConstants.tabbar.profile),
        .init(id: 0, serviceName: "VICE Name Here", serviceIcon: ImagesConstants.tabbar.profile)]
    @State var selected: Int?
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(services, id: \.self) { service in
                    ListView(serviceList: service)
                }
            }
        }
        
        .padding(15)
        .background(Color(hex: "f0f1f0"))
    }
}

struct TopServices_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

struct ListView: View {
    let serviceList: ServicesList
    @State var initialImage = UIImage()
    var body: some View {
        VStack {
            Image(serviceList.serviceIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: 70, height: 70)
                .background(Color(hex: "9aa659"))
                .cornerRadius(20)
            
            Text(serviceList.serviceName)
                .font(.system(size: 15))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(width: 70, height: 120)
        .padding(5)
    }
}

struct ServicesList: Hashable {
    var id: Int
    var serviceName: String
    var serviceIcon: String
}
