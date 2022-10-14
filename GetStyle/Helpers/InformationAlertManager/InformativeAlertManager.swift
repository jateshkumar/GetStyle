//
//  InformativeAlertManager.swift
//  Orko
//
//  Created by Jatesh Kumar Maheshwari on 15/08/2022.
//

import Foundation
import SwiftMessages

class InformativeAlertManager {
    func serverErrors(title: String, message: String) {
        DispatchQueue.main.async {

            let view = MessageView.viewFromNib(layout: .cardView)

            var config = SwiftMessages.Config()
            view.configureTheme(backgroundColor: UIColor.red,
                                foregroundColor: UIColor.black,
                                iconImage: UIImage(named: "warning"),
                                iconText: nil)

//            view.iconImageView?.setOverlay(withColor: UIColor.black)

            view.configureContent(title: title,
                                  body: message)

            view.button?.isHidden = true

            view.tapHandler = { _ in SwiftMessages.hide() }

            // Slide up from the bottom.
            config.presentationStyle = .top

            // Display in a window at the specified window level: UIWindow.Level.statusBar
            // displays over the status bar while UIWindow.Level.normal displays under.
            config.presentationContext = .window(windowLevel: .statusBar)

            // Disable the default auto-hiding behavior.
            //        config.duration = .automatic
            config.duration = .seconds(seconds: 5.0)

            // Dim the background like a popover view. Hide when the background is tapped.
            config.dimMode = .gray(interactive: true)

            // Disable the interactive pan-to-hide gesture.
            config.interactiveHide = true

            // Specify a status bar style to if the message is displayed directly under the status bar.
            config.preferredStatusBarStyle = .lightContent

            // Specify one or more event listeners to respond to show and hide events.
            config.eventListeners.append { event in
                if case .didHide = event { print("yep") }
            }

            SwiftMessages.show(config: config, view: view)
        }
    }
    
    func noInternetConnectionPopUp() {
        DispatchQueue.main.async {

            let title = "No Internet Connection"
            let message = "Please verify you are connected to wifi or cellular network"

            let view = MessageView.viewFromNib(layout: .cardView)

            var config = SwiftMessages.Config()
            view.configureTheme(backgroundColor: UIColor.red,
                                foregroundColor: UIColor.black,
                                iconImage: UIImage(named: "snoWifi"), iconText: nil)

//            view.iconImageView?.setOverlay(withColor: UIColor.black)

            view.configureContent(title: title,
                                  body: message)

            view.button?.isHidden = true

            view.tapHandler = { _ in SwiftMessages.hide() }

            // Slide up from the bottom.
            config.presentationStyle = .top

            // Display in a window at the specified window level: UIWindow.Level.statusBar
            // displays over the status bar while UIWindow.Level.normal displays under.
            config.presentationContext = .window(windowLevel: .alert)

            // Disable the default auto-hiding behavior.
            //        config.duration = .automatic
            config.duration = .seconds(seconds: 5.0)

            // Dim the background like a popover view. Hide when the background is tapped.
            config.dimMode = .gray(interactive: true)

            // Disable the interactive pan-to-hide gesture.
            config.interactiveHide = true

            // Specify a status bar style to if the message is displayed directly under the status bar.
            config.preferredStatusBarStyle = .lightContent

            // Specify one or more event listeners to respond to show and hide events.
            config.eventListeners.append { event in
                if case .didHide = event { print("yep") }
            }

            SwiftMessages.show(config: config, view: view)
        }
    }
}
