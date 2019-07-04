//
//  WeatherForecastWeatherForecastViewController.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import ViperMcFlurry
import RxDataSources
import RxCocoa
import RxSwift

class WeatherForecastViewController: UIViewController, WeatherForecastViewInput {

    var output: WeatherForecastViewOutput!

    @IBOutlet var tableView: UITableView!

    let disposeBag = DisposeBag()

    let dataSource = RxTableViewSectionedReloadDataSource<ForecastSection>(
            configureCell: { _, tableView, _, item in
                let reuseIdentifier = String(describing: WeatherForecastCell.self)
                var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
                if cell == nil {
                    let nib = UINib(nibName: reuseIdentifier, bundle: nil)
                    tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
                }
                if let currentCell = cell as? WeatherForecastCell {
                    currentCell.configure(with: item)
                }
                return cell!
            })

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: WeatherForecastViewInput
    func setupInitialState(_ city: CityPlainObject) {
        title = city.name
        configureTableView()
    }

    func configureWithItems(_ items: [ForecastPlainObject]) {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView?.refreshControl?.endRefreshing()
        Observable.just([ForecastSection(items: items.map { forecast in
                    WeatherForecastCellObject(name: forecast.day, weather: forecast.name)
                })])
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
    }

    private func configureTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        output.didTriggerPullToRefresh()
    }
}
