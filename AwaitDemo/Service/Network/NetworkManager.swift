//
//  NetworkManager.swift
//  AwaitDemo
//
//  Created by Adolfho Athyla de Almeida Beserra on 09/05/20.
//  Copyright © 2020 Adolfho Athyla de Almeida Beserra. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import PromiseKit

class NetworkManager: Networkable {
    var provider: MoyaProvider<API> = MoyaProvider<API>()
    
    func login(username: String,
               password: String,
               disposeBag: DisposeBag) -> Promise<User> {
        return Promise<User> { user in
            provider.rx.request(.login(username: username, password: password)).map(User.self).subscribe { (event) in
                switch event {
                case .success(let response):
                    user.fulfill(response)
                case .error(let error):
                    user.reject(error)
                }
            }.disposed(by: disposeBag)
        }
    }
    
}
