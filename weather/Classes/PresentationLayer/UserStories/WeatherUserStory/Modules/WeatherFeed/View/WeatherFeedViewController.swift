//
//  WeatherFeedWeatherFeedViewController.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import TableKit
import ESPullToRefresh

class WeatherFeedViewController: UIViewController, WeatherFeedViewInput, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    var output: WeatherFeedViewOutput!

    var tableDirector: TableDirector!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output.didTriggerViewWillDisappear()
    }

    // MARK: WeatherFeedViewInput
    func setupInitialState() {
        configureTableView()
        configureSearchBar()
    }

    private func configureTableView() {
        tableDirector = TableDirector(tableView: tableView)
        self.tableView.es.addPullToRefresh {
            [weak self] in
            self?.output.didTriggerPullToRefresh()
            self?.tableView.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }

    func configureWithItems(items: [WeatherFeedCellObject]) {
        tableDirector.clear()
        let section = TableSection()
        let action = TableRowAction<WeatherFeedCell>(.click) { [weak self] (options) in
            self?.output.didTapCity(options.item.city)
        }
        for item in items {
            section.append(row: TableRow<WeatherFeedCell>(item: item, actions: [action]))
        }
        tableDirector += section
        tableDirector.reload()
    }

    // MARK: UISearchBarDelegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        output.didTriggerSearchEvent("")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.didTriggerSearchEvent(searchText)
    }

}
