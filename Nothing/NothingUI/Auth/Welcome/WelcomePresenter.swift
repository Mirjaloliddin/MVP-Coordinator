//
//  WelcomePresenter.swift
//  NothingNews
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 08/01/24.
//

import Foundation

protocol WelcomePresenterView: PresenterView {
    //Add some methods for WelcomePresenter
}

protocol WelcomePresenterListener: PresenterListener {
    func handle(_ presenter: WelcomePresenter, event: WelcomePresenter.Event)
}

final class WelcomePresenter: BasePresenter<WelcomePresenterView, WelcomePresenterListener> {
    
    //Add some methods for WelcomePresenterView
}

extension WelcomePresenter {
    enum Event {
        
    }
}
