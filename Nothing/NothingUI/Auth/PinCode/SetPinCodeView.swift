//
//  SetPinCodeView.swift
//  Commeta
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 10/01/24.
//

import UIKit

class SetPinCodeView: BaseView {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var digitPinSwitch: UISwitch!
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet weak var digitStackView: UIStackView!
    @IBOutlet weak var enterPinLabel: UILabel!
    
    var userDefaults = UserDefaults.standard
    var pinCodeCount: Int = 4
    var currentPinCode: String = ""
    var pinCodeText: String = ""
    var pinTextPreview: String = ""
    var tapCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCircleViews()
    }
    
    func setupCircleViews() {
        let viewsToHide = circleViews.suffix(2)
        for view in viewsToHide {
            view.isHidden = true
        }
    }
    
    @IBAction func digitPinCode(_ sender: UISwitch) {
        if digitPinSwitch.isOn {
            pinCodeCount = 6
        } else {
            pinCodeCount = 4
        }

        if sender.isOn {
            let viewsToHide = circleViews.suffix(2)
            for view in viewsToHide {
                view.isHidden = false
            }
        } else {
            let viewsToHide = circleViews.suffix(2)
            for view in viewsToHide {
                view.isHidden = true
            }
        }
    }
 
    @IBAction func deletePinCode(_ sender: Any) {
        tapCount -= 1
        if (pinCodeText.count > 0) && (currentPinCode.count == 0) {
            pinCodeText.removeLast()
            circleViews[pinCodeText.count].backgroundColor = .gray
         
        }
        if currentPinCode.count > 0 {
            currentPinCode.removeLast()
            circleViews[currentPinCode.count].backgroundColor = .gray
        }
    }
}
