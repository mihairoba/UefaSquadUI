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
    @IBOutlet weak var squadName: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var squadBadge: UIImageView!
    @IBOutlet weak var roundNumber: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var squadDetailsView: UIView!
    
    //MARK: Vars
    var squad : Squad?
    var screenStyle: AppStyle = .UCL
    var isCollapsed = false
    var selectedTag = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove extra lines in tableView
        self.tableView.register(UINib(nibName: "SquadHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SquadHeaderViewIdentifier")
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        squad = UtilsManager.instance.generateSquad()
        tableView.reloadData()
        setupWithSquad()
    }
    
    func setupWithStyle() {
        self.view.backgroundColor = UIColor(named: "\(screenStyle.rawValue)_background")!
        self.tableView.backgroundColor = UIColor(named: "\(screenStyle.rawValue)_background")!
    }
    
    func setupWithSquad() {
        self.squadName.text = squad?.name ?? ""
        self.squadBadge.image = UIImage(named: squad?.badge ?? "")
        self.roundNumber.text = "Round of \(squad?.round ?? 1)"
        self.favouriteButton.isSelected = squad?.isFavourite == true
        self.backgroundImage.image = UIImage(named: "background_\(screenStyle.rawValue)")
        self.tableView.backgroundColor = screenStyle == .UCL ? UIColor(rgbHex: 0x010040) : UIColor(rgbHex: 0x000000)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.squad?.isFavourite = sender.isSelected
    }
    
    @IBAction func foldButtonPressed(_ sender: Any) {
        squadDetailsView.isHidden = !squadDetailsView.isHidden
        isCollapsed = squadDetailsView.isHidden
        tableView.reloadData()
    }
    
}

extension SquadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isCollapsed || selectedTag != 5{
            return 1
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isCollapsed || selectedTag != 5{
            return 0
        }
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SquadHeaderViewIdentifier") as? SquadHeaderView else {
            return nil
        }
        var title = ""
        switch section {
        case 1:
            title = "Goalkeepers"
        case 2:
            title = "Defenders"
        case 3:
            title = "Midfielders"
        case 4:
            title = "Forwarders"
        case 5:
            title = "Coach"
        default:
            title = ""
        }
        headerView.backgroundImage.backgroundColor = screenStyle == .UCL ? UIColor(rgbHex: 0x0A0A61) : UIColor(rgbHex: 0x1C1C1E)
        headerView.headerTitle.text = title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return squad?.goalkeepers().count ?? 0
        case 2:
            return squad?.defenders().count ?? 0
        case 3:
            return squad?.midfielders().count ?? 0
        case 4:
            return squad?.forwarders().count ?? 0
        case 5:
            return squad?.coach().count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section ==  0 {
            guard let buttonsCell = tableView.dequeueReusableCell(withIdentifier: "ButtonsSquadCellIdentifier", for: indexPath)
                    as? ButtonsSquadTableViewCell else {
                return UITableViewCell()
            }
            buttonsCell.setupWithStyle(style: screenStyle)
            buttonsCell.delegate = self
            return buttonsCell
        }
        let players = self.playersForSection(section: indexPath.section)
        guard let playerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerSquadCellIdentifier", for: indexPath)
                as? PlayerSquadTableViewCell else {
            return UITableViewCell()
        }
        playerCell.setupWithPlayer(player: players[indexPath.row], style: screenStyle)
        return playerCell
    }
    
    func playersForSection(section: Int) -> [Person] {
        switch section {
        case 1:
            return squad?.goalkeepers() ?? [Person]()
        case 2:
            return squad?.defenders() ?? [Person]()
        case 3:
            return squad?.midfielders() ?? [Person]()
        case 4:
            return squad?.forwarders() ?? [Person]()
        case 5:
            return squad?.coach() ?? [Person]()
        default:
            return [Person]()
        }
    }
}

extension SquadViewController: ButtonCellDelegate {
    func buttonPressed(tag: Int) {
        //Change datasource
        selectedTag = tag
        tableView.reloadData()
    }
}
