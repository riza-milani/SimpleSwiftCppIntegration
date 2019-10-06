//
//  ViewController.swift
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol {
    func showErrorMessage(message: String)
}

class ViewController: UIViewController {

    var presenter: PresneterProtocol?
    var tableView: UITableView!
    var tableViewData: [TableViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var activityIndicatorView: UIActivityIndicatorView!
    let noDataLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createTableView()
        presenter?.fetchNumbers { [weak self] tableViewData in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.hidesWhenStopped = true
            self?.tableViewData = tableViewData
        }
    }

    func createTableView() {
        tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicatorView.color = .gray
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SECTION\(tableViewData[section].key)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self)) as? TableViewCell else {
            return UITableViewCell()
        }
        let value = tableViewData[indexPath.section].value[indexPath.row]
        cell.itemLabel?.text = "Item\(value.0)"
        (value.1 == true) ? (cell.checkMarkLabel.isHidden = false) : (cell.checkMarkLabel.isHidden = true)
        return cell
    }
    
    
}

extension ViewController: ViewControllerProtocol {
    
    func showErrorMessage(message: String) {

        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()

        noDataLabel.frame = view.frame
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 0
        noDataLabel.text = message
        tableView.backgroundView = noDataLabel
    
    }
}
