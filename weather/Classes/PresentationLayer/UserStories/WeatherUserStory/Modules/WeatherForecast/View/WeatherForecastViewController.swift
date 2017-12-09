//
//  WeatherForecastWeatherForecastViewController.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import TableKit
import ESPullToRefresh
import ViperMcFlurry

class WeatherForecastViewController: UIViewController, WeatherForecastViewInput {

    var output: WeatherForecastViewOutput!

    var tableDirector: TableDirector!

    @IBOutlet var tableView: UITableView!
    
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
        tableDirector.clear()
        let section = TableSection()
        for item in items {
            section.append(row: TableRow<WeatherForecastCell>(item: WeatherForecastCellObject(name: item.day, weather: item.name)))
        }
        tableDirector += section
        tableDirector.reload()
    }

    private func configureTableView() {
        tableDirector = TableDirector(tableView: tableView)
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self?.output.didTriggerPullToRefresh()
            self?.tableView.es_stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }
    }
}
