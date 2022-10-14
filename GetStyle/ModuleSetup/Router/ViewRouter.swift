//
//  ViewRouter.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 11/10/2022.
//

import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    var viewStack: [Routes] = []
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()

    var currentPage: Routes = .home {
        willSet(newValue) {
            if currentPage != newValue, previousPage != currentPage {
                if previousPage != newValue {
                    previousPage = currentPage
                    viewStack.append(previousPage)
                } else {
                    viewStack.removeAll(where: { $0 == newValue })
                    previousPage = currentPage
                    viewStack.append(previousPage)
                }
            }
        }
        didSet {
            objectWillChange.send(self)
        }
    }

    var previousPage: Routes = .none {
        didSet {
            objectWillChange.send(self)
        }
    }

    func goBack() {
        if previousPage != .none {
            currentPage = previousPage

            if !viewStack.isEmpty {
                viewStack.removeLast()
            }

            if !viewStack.isEmpty {
                previousPage = viewStack[viewStack.endIndex - 1]
            }
        }
    }

    func trashStack() {
        viewStack = []
    }
    func removeReference(ref: Routes) {
        viewStack.removeAll(where: { $0 == ref })
    }
    func setCurrentPageWithRemoveReference(addRef: Routes, removeRef: Routes) {
        currentPage = addRef
        removeReference(ref: removeRef)
        previousPage = viewStack[viewStack.count - 1]
    }
}

struct getTheView: View {
    // @ObservedObject var textFieldManager = TextFieldManager()
    @State var showMenu: Bool = false
   
    @ObservedObject var viewRouter: ViewRouter
    var requestSuccessful: Bool = false
    
    var body: some View {
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
        case .none:
            EmptyView()
        }
    }
}

enum Routes {
    case home
    case map
    case stylist
    case saloons
    case profile
    case none
}
