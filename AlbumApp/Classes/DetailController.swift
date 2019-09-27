//
//  ApiModel.swift
//  AlbumApp
//
//  Created by Sudin on 26/09/19.
//  Copyright © 2019 Sudin. All rights reserved.
//

import UIKit
import Foundation
class DetailController: UIViewController {
    
    var albumDetail : Album!
    let biggerImage = UIImageView()
    let albumBtn = UIButton(type: .custom)
    let scrollView = UIScrollView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Album Detail"
        view.backgroundColor = .white
        designView()

        // Do any additional setup after loading the view.
    }
    
    func designView()
    {
        
        biggerImage.contentMode = .scaleAspectFill
        biggerImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrlStr = albumDetail.artworkUrl100
        {
            biggerImage.loadImageUsingCache(withUrl: imageUrlStr)
        }
        else
        {
            biggerImage.image = UIImage(named: "PlaceHolder.png")
        }
        self.view.addSubview(biggerImage)
        
        albumBtn.setTitle("View Album", for: .normal)
        albumBtn.translatesAutoresizingMaskIntoConstraints = false
        albumBtn.backgroundColor = .black
        albumBtn.layer.cornerRadius = 5
        albumBtn.addTarget(self, action: #selector(viewAlbumBtnClicked), for: .touchUpInside)
        self.view.addSubview(albumBtn)
        
        let guide = view.layoutMarginsGuide
        
        biggerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        biggerImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        biggerImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        biggerImage.heightAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true // width = height
        

        albumBtn.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive = true
        albumBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        albumBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        albumBtn.heightAnchor.constraint(equalToConstant: 40)
        
        setScrollView()
        
    }
    
    @objc func setScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(scrollView, belowSubview: biggerImage)
    
        scrollView.anchor(top: biggerImage.bottomAnchor, left: self.view.leftAnchor, bottom: albumBtn.topAnchor, right: self.view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        var bottomAnchor = scrollView.bottomAnchor
        
        for i in 0...4
        {
            let detailsLbl = UILabel()
            
            detailsLbl.textAlignment = .center
            detailsLbl.numberOfLines = 0
            detailsLbl.lineBreakMode = .byWordWrapping
            detailsLbl.tag = i + 1
            
            switch i {
            case 0:
                detailsLbl.text = "Album : \(albumDetail.name ?? "")"
            case 1:
                detailsLbl.text = "Artist : \(albumDetail.artistName ?? "")"
            case 2:
                detailsLbl.text = "Genre : \(albumDetail.genres?.getCommaSeparatedValues() ?? "")"
            case 3:
                detailsLbl.text = "Release Date : \(albumDetail.releaseDate ?? "")"
            case 4:
                detailsLbl.text = "Copyright : \(albumDetail.copyright ?? "")"
            default:
                print("do nothing")
            }
            
            detailsLbl.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(detailsLbl)
            
            detailsLbl.topAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
            detailsLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
            detailsLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            detailsLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
            
            bottomAnchor = detailsLbl.bottomAnchor
         
        }
    }
    
    @objc func viewAlbumBtnClicked() {
        if let url = URL(string: albumDetail.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var height = CGFloat()
        for subview in scrollView.subviews {
            if let label = subview as? UILabel {
                height = height + 10 + label.frame.size.height
            }
        }
        scrollView.contentSize.height = height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
