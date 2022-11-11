//
//  HomeViewModel.swift
//  cinema-app
//
//  Created by FABRIZIO on 11/11/22.
//

import Foundation

class HomeViewModel {
    
    var router: HomeRouter?
    var view: HomeView?
    
    func bind (router: HomeRouter, view: HomeView) {
        self.view = view
        self.router = router
        
        self.router?.setSourceView(view: view)
    }
    
}
