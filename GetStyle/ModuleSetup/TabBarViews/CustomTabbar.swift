//
//  CustomTabbar.swift
//  GetStyle
//
//  Created by Jatesh Kumar Maheshwari on 29/09/2022.
//

import SwiftUI

struct CustomTabbar: View {
    @StateObject var viewRouter: ViewRouter
    
    // Storing Each Tab Mid Point To Use For Selected
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            TabbarButton(image: ImagesConstants.tabbar.home, currentTab: .home, viewRouter: viewRouter, tabPoints: $tabPoints)
            TabbarButton(image: ImagesConstants.tabbar.location, currentTab: .map, viewRouter: viewRouter, tabPoints: $tabPoints)
            TabbarButton(image: ImagesConstants.tabbar.stylist, currentTab: .stylist, viewRouter: viewRouter, tabPoints: $tabPoints)
            TabbarButton(image: ImagesConstants.tabbar.saloon, currentTab: .saloons, viewRouter: viewRouter, tabPoints: $tabPoints)
            TabbarButton(image: ImagesConstants.tabbar.profile, currentTab: .profile, viewRouter: viewRouter, tabPoints: $tabPoints)
            
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.init(hex: "#47684f"), Color.init(hex: "#9aa659")]), startPoint: .leading, endPoint: .trailing)
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        
        .cornerRadius(5)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .shadow(color: Color.gray, radius: 2)
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch viewRouter.currentPage {
            case .profile:
                return tabPoints[0]
            case .saloons:
                return tabPoints[1]
            case .stylist:
                return tabPoints[2]
            case .map:
                return tabPoints[3]
            case .home:
                return tabPoints[4]
            default:
                return tabPoints[0]
                
            }
        }
    }
}

struct TabbarButton: View {
    var image: String
    var currentTab: Routes
    
    @StateObject var viewRouter: ViewRouter
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        // Getting mid point of each button
        GeometryReader { reader -> AnyView in
            
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count < 6 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    // Changing Tab
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        viewRouter.currentPage = currentTab
                    }
                    
                }) {
                    Image(image)
                        .renderingMode(.template)
                        .colorMultiply(viewRouter.currentPage == currentTab ? Color(.white): Color.black)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: viewRouter.currentPage == currentTab ? 50 : 40, height: viewRouter.currentPage == currentTab ? 50 : 40)
                        .font(.system(size: viewRouter.currentPage == currentTab ? 25 : 20, weight: .semibold))
                        .foregroundColor(viewRouter.currentPage == currentTab ? Color(.white): Color.black)
                    
                        .background(viewRouter.currentPage == currentTab ? Color.init(hex: "#47684f") : Color.white)
                        
                        .cornerRadius(viewRouter.currentPage == currentTab ? 25 : 20)
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: viewRouter.currentPage == currentTab ? -10 : 5)
                .shadow(color: Color.init(hex: "#47684f"), radius: viewRouter.currentPage == currentTab ? 1 : 0, x: 0, y: 0)
            )
            
        }
        .frame(height: 45)
    }
    
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
