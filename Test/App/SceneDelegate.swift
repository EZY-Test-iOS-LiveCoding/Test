//
//  SceneDelegate.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator: FlowCoordinator = .init()
    private let disposeBag: DisposeBag = .init()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let s = (scene as? UIWindowScene) else { return }
        coordinatorLogger()
        coordinateToAppFlow(with: s)
    }

    private func coordinatorLogger() {
        coordinator.rx.willNavigate
            .subscribe(onNext: { flow, step in
                let currentFlow = "\(flow)".split(separator: ".").last ?? "no flow"
                print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
            })
            .disposed(by: disposeBag)
        
    }
    
    private func coordinateToAppFlow(with windowScene: UIWindowScene){
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let appFlow = AppFlow(with: window)
        let appStepper = AppStepper()
        
        coordinator.coordinate(flow: appFlow, with: appStepper)
        window.makeKeyAndVisible()
    }

}

