//
//  SettingCell.swift
//  Youtube
//
//  Created by chirag arora on 04/01/24.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            iconImageView.tintColor = isHighlighted ? .white : .gray
        }
    }
    
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName{
                iconImageView.image = UIImage(systemName: imageName)?.withTintColor(.gray, renderingMode: .alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "gear")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    func setupViews() {
        
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]-8-[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": iconImageView, "v1": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": iconImageView]))
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
