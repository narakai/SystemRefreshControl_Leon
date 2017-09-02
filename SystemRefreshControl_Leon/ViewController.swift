//
//  ViewController.swift
//  SystemRefreshControl_Leon
//
//  Created by lai leon on 2017/9/2.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width

class ViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: YHRect, style: .plain)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()

    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .gray

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
//        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH:mm:ss EEEE MMM dd"
        let dateStr = dateFormatter.string(for: NSDate())!
        refreshControl.attributedTitle = NSAttributedString(string: "最后一次更新：\(dateStr)", attributes: [NSForegroundColorAttributeName: UIColor.white])//文字的颜色
        refreshControl.tintColor = .white//菊花的颜色
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        return refreshControl
    }()

    var contents = ["下下下下下", "拉拉拉拉拉", "刷刷刷刷刷", "新新新新新", "哟哟哟哟哟"]
    let news = ["1111", "2222", "3333", "4444", "5555", "6666"]
    let cellIdentifier = "RefreshCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        renderView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    private func renderView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    }

    func updateData() {
        contents.append(contentsOf: news)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ??
                UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = String(indexPath.row + 1) + ": " + contents[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.textLabel?.backgroundColor = .clear
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 30, weight: 10)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


