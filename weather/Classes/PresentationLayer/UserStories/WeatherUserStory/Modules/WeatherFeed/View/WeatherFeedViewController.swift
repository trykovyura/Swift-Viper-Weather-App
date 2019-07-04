//
//  WeatherFeedWeatherFeedViewController.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class WeatherFeedViewController: UIViewController, WeatherFeedViewInput, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    var output: WeatherFeedViewOutput!

    let dataSource = RxTableViewSectionedReloadDataSource<WeatherFeedSection>(
            configureCell: { _, tableView, _, item in
                let reuseIdentifier = String(describing: WeatherFeedCell.self)
                var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
                if cell == nil {
                    let nib = UINib(nibName: reuseIdentifier, bundle: nil)
                    tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
                }
                if let currentCell = cell as? WeatherFeedCell {
                    currentCell.configure(with: item)
                }
                return cell!
            })

    var disposeBag = DisposeBag()

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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        output.didTriggerPullToRefresh()
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }

    func configureWithItems(items: [WeatherFeedCellObject]) {
        disposeBag = DisposeBag() //Cancel item select subscribe
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView?.refreshControl?.endRefreshing()
        Observable.just([WeatherFeedSection(items: items)])
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        tableView.rx.modelSelected(WeatherFeedCellObject.self)
                .subscribe(onNext: { [weak self] item in
                    self?.output.didTapCity(item.city)
                    if let index = self?.tableView.indexPathForSelectedRow {
                        self?.tableView.deselectRow(at: index, animated: true)
                    }
                })
                .disposed(by: disposeBag)

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
