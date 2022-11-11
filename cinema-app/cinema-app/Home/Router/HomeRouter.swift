//
//  HomeRouter.swift
//  cinema-app
//
//  Created by FABRIZIO on 11/11/22.
//

import Foundation
import UIKit

class HomeRouter {
    
    private weak var sourceView: HomeView?
    
    var viewController: UIViewController {
        return HomeView()
    }
    
    func setSourceView(view: HomeView?) {
        guard let sourceView = view else { fatalError("HomeView llegó vacío a home router") }
        self.sourceView = sourceView
    }
    
}
