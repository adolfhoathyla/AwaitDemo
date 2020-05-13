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
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailSentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //callbacks
        provider.login(username: "goku", password: "goku123", disposeBag: disposeBag) { [weak self] (user) in
            guard let weakself = self else { return }
            guard let user = user else { return }
            weakself.setUser(user: user)
            print("Objeto \(user) setado com sucesso")

            weakself.provider.sendEmail(user: user, disposeBag: weakself.disposeBag) { (sendEmail) in
                guard let sendEmail = sendEmail else { return }
                weakself.emailSent(sendEmail: sendEmail)
                print("E-mail enviado com sucesso!")
            }
        }
        
        //promises
        async { [weak self] in
            guard let weakself = self else { return }
            let user = try! await(weakself.provider.login(username: "goku", password: "goku123", disposeBag: weakself.disposeBag))
            weakself.setUser(user: user)
            print("Objeto \(user) setado com sucesso")
            
            let sendEmail = try! await(weakself.provider.sendEmail(user: user, disposeBag: weakself.disposeBag))
            weakself.emailSent(sendEmail: sendEmail)
            print("E-mail enviado com sucesso!")
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
    
    private func emailSent(sendEmail: SendEmail) {
        DispatchQueue.main.async { [weak self] in
            guard let weakself = self else { return }
            weakself.emailIcon.isHidden = !sendEmail.success
            weakself.emailSentLabel.isHidden = !sendEmail.success
        }
    }
}

