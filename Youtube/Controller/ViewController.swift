//
//  ViewController.swift
//  Youtube
//
//  Created by chirag arora on 26/12/23.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var window: UIWindow?
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
//    var videos: [Video] = {
//        var frankSinatraChannel = Channel()
//        frankSinatraChannel.name = "Frank Sinatra Channel"
//        frankSinatraChannel.profileImageName = "FrankSinatraProfile"
//        
//        var DeutschlandVideo = Video()
//        DeutschlandVideo.title = "DEUTSCHLAND (Rammstein cover)"
//        DeutschlandVideo.thumbnailImageName = "deuscheland"
//        DeutschlandVideo.channel = frankSinatraChannel
//        DeutschlandVideo.numberOfViews = 23467787
//        
//        
//        var FrankSinatraVideo = Video()
//        FrankSinatraVideo.title = "FrankSinatra Classic Hits"
//        FrankSinatraVideo.thumbnailImageName = "frankSinatra"
//        FrankSinatraVideo.channel = frankSinatraChannel
//        FrankSinatraVideo.numberOfViews = 456564556
//        
//        return [DeutschlandVideo, FrankSinatraVideo]
//    }()
    
    var videos: [Video]?
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    // downcasting json data to an array of dictionary objects
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String // Downcasted as a String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                 
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonError{
                print(jsonError)
            }
            
            
            
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.view.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        setupMenuBar()

        
        setupNavBarButtons()
        
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let moreImage = UIImage(systemName: "ellipsis.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,searchBarButton]
    }
    
    
    //Everytime we do lazy var instansiation code inside the block is only called once if this variable is nil second time variable is not nil only occurs when we are setting our app
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.ViewController = self
        return launcher
    }()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
        
        
        
    }
    
    func showControllerForSettings(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        
        // For changing Title color in NavigatioController
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }

    
    @objc func handleSearch() {
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,  views: ["v0": redView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(50)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil,  views: ["v0": redView]))
        
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : menuBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : menuBar]))
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        // 16px from top and bottom and 16/9 aspect ratio
        return CGSizeMake(view.frame.width, height + 16 + 68)
        // 16px from top, 68px from bottom(total padding)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}



