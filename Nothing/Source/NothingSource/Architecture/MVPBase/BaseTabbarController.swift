//
//  BaseTabbarController.swift
//  Commeta
//
//  Created by Hassan Abdullah on 11/07/23.
//

import UIKit

class BaseTabbarController<PresenterType>: UITabBarController, Scene {
    private var _presenter: Presenter?
    var presenter: PresenterType {
        guard let presenter = _presenter as? PresenterType else {
            fatalError(
                """
                Failed to get presenter: noticed an attempt of using \(String(
                describing: self)) with nil or incorrect type of Presenter.
                """
            )
        }
        return presenter
    }

    func setPresenter(_ presenter: PresenterType) {
        guard let presenter = presenter as? Presenter else {
            assertionFailure("Can't set the presenter that is not an Presenter protocol.")
            return
        }

        self._presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    deinit {

    }
}
