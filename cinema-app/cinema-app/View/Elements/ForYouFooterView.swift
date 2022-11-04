//
//  ForYouUIViewViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 25/10/22.
//

import UIKit


class ForYouFooterView: UIView {
    
    private var titles: [CategoryBody] = [CategoryBody]()
    
    private let footerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 138, height: 180)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CoverCollectionViewCell.self, forCellWithReuseIdentifier: CoverCollectionViewCell.identifier)
        return collectionView
    }()
    
    @IBOutlet weak var footerViewCollectionView: UIView!
    @IBOutlet var principalView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureView()
        
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
        
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
    }
    
    private func configureView(){
        guard let view = loadViewFromNib(nibName: "FooterView") else {return}
        view.frame = bounds
        addSubview(view)
        
        //ESTE FRAGMENTO HACE EXACTAMENTE LO MISMO, SOLO QUE APOYANDOSE EN EL INSPECTOR DEL XIB PARA ENLAZAR MEDIANTE OULET LA VIEW CON EL CONTROLADOR
        /*
         Bundle.main.loadNibNamed("FooterView", owner: self)
         principalView.frame = bounds
         addSubview(principalView)
         */
    }
    
    public func configure(){
        APICaller.shared.getDataFrom(category: .topRated) { results in
            switch results {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async { [weak self] in
                    self?.footerCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

extension ForYouFooterView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCollectionViewCell.identifier, for: indexPath) as? CoverCollectionViewCell else { return UICollectionViewCell() }
        
        if titles.isEmpty {
            return cell
        }
        
        guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
     
}

