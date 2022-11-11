//
//  CoverCollectionViewCell.swift
//  cinema-app
//
//  Created by FABRIZIO on 3/11/22.
//

import Foundation
import SDWebImage

class CoverCollectionViewCell: UICollectionViewCell {
    //MARK: - Atributos
    static let identifier = "CoverCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Métodos de clase
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with coverImageName: String) {
        guard let url = URL(string: APICaller.Constants.imageBaseURL + coverImageName ) else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
