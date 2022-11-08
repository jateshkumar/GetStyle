//
//  ContentView.swift
//  GetStyle
//
//  Created by Jatesh Kumar Maheshwari on 29/09/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Environment(\.window) var window: UIWindow?
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                switch viewRouter.currentPage {
                case .home:
                    Home(viewRouter: viewRouter)
                case .map:
                    MapView(viewRouter: viewRouter)
                case .stylist:
                    Stylist(viewRouter: viewRouter)
                case .saloons:
                    Saloon(viewRouter: viewRouter)
                case .profile:
                    Profile(viewRouter: viewRouter)
                default:
                    EmptyView()
                }
                
                ZStack {
                    CustomTabbar(viewRouter: viewRouter)
                        .offset(y: geometry.size.height/8/8)
                }
            }
            .background(Color(hex: "f0f1f0"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

struct WindowKey: EnvironmentKey {
  struct Value {
    weak var value: UIWindow?
  }

  static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
  var window: UIWindow? {
    get { return self[WindowKey.self].value }
    set { self[WindowKey.self] = .init(value: newValue) }
  }
}

