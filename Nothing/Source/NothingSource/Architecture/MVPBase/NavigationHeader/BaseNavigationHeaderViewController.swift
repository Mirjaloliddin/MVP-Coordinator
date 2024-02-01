import Foundation
import UIKit

class BaseNavigationHeaderViewController<PresenterType>: BaseViewController<PresenterType> {
    private let imageTitlePadding: CGFloat = 8

    private enum HeaderItemAligment {
        case left, right
    }

    var navigationHeaderViewModel: NavigationHeaderViewModelProtocol {
        NavigationHeaderViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().isTranslucent = false

        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?
            .navigationBar
            .scrollEdgeAppearance = navigationController?
            .navigationBar
            .standardAppearance

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
//            .setTitleTextAttributes([.foregroundColor: Colors.colorsActive.color], for: .normal)

        navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationHeader(viewModel: navigationHeaderViewModel)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = .clear
        let navBarApperence = UINavigationBarAppearance()
        navBarApperence.shadowColor = .clear
        navBar?.scrollEdgeAppearance = navBarApperence
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }

    @objc func leftHeaderItemDidTap() {
        if let presenter = presenter as? NavigationHeaderLeftItemSelectable {
            presenter.onLeftItemAction()
        }
    }

    @objc func rightHeaderItemDidTap(_ sender: UIBarButtonItem) {
        if let presenter = presenter as? NavigationHeaderRightItemSelectable {
            presenter.onRightItemAction(sender)
        }
    }

    func setupNavigationHeader(viewModel: NavigationHeaderViewModelProtocol) {
        if viewModel is NavigationUserHeaderViewModelProtocol {
            setUserHeaderView(with: (viewModel as? NavigationUserHeaderViewModelProtocol)?.customView)
        }
//        setBarColor(.white, tintColor: viewModel.tintColor ?? Colors.colorsActive.color)
        setLeftItem(with: viewModel.leftItem)
        setRightItem(with: viewModel.rightItems)
        setTitle(with: viewModel.title)
        setBorderHidden(viewModel.isBorderHidden)
    }

    // MARK: - Private
    private func configureBarItem(with model: HeaderBarItem,
                                  alignment: BaseNavigationHeaderViewController.HeaderItemAligment,
                                  action: Selector,
                                  menu: UIMenu? = nil) -> UIBarButtonItem {
        let view = UIView()
        let button = UIButton(type: .custom)
        button.setImage(model.image, for: .normal)
        button.setTitle(model.title, for: .normal)
        button.setTitleColor(model.titleColor, for: .normal)
        button.tag = model.tag ?? 0
        if let titleFont = model.titleFont {
            button.titleLabel?.font = titleFont
        }
        if case .left = alignment {
            button.semanticContentAttribute = .forceLeftToRight
        } else {
            button.semanticContentAttribute = .forceRightToLeft
        }
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.contentEdgeInsets = UIEdgeInsets(
            top: imageTitlePadding,
            left: imageTitlePadding,
            bottom: imageTitlePadding,
            right: imageTitlePadding
        )
        button.sizeToFit()
        button.addTarget(self, action: action, for: .touchUpInside)

        view.addSubview(button)
        view.frame = button.bounds

        return UIBarButtonItem(customView: view)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseNavigationHeaderViewController: NavigationHeaderView {
    func setLeftItem(with model: HeaderBarItem?) {
        guard let model = model else {
            navigationItem.setLeftBarButton(nil, animated: false)
            return
        }
        let barButtonItem = configureBarItem(with: model, alignment: .left, action: #selector(leftHeaderItemDidTap))
        barButtonItem.isAccessibilityElement = true
        barButtonItem.accessibilityValue = model.accessibilityValue
        barButtonItem.accessibilityHint = model.accessibilityHint
        navigationItem.leftBarButtonItem = barButtonItem
    }

    func setRightItem(with model: [HeaderBarItem?]?) {
        guard let model = model else {
            navigationItem.setRightBarButton(nil, animated: false)
            return
        }
        var rightButtons = [UIBarButtonItem()]

        for item in model {
            guard let item = item else {
                navigationItem.setRightBarButton(nil, animated: false)
                return
            }
            let barButtonItem = configureBarItem(
                with: item,
                alignment: .right,
                action: #selector(rightHeaderItemDidTap(_ :)),
                menu: item.menu)
            barButtonItem.isEnabled = item.isEnabled ?? true
            rightButtons.append(barButtonItem)

        }
        navigationItem.rightBarButtonItems = rightButtons

    }

    func setUserHeaderView(with view: UIView?) {
        navigationItem.titleView = view
    }

    func setTitle(with title: String?) {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.accessibilityLabel = accessibilityLabel
        self.title = title
    }

    func setBorderHidden(_ isHidden: Bool) {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.shadowColor = isHidden ? .clear : Colors.lightGrey.color
        navigationBarAppearance.backgroundColor = .white
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }

    func setBarColor(_ color: UIColor, tintColor: UIColor = .white) {
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = tintColor
        navigationController?.navigationBar.backgroundColor = color
        navigationController?.navigationBar.barTintColor = color
    }
}
