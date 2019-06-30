//
//  SearchVC.swift
//  GoldenTicket
//
//  Created by 안재은 on 30/06/2019.
//  Copyright © 2019 황수빈. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchView: UIView!
    
    var searchController: UISearchController!
    var originalDataSource : [String] = []
    
    var currentDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchView.addSubview(searchController.searchBar)
        
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        // Do any additional setup after loading the view.
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
extension SearchVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
