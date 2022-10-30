//
//  ForYouUIViewViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 25/10/22.
//

import UIKit


class FooterView: UIView {
    
    private let footerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 138, height: 180)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "footerCell")
        return collectionView
    }()
    
    @IBOutlet weak var footerViewCollectionView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        //footerViewCollectionView.backgroundColor = .red
        //footerCollectionView.backgroundColor = .blue
        footerCollectionView.frame = footerViewCollectionView.bounds
        footerViewCollectionView.addSubview(footerCollectionView)
        
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        footerCollectionView.frame = footerViewCollectionView.bounds
        footerViewCollectionView.addSubview(footerCollectionView)
    }
    
    private func configureView(){
        guard let view = loadViewFromNib(nibName: "FooterView") else {return}
        view.frame = bounds
        addSubview(view)
    }
}

extension FooterView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "footerCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
     
}

