//
//  CommunityViewModel.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/18/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation
import RealmSwift

class ChooseCommunityViewModel{
    
    let api: Api
    
    let communitiesListener : RealmCollectionListener
    
    let communities : Results<Community>
    
    let realm : Realm
    
    var notificationToken: NotificationToken? = nil
    
    // whenever isLoading changes, this method is called
    var isLoading : Bool = false{
        didSet{
            self.updateLoadingBinding?()
        }
    }
    
    //whenever an alert message is set, this method is called
    var alertMessage: String? {
        didSet {
            self.showAlertBinding?()
        }
    }
    
    var numberOfCommunityCells : Int {
        return communities.count
    }

    // binding for loading indicator closure
    var updateLoadingBinding: (()->())?
    
    // binding for alert closure
    var showAlertBinding: (()-> ())?
    
    init(api: Api, communitiesListener: RealmCollectionListener){
        self.api = api
        self.communitiesListener = communitiesListener
        
        self.realm = try! Realm()
        
        self.communities = realm.objects(Community.self).sorted(byKeyPath: "name")//order each community by its name
        
        // add change listener for community records
        self.notificationToken = communities.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes{
                case .initial:
                    self?.communitiesListener.initial()
                    break
                
                case .update(_, let deletions, let insertions, let modifications):
                    
                    self?.communitiesListener.dispatachTableViewUpdates(deletions: deletions, insertions: insertions, modifications: modifications)
                
                case .error(let error):
                    fatalError("\(error)")
            }
        }
    }
    
    // call our /index.json endpoint
    func fetchIndex(communityName: String){
        self.isLoading = true
    
        api.fetchIndex(name: communityName) { [weak self] (success, error) in
            self?.isLoading = false
            
            if(error != nil){
                self?.alertMessage = error?.localizedDescription
            }
        }
    }
    
    // delete the community, our change listener will take care of updating the tableview accordingly
    func deleteCommunity(indexPath: IndexPath){
        let community = communities[indexPath.row]
        try! realm.write {
            realm.delete(community)
        }
    }
    
    func cellViewModel( at indexPath: IndexPath) -> CommunityCellViewModel{
        return createCommunityCellViewModel(community: communities[indexPath.row])
    }
    
    // factory method for our community cell view model
    private func createCommunityCellViewModel(community: Community) -> CommunityCellViewModel{
        var url = ""
        
        if let logoUrl = community.logos?.banner?.servingURL{
            url.append(logoUrl)
        }
        return CommunityCellViewModel(communityName: community.name,communityBannerUrl: URL(string:url)!)
    }
    
}

struct CommunityCellViewModel{
    let communityName: String
    let communityBannerUrl: URL
}
