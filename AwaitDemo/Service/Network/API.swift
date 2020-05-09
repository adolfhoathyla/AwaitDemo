//
//  API.swift
//  AwaitDemo
//
//  Created by Adolfho Athyla de Almeida Beserra on 09/05/20.
//  Copyright © 2020 Adolfho Athyla de Almeida Beserra. All rights reserved.
//

import Foundation
import Moya

enum API {
    case login(
        username: String,
        password: String
    )
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .login(_, _):
            return URL(string: "http://www.mocky.io/v2")!
        }
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "/5eb6d7e23100000d00c8a069"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_, _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login(_, _):
            return [
                "Content-type": "application/json"
            ]
        }
    }
    
    
}
