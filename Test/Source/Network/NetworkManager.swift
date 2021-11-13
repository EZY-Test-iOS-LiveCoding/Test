//
//  NetworkManager.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import RxSwift
import Moya

protocol NetworkManagerType: class{
    var provider: MoyaProvider<HanAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    var provider: MoyaProvider<HanAPI>
    
    private let disposeBag: DisposeBag = .init()
    
    init(provider: MoyaProvider<HanAPI> = .init()){
        self.provider = provider
    }
    
    func fetchTemp() -> Single<Response>{
        return self.provider.rx.request(.getCurrentTemp, callbackQueue: .main)
    }
}
