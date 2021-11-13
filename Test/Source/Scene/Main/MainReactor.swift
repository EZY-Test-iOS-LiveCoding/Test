//
//  MainReactor.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import ReactorKit
import RxCocoa
import RxFlow

final class MainReactor: Reactor, Stepper{
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    // MARK: Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    enum Action{
        case loadTemp
        case locationDidTap
    }
    enum Mutation{
        case setTemp(_ temp: String)
    }
    
    struct State{
        var temp: String?
    }
    
    let initialState: State
    init(){
        self.initialState = State()
    }
    
}

// MARK: - Extensions

// MARK: Mutation
extension MainReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .loadTemp:
            return fetchTemp()
        default:
            return .empty()
        }
    }
}

// MARK: Reduce
extension MainReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        
        switch mutation{
        case .setTemp(let temp):
            new.temp = temp
        }
        
        return new
    }
}

// MARK: Method
private extension MainReactor{
    func fetchTemp() -> Observable<Mutation>{
        return NetworkManager.shared.fetchTemp()
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(Temp.self)
            .map{$0.temp}
            .map{ Mutation.setTemp($0) }
    }
}
