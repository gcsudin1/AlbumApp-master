//
//  ApiModel.swift
//  AlbumApp
//
//  Created by Sudin on 26/09/19.
//  Copyright © 2019 Sudin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let albumListTable = UITableView()
    let cellID = "CustomCell"
    var albums = [Album]()
    
    override func viewDidLoad()
    {
        self.createTableView()
        fetchAlbums()
        self.navigationItem.title = "Albums"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchAlbums() {
        
        let loader = AppLoader(frame: self.view.bounds)
        self.view.addSubview(loader)
        loader.showLoaderWithMessage("Loading...")
        
        ApiManager().getAlbums()
            { (status, result, error) in
                if status {
                    AppLoader.hideLoaderIn(self.view)
                    print("final result \(status)")
                    if let albumList = result {
                        self.albums = albumList
                    }
                    DispatchQueue.main.async  {
                        self.albumListTable.reloadData()
                    }
                } else {
                    AppLoader.showErrorIn(view: self.view, withMessage: "Could not fetch details at the moment. Please try again later...")
                }
        }
    }
    
    func createTableView()
    {
        albumListTable.register(customCell.self, forCellReuseIdentifier: cellID)
        albumListTable.delegate = self
        albumListTable.dataSource = self
        albumListTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(albumListTable)
        
        albumListTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        albumListTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        albumListTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        albumListTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        albumListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath) as! customCell
        let currentLastItem = albums[indexPath.row]
        cell.album = currentLastItem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailController()
        vc.albumDetail = albums[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
            
        
    }
    
}


