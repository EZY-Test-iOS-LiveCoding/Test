//
//  AppFlow.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import RxSwift
import RxCocoa
import RxFlow

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    func readyToEmitSteps() {
        steps.accept(HanStep.MainIsRequired)
    }
}
final class AppFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.window
    }
    
    private let window: UIWindow
    
    init(with window: UIWindow){
        self.window = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asHanStep else { return .none }
        switch step{
        case .MainIsRequired:
            return coordinateToMainVC()
        default:
            return .none
        }
    }
    
    private func coordinateToMainVC() -> FlowContributors{
        let flow = MainFlow(stepper: .init())
        Flows.use(flow, when: .created) { [unowned self] root in
            window.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: HanStep.MainIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
}
