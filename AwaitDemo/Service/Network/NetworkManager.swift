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
    
    func sendEmail(user: User,
                   disposeBag: DisposeBag) -> Promise<SendEmail> {
        return Promise<SendEmail> { sendEmail in
            provider.rx.request(.sendEmail(user: user)).map(SendEmail.self).subscribe { (event) in
                switch event {
                case .success(let response):
                    sendEmail.fulfill(response)
                case .error(let error):
                    sendEmail.reject(error)
                }
            }.disposed(by: disposeBag)
            
        }
    }
    
    func login2(username: String, password: String, disposeBag: DisposeBag, completion: @escaping ((User?) -> ())) {
        provider.rx.request(.login(username: username, password: password)).map(User.self).subscribe { (event) in
            switch event {
            case .success(let response):
                completion(response)
            case .error(_):
                completion(nil)
            }
        }.disposed(by: disposeBag)
    }
    
    func sendEmail2(user: User, disposeBag: DisposeBag, completion: @escaping ((SendEmail?) -> ())) {
        provider.rx.request(.sendEmail(user: user)).map(SendEmail.self).subscribe { (event) in
            switch event {
            case .success(let response):
                completion(response)
            case .error(_):
                completion(nil)
            }
        }.disposed(by: disposeBag)
    }
    
}
