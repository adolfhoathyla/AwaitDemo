//
//  Networkable.swift
//  AwaitDemo
//
//  Created by Adolfho Athyla de Almeida Beserra on 09/05/20.
//  Copyright © 2020 Adolfho Athyla de Almeida Beserra. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import PromiseKit

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    
     func login(username: String,
                  password: String,
                  disposeBag: DisposeBag) -> Promise<User>
}
