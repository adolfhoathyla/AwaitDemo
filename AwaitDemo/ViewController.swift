//
//  ViewController.swift
//  AwaitDemo
//
//  Created by Adolfho Athyla de Almeida Beserra on 09/05/20.
//  Copyright © 2020 Adolfho Athyla de Almeida Beserra. All rights reserved.
//

import UIKit
import RxSwift
import AwaitKit
import PromiseKit

class ViewController: UIViewController {

    let provider: Networkable = NetworkManager()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        async { [weak self] in
            guard let weakself = self else { return }
            let user = try! await(weakself.signIn(username: "goku", password: "goku123"))
            weakself.setUser(user: user)

            print("Objeto \(user) setado com sucesso!")
        }

    }
    
    // MARK: - Layout
    private func setUser(user: User) {
        DispatchQueue.main.async { [weak self] in
            guard let weakself = self else { return }
            weakself.nameLabel.text = user.name
            weakself.emailLabel.text = user.email
        }
    }
    
    // MARK: - Request
    private func signIn(username: String, password: String) -> Promise<User> {
        provider.login(username: username, password: password, disposeBag: disposeBag)
    }


}

