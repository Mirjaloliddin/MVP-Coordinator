import Foundation
import UIKit

protocol NavigationHeaderView: ViewProtocol {
    func setLeftItem(with model: HeaderBarItem?)
    func setRightItem(with model: [HeaderBarItem?]?)
    func setTitle(with str: String?)
    func setBorderHidden(_ isHidden: Bool)
}

protocol NavigationHeaderViewModelProtocol {
    var leftItem: HeaderBarItem? { get set }
    var rightItems: [HeaderBarItem?]? { get set }
    var title: String? { get set }
    var tintColor: UIColor? { get set }
    var isBorderHidden: Bool { get set }
}

protocol NavigationUserHeaderViewModelProtocol: NavigationHeaderViewModelProtocol {
    var customView: UIView? { get set }
}

struct NavigationHeaderViewModel: NavigationHeaderViewModelProtocol {
    var leftItem: HeaderBarItem?
    var rightItems: [HeaderBarItem?]?
    var title: String?
    var tintColor: UIColor?
    var isBorderHidden: Bool = false
}

struct NavigationUserHeaderViewModel: NavigationUserHeaderViewModelProtocol {
    var customView: UIView?
    var leftItem: HeaderBarItem?
    var rightItems: [HeaderBarItem?]?
    var title: String?
    var tintColor: UIColor?
    var isBorderHidden: Bool = false
}

struct HeaderBarItem {
    let image: UIImage?
    let title: String?
    let titleColor: UIColor?
    let titleFont: UIFont?
    let accessibilityValue: String?
    let accessibilityHint: String?
    let isEnabled: Bool?
    let tag: Int?
    let menu: UIMenu?

    init(image: UIImage?,
         title: String?,
         titleColor: UIColor?,
         titleFont: UIFont?,
         accessibilityValue: String? = nil,
         accessibilityHint: String? = nil,
         isEnabled: Bool? = true,
         tag: Int = 0,
         menu: UIMenu? = nil) {
        self.image = image
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.accessibilityValue = accessibilityValue
        self.accessibilityHint = accessibilityHint
        self.isEnabled = isEnabled
        self.tag = tag
        self.menu = menu
    }

    init(image: UIImage?,
         accessibilityValue: String? = nil,
         accessibilityHint: String? = nil,
         tag: Int = 0,
         menu: UIMenu? = nil) {
        self.init(image: image,
                  title: nil,
                  titleColor: nil,
                  titleFont: nil,
                  accessibilityValue: accessibilityValue,
                  accessibilityHint: accessibilityHint,
                  tag: tag,
                  menu: menu)
    }

    init(title: String?,
         accessibilityValue: String? = nil,
         accessibilityHint: String? = nil) {
        self.init(image: nil,
                  title: title,
                  titleColor: nil,
                  titleFont: nil,
                  accessibilityValue: accessibilityValue,
                  accessibilityHint: accessibilityHint)
    }

    init(title: String?,
         titleColor: UIColor?,
         accessibilityValue: String? = nil,
         accessibilityHint: String? = nil,
         isEnabled: Bool? = true) {
        self.init(image: nil,
                  title: title,
                  titleColor: titleColor,
                  titleFont: nil,
                  accessibilityValue: accessibilityValue,
                  accessibilityHint: accessibilityHint,
                  isEnabled: isEnabled)
    }

    init(title: String?,
         titleColor: UIColor?,
         titleFont: UIFont?,
         accessibilityValue: String? = nil,
         accessibilityHint: String? = nil) {
        self.init(image: nil,
                  title: title,
                  titleColor: titleColor,
                  titleFont: titleFont,
                  accessibilityValue: accessibilityValue,
                  accessibilityHint: accessibilityHint)
    }
}

typealias NavigationHeaderItemsSelectable = NavigationHeaderRightItemSelectable & NavigationHeaderLeftItemSelectable

protocol NavigationHeaderLeftItemSelectable {
    func onLeftItemAction()
}

protocol NavigationHeaderRightItemSelectable {
    func onRightItemAction(_ sender: UIBarButtonItem)
}

protocol NavigationHeaderConfigurable {
    func setupNavigationHeader(viewModel: NavigationHeaderViewModelProtocol)
}
