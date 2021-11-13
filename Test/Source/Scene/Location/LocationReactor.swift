//
//  LocationReactor.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import ReactorKit
import RxFlow
import RxCocoa

final class LocationReactor: Reactor, Stepper{
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    // MARK: Step
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    enum Action{
        case loadTemp
    }
    enum Mutation{
        case setTemp(_ temp:String)
    }
    struct State{
        var temp: String?
    }
    
    let initialState: State
    
    init(){
        self.initialState = State()
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        
        case .loadTemp:
            return fetchTemp()
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var new = state
        
        switch mutation{
        case .setTemp(let temp):
            new.temp = temp
        }
        
        return new
    }
    func fetchTemp() -> Observable<Mutation>{
        return NetworkManager.shared.fetchTemp()
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(Temp.self)
            .map{$0.temp}
            .map{ Mutation.setTemp($0) }
    }
}
