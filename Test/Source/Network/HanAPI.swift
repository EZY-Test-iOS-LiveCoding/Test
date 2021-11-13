//
//  HanAPI.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import Moya

enum HanAPI{
    case getCurrentTemp
}

extension HanAPI: TargetType{
    var baseURL: URL {
        URL(string: "https://api.hangang.msub.kr")!
    }
    
    var path: String {
        switch self{
        case .getCurrentTemp:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getCurrentTemp:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getCurrentTemp:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
