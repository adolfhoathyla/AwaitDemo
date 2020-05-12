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
    case sendEmail(
        user: User
    )
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .login(_, _),
             .sendEmail(_):
            return URL(string: "http://www.mocky.io/v2")!
        }
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "/5eb6d7e23100000d00c8a069"
        case .sendEmail(_):
            return "/5ebb0ec03600006400f7e521"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_, _),
             .sendEmail(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(_, _),
             .sendEmail(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login(_, _),
             .sendEmail(_):
            return [
                "Content-type": "application/json"
            ]
        }
    }
    
    
}
