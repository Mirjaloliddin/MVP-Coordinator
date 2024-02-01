//
//  Alert.swift
//  CommetaID
//
//  Created by Khalmatov on 27.09.2023.
//

import UIKit

let screenSize = UIScreen.main.bounds

class CIDAlert {
    static var completion: ((Bool) -> Void)?
    
    enum AlertType {
        case warning
        case success
        case progress
    }
    
    static var timer: Timer? = nil
    
    class func showAlert(forState: AlertType, message: AlertMessage, vibrationType: CIDVibration, duration: TimeInterval = 4, userInteraction: Bool = true) {
        let view = UIView(frame: CGRect(x: 10, y: -80, width: screenSize.width-20, height: 60))
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: Float(0), green: Float(0), blue: Float(0), alpha: Float(1)), radius: 3, opacity: 0.4)
        view.backgroundColor = UIColor(named: "alertBackground")

        let leftAlertImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.frame = view.frame
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = .clear
            return imageView
        }()
            
        let rightDismissImageView: UIButton = {
            let button = UIButton()
            button.frame = view.frame
            button.contentMode = .scaleAspectFill
            button.backgroundColor = .clear
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.tintColor = .gray
            button.addTarget(self, action: #selector(closeBtnPressed), for: .touchCancel)
            return button
        }()
        
        let titleLbl: UILabel = {
            let label = UILabel()
            label.frame = view.frame
            label.textColor = .white
            label.minimumScaleFactor = 1
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.numberOfLines = 3
            label.font = UIFont.systemFont(ofSize: 15)
            return label
        }()
   
        view.addSubview(titleLbl)
        view.addSubview(leftAlertImageView)
        view.addSubview(rightDismissImageView)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        leftAlertImageView.translatesAutoresizingMaskIntoConstraints = false
        rightDismissImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftAlertImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            leftAlertImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            leftAlertImageView.rightAnchor.constraint(equalTo: titleLbl.leftAnchor, constant: -10),
            leftAlertImageView.heightAnchor.constraint(equalToConstant: 20),
            leftAlertImageView.widthAnchor.constraint(equalToConstant: 20),
            
            rightDismissImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            rightDismissImageView.leftAnchor.constraint(equalTo: titleLbl.rightAnchor, constant: 10),
            rightDismissImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            rightDismissImageView.heightAnchor.constraint(equalToConstant: 20),
            rightDismissImageView.widthAnchor.constraint(equalToConstant: 20),

            titleLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLbl.leftAnchor.constraint(equalTo: leftAlertImageView.rightAnchor, constant: 10),
            titleLbl.rightAnchor.constraint(equalTo: rightDismissImageView.leftAnchor, constant: -10),
            titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])

        view.tag = 9981
        
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            if let vi = UIApplication.shared.windows.filter ({$0.isKeyWindow}).first?.viewWithTag(9981) {
                timer?.invalidate()
                vi.removeFromSuperview()
            }
            window.addSubview(view)
            vibrate(type: vibrationType)
            
        }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseIn, animations: {
            view.transform = CGAffineTransform(translationX: 0, y: 90 + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) )
        })
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(closeBtnPressed))
        swipeLeft.direction = .up
        view.addGestureRecognizer(swipeLeft)
        titleLbl.text = message.rawValue
        switch forState {
        case .warning:
            leftAlertImageView.image = UIImage(named: "cid_warning")
        case .success:
            leftAlertImageView.image = UIImage(named: "cid_check")
        case .progress:
            leftAlertImageView.image = UIImage(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard")
        }
        
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(CIDAlert.closeBtnPressed), userInfo: nil, repeats: false)
    }
    
    @objc class func closeBtnPressed() {
        completion?(true)
        timer?.invalidate()
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
           let view = window.viewWithTag(9981) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                view.transform = .identity
            }) { (_) in
                view.removeFromSuperview()
            }
        }
    }
    
    private class func vibrate(type: CIDVibration){
        switch type {
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
    
}

   


enum AlertMessage: String {
    case notExistPassword = "You have not set your password yet, Please login by code confirmation"
    case notExistNumber = "User with this number not exists, go to register"
    case notExistEmail = "User with this email not exists, go to register"
    case wrongPassword = "Your password is wrong"
    case somethingWentWrong = "Something went wrong"
    case wrongCode = "Oops wrong or expired code, please check the code and try again"
    case validPassword = "The password has been successfully updated. Enter your details and log in"
    case passwordRequired = "Password required"
    case loggedIn = "You have successfully logged in"
    case userNotFound = "User information not found, go to register and have fun"
    case alredyExistNumber = "Looks like your number already exist"
    case successfullyRegistered = "You have successfully registered in our platform. Enter your details and log in"
}
