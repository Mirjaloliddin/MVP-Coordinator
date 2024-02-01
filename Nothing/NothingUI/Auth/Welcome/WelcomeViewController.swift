//
//  WelcomeViewController.swift
//  NothingNews
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 08/01/24.
//

import UIKit

class WelcomeViewController: BaseViewController<WelcomePresenter> {
    
    @IBOutlet weak var textfield: UITextField!
    let savedPinCode = UserDefaults.standard.string(forKey: "savedPinCode")
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func checkPinAction(_ sender: Any) {
        if textfield.text == savedPinCode {
            textfield.isHidden = true
        }
        
    }
    
}

extension WelcomeViewController: WelcomePresenterView {
    
}

extension WelcomeViewController: BuildableScene {
    struct InitialParams {
        let listener: WelcomePresenterListener
    }
    
    static func build(with params: InitialParams) -> WelcomeViewController {
        let viewController = StoryboardScene.Welcome.initialScene.instantiate()
        let presenter = WelcomePresenter(
            view: viewController,
            listener: params.listener
        )

        viewController.setPresenter(presenter)

        return viewController
    }
}
