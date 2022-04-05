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
        self.tableView.register(UINib(nibName: "SquadHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SquadHeaderViewIdentifier")
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SquadHeaderViewIdentifier") as? SquadHeaderView else {
            return nil
        }
        var title = ""
        switch section {
        case 2:
            title = "Goalkeepers"
        case 3:
            title = "Defenders"
        case 4:
            title = "Midfielders"
        case 5:
            title = "Forwarders"
        case 6:
            title = "Coach"
        default:
            title = ""
        }
        headerView.headerTitle.text = title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return squad?.goalkeepers().count ?? 0
        case 3:
            return squad?.defenders().count ?? 0
        case 4:
            return squad?.midfielders().count ?? 0
        case 5:
            return squad?.forwarders().count ?? 0
        case 6:
            return squad?.coach().count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let topCell = tableView.dequeueReusableCell(withIdentifier: "TopSquadCellIdentifier", for: indexPath)
                    as? TopSquadTableViewCell else {
                return UITableViewCell()
            }
            topCell.setupWithSquad(squad: self.squad)
            topCell.delegate = self
            return topCell
        case 1:
            guard let buttonsCell = tableView.dequeueReusableCell(withIdentifier: "ButtonsSquadCellIdentifier", for: indexPath)
                    as? ButtonsSquadTableViewCell else {
                return UITableViewCell()
            }
            buttonsCell.delegate = self
            return buttonsCell
        default:
            break
        }
        let players = self.playersForSection(section: indexPath.section)
        guard let playerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerSquadCellIdentifier", for: indexPath)
                as? PlayerSquadTableViewCell else {
            return UITableViewCell()
        }
        playerCell.setupWithPlayer(player: players[indexPath.row])
        return playerCell
    }
    
    func playersForSection(section: Int) -> [Person] {
        switch section {
        case 2:
            return squad?.goalkeepers() ?? [Person]()
        case 3:
            return squad?.defenders() ?? [Person]()
        case 4:
            return squad?.midfielders() ?? [Person]()
        case 5:
            return squad?.forwarders() ?? [Person]()
        case 6:
            return squad?.coach() ?? [Person]()
        default:
            return [Person]()
        }
    }
}

extension SquadViewController: ButtonCellDelegate {
    func buttonPressed(tag: Int) {
        //Change datasource
        tableView.reloadData()
    }
}

extension SquadViewController: TopCellDelegate {
    func backButtonPressed() {
        //Do nothing for now
    }
    
    func favouriteButtonPressed(isFavourite: Bool) {
        self.squad?.isFavourite = isFavourite
    }
}
