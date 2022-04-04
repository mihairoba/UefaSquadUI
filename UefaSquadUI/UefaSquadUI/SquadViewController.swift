//
//  SquadViewController.swift
//  UefaSquadUI
//
//  Created by Mihai Roba on 04.04.2022.
//

import UIKit

class SquadViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Vars
    var squad : Squad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove extra lines in tableView
        tableView.tableFooterView = UIView()
        squad = UtilsManager.instance.generateSquad()
        tableView.reloadData()
    }
}

extension SquadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 0
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

