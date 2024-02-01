//
//  SetPinCodeViewController.swift
//  Commeta
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 10/01/24.
//

import UIKit

class SetPinCodeViewController: BaseViewController<SetPinCodePresenter> {
    
    lazy var viewControllerView: SetPinCodeView? = {
        return (view as? SetPinCodeView)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func pinCodeButtonsTapped(_ sender: UIButton) {
        presenter.pinCodeAction(sender: sender)
    }
}

extension SetPinCodeViewController: SetPinCodePresenterView {
    
}

extension SetPinCodeViewController: BuildableScene {
    struct InitialParams {
        let listener: SetPinCodePresenterListener
    }
    
    static func build(with params: InitialParams) -> SetPinCodeViewController {
        let viewController = StoryboardScene.SetPinCode.initialScene.instantiate()
        let presenter = SetPinCodePresenter(
            view: viewController,
            listener: params.listener
        )
        
        viewController.setPresenter(presenter)
        
        return viewController
    }
}
