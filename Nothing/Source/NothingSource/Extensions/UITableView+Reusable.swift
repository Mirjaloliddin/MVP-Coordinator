//
//  UITableView+Reusable.swift
//  CommetaID
//
//  Created by Beksulton on 16/09/23.
//

import UIKit.UIView

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIView: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }

    public class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }

    public class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }

}

extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibIdentifiable where Self: UIViewController {

    static func instantiateFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }

}

extension NibIdentifiable where Self: UIView {

    static func instantiateFromNib() -> Self {
        guard let view = UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Couldn't find nib file for \(String(describing: Self.self))")
        }
        return view
    }

}

extension UITableView {

    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: String(describing: T.self))
    }

    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: String(describing: T.self),
            for: indexPath) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
        guard let headerFooterView = self
            .dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return headerFooterView
    }

}

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
    }

    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                                  for: indexPath) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return cell
    }
}
