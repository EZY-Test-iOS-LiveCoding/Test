//
//  MainFlow.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import UIKit
import RxFlow
import RxRelay

struct MainStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return HanStep.MainIsRequired
    }
}

final class MainFlow: Flow{
    // MARK: - Properties
    
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: MainStepper
    private let rootVC = UINavigationController()
    
    
    // MARK: - Init
    init(stepper: MainStepper){
        self.stepper = stepper
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asHanStep else {return .none}
        switch step{
        case .MainIsRequired:
            return coordinateToMainVC()
        default:
            return .none
        }
    }
    
    private func coordinateToMainVC() -> FlowContributors{
        let reactor = MainReactor()
        let vc = MainVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
