//
//  VideoCell.swift
//  Youtube
//
//  Created by chirag arora on 27/12/23.
//

import UIKit


class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitletext = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 3 years ago "
                subtitleTextView.text = subtitletext
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            
            userProfileImageview.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: customImageView = {
        let imageView = customImageView()
        imageView.image = UIImage(named: "deuscheland")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // translatesAutoresizingMaskIntoConstraints = false
        // this tell iOS not to create Auto Layout constraints automatically
        return imageView
    }()
    
    let userProfileImageview: customImageView = {
        let imageView = customImageView()
        imageView.image = UIImage(named: "rammstein")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        // translatesAutoresizingMaskIntoConstraints = false
        // this tell iOS not to create Auto Layout constraints automatically
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(_colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        // translatesAutoresizingMaskIntoConstraints = false
        // this tell iOS not to create Auto Layout constraints automatically
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DEUTSCHLAND (Rammstein cover)"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Rammstein Official • 347M views • 4 years ago "
        textView.contentInset = UIEdgeInsets(top: -6, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    
    func setUpViews() {
        
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageview)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        // Constraints for ThumbnailView
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|",options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        /// Commenting this because - vertical constraints of userProfile View needed Vertical constraints of thumbnail view along with it to work properly ↓
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-|",options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
///        horizontal axis padding of 16pixels on left and right of thumbnailview
///        vertical axis padding of 16 pixels on top and bottom of thumbnailview
///        pipes ( | ) indicate top edge and bottom edge and left edge and right edge
        
        
        
        // Constraints for userProfileImageView
        /// Vertical constraints for thumbnail View defines along with userProfileView ↓
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-8-[v1(44)]-16-|",options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView,"v1" : userProfileImageview]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-16-[v0(44)]",options: NSLayoutConstraint.FormatOptions(), metrics: nil, views:
            ["v0" : userProfileImageview]))
        
        
        
        // Constraints for seperatorView
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|",options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
///        here seperatorView will touch left edge and right edge as pipes | are there on both sides
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|",options:  NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
///        here seperator view will touch only bottom edge and not top edge as pipe | is there only for bottom edge
        /*1 pixel [v0(1)] tall vertically*/
        /*0 pixel [v0] tall horizontally*/
        
        
        
        // Constraints for titleLabel
        
        /// Top constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        /// left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageview, attribute: .right, multiplier: 1, constant: 8))
        
        /// Right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        /// Height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        
        // Constraints for subtitleTextView
        
        /// Top constraints
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        /// left Constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageview, attribute: .right, multiplier: 1, constant: 8))
        
        /// Right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        /// Height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
