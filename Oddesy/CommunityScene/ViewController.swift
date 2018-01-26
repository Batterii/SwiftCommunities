//
//  ViewController.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/18/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class ViewController: MVVMViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: ChooseCommunityViewModel = {
        return ChooseCommunityViewModel(api:Api(), communitiesListener: self)
    }()
    
    override func initViewModel() {
        
        // show/hide our loading indicator
        viewModel.updateLoadingBinding = { [weak self] in
            if(self?.viewModel.isLoading)!{
                self?.loadingIndicator.startAnimating()
            }else{
                self?.loadingIndicator.stopAnimating()
            }
        }
        
        // show an alert
        viewModel.showAlertBinding = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage{
                    self?.showAlert("Error", message)
                }
            }
        }
        
    }

}

extension ViewController : RealmCollectionListener{
    var tableview: UITableView {
        return self.tableView
    }
}

extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchIndex(communityName: searchBar.text!)
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCommunityCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            viewModel.deleteCommunity(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as? CommunityCell else{
            fatalError("Could not find cell in storyboard")
        }
        
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        
        cell.logo.sd_setImage(with: cellViewModel.communityBannerUrl, completed: nil)
        cell.communityName.text = cellViewModel.communityName
        
        return cell
    }
}
