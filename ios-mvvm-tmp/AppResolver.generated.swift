//
//  Resolver.swift
//  Generated by dikitgen.
//

import DIKit
import DataSourceKit
import Foundation
import RxCocoa
import RxSwift
import UIKit

extension AppResolver {

    func resolveAPIClient() -> APIClient {
        return provideAPIClient()
    }

    func resolveAppResolver() -> AppResolver {
        return provideAppResolver()
    }

    func resolveRepositoriesViewController() -> RepositoriesViewController {
        let appResolver = resolveAppResolver()
        return RepositoriesViewController.makeInstance(dependency: .init(appResolver: appResolver))
    }

    func resolveRepositoriesViewModel(starToggledIndex: Signal<Int>) -> RepositoriesViewModel {
        let apiClient = resolveAPIClient()
        return RepositoriesViewModel(dependency: .init(starToggledIndex: starToggledIndex, apiClient: apiClient))
    }

}

