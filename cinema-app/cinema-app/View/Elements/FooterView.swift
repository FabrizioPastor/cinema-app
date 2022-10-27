//
//  ForYouUIViewViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 25/10/22.
//

import UIKit


class FooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        guard let view = loadViewFromNib(nibName: "FooterView") else {return}
        view.frame = bounds
        addSubview(view)
    }
}

