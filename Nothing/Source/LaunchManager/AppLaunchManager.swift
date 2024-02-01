//
//  AppLaunchManager.swift
//  Commeta
//
//  Created by Hasan on 06/07/23.
//

import Foundation
import UIKit

final class AppLaunchManager {
    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func start(with application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        coordinator.start()
    }
}
