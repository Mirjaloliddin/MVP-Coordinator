//
//  SignInCoordinator+Factory.swift
//  CommetaID
//
//  Created by  Abdurahmon on 14/09/23.
//

import Foundation

extension SignInCoordinator {
    class Factory {
        init(/*Services and params of Flow*/) {
            
        }
    }
}

// MARK: - Scenes
extension SignInCoordinator.Factory {
    
    func welcomeScene(listener: WelcomePresenterListener) -> Scene {
        
        return Builder.Scene<WelcomeViewController>.make(with: .init(listener: listener))
    }
    func pincodeScene(listener: SetPinCodePresenterListener) -> Scene {
        
        return Builder.Scene<SetPinCodeViewController>.make(with: .init(listener: listener))
    }
   
}

// MARK: - Coordinators
extension SignInCoordinator.Factory {
    /* Example of SomeCoordinator
     * func SomeCoordinator(listener: SomePresenterListener) -> Coordinator {
     *   return Builder.Coordinator<SomeCoordinator>.make(with: .init(listener: listener))
     * }
     */
}


