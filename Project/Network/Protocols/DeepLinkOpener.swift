//
//  DeepLinkOpener.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import UIKit

protocol DeepLinkOpener {
    func open(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: DeepLinkOpener {
    func open(_ url: URL, options: [OpenURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?) {}
}
