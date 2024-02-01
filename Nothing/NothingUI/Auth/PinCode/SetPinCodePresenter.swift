//
//  SetPinCodePresenter.swift
//  Commeta
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 10/01/24.
//

import Foundation
import UIKit

protocol SetPinCodePresenterView: PresenterView {
    //Add some methods for SetPinCodePresenter
}

protocol SetPinCodePresenterListener: PresenterListener {
    func handle(_ presenter: SetPinCodePresenter, event: SetPinCodePresenter.Event)
}

final class SetPinCodePresenter: BasePresenter<SetPinCodePresenterView, SetPinCodePresenterListener> {
    
    lazy var viewController: SetPinCodeViewController? = {
        return (view as? SetPinCodeViewController)
    }()
    
    lazy var viewControllerView: SetPinCodeView? = {
        return (viewController?.view as? SetPinCodeView)
    }()
    
    func openWelcome() {
        listener?.handle(self, event: .goToNext)
    }
    func pinCodeAction(sender: UIButton) {
        
        viewControllerView?.tapCount += 1
        
        if viewControllerView?.pinCodeText.count ?? 0 < viewControllerView?.pinCodeCount ?? 0 {
            viewControllerView?.pinCodeText = (viewControllerView?.pinCodeText ?? "") + "\(sender.tag)"
            viewControllerView?.circleViews[(viewControllerView?.pinCodeText.count ?? 0) - 1].backgroundColor = .blue
        }
        
        if viewControllerView?.tapCount ?? 0 > viewControllerView?.pinCodeCount ?? 0  {
            
            if viewControllerView?.currentPinCode.count ?? 0 < viewControllerView?.pinCodeCount ?? 0 {
                viewControllerView?.currentPinCode = (viewControllerView?.currentPinCode ?? "") + "\(sender.tag)"
                viewControllerView?.circleViews[(viewControllerView?.currentPinCode.count ?? 0) - 1].backgroundColor = .link
                
                if viewControllerView?.pinCodeText == viewControllerView?.currentPinCode {
                    viewControllerView?.userDefaults.set(viewControllerView?.currentPinCode, forKey: "savedPinCode")
                    viewControllerView?.userDefaults.synchronize()
                    listener?.handle(self, event: .goToNext)
                }
                if (viewControllerView?.pinCodeText.count == viewControllerView?.currentPinCode.count) && (viewControllerView?.pinCodeText != viewControllerView?.currentPinCode) {
                    
                    CIDAlert.showAlert(forState: .success, message: .loggedIn, vibrationType: .success)
                    viewControllerView?.tapCount = 0
                    viewControllerView?.pinCodeText = ""
                    viewControllerView?.currentPinCode = ""
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.viewControllerView?.enterPinLabel.transform = CGAffineTransform(translationX: -30, y: 0)
                        self.viewControllerView?.digitStackView.transform = CGAffineTransform(translationX: -30, y: 0)
                        self.viewControllerView?.enterPinLabel.alpha = 0.0
                        self.viewControllerView?.digitStackView.alpha = 0.0
                    }, completion: { [weak self] _ in
                        self?.viewControllerView?.enterPinLabel.text = "Enter the pin code"
                        
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                            self?.viewControllerView?.enterPinLabel.transform = .identity
                            self?.viewControllerView?.digitStackView.transform = .identity
                            self?.viewControllerView?.enterPinLabel.alpha = 1.0
                            self?.viewControllerView?.digitStackView.isHidden = false
                            self?.viewControllerView?.digitStackView.alpha = 1.0
                        }, completion: { _ in
                        })
                    })
                    
                    if let circleViews = viewControllerView?.circleViews {
                        for view in circleViews {
                            UIView.transition(with: view, duration: 0.5, options: .curveEaseInOut, animations: {
                                view.backgroundColor = .systemGray2
                            }, completion: nil)
                        }
                    }
                }
            }
        }
        
        if (viewControllerView?.pinCodeText.count == viewControllerView?.pinCodeCount) && (viewControllerView?.tapCount ?? 0 <= viewControllerView?.pinCodeCount ?? 0) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.viewControllerView?.enterPinLabel.transform = CGAffineTransform(translationX: -30, y: 0)
                self.viewControllerView?.digitStackView.transform = CGAffineTransform(translationX: -30, y: 0)
                self.viewControllerView?.enterPinLabel.alpha = 0.0
                self.viewControllerView?.digitStackView.alpha = 0.0
            }, completion: { [weak self] _ in
                self?.viewControllerView?.enterPinLabel.text = "Enter the pin code again"
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self?.viewControllerView?.enterPinLabel.transform = .identity
                    self?.viewControllerView?.digitStackView.transform = .identity
                    self?.viewControllerView?.enterPinLabel.alpha = 1.0
                    self?.viewControllerView?.digitStackView.isHidden = true
                    self?.viewControllerView?.digitStackView.alpha = 1.0
                })
            })
            if let circleViews = viewControllerView?.circleViews {
                for view in circleViews {
                    UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        view.backgroundColor = .systemGray2
                    }, completion: nil)
                }
            }
        }
    }
}

extension SetPinCodePresenter {
    enum Event {
        case goToNext
    }
}
