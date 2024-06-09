//
//  SettingViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/9/24.
//

import UIKit

final class SettingViewController: UIViewController, ConfigureViewProtocol {

    let settingTableView = UITableView()
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    private var settingList: [Setting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingList = [
            Setting(mainImage: "pencil", mainTitle: "내 이름 설정하기", subTitle: userDefaultsHelper.getNickname()),
            Setting(mainImage: "moon.fill", mainTitle: "다마고치 변경하기", subTitle: nil),
            Setting(mainImage: "arrow.clockwise", mainTitle: "데이터 초기화", subTitle: nil)
        ]
        
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingList[0] = Setting(mainImage: "pencil", mainTitle: "내 이름 설정하기", subTitle: userDefaultsHelper.getNickname())
        
        settingTableView.reloadData()
    }
    
    func configureNavigation() {
        view.backgroundColor = UIColor.tamagotchiBackgroundColor
        navigationItem.title = "설정"
    }
    
    func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.rowHeight = 50
        settingTableView.backgroundColor = .clear
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == 0 {
            
            let nicknameSettingViewcontroller = NicknameSettingViewController()
            navigationController?.pushViewController(nicknameSettingViewcontroller, animated: true)
        } else if index == 1 {
            
            let tamagotchiSelectViewController = TamagotchiSelectViewController()
            tamagotchiSelectViewController.tamagotchiSelectType = .change
            navigationController?.pushViewController(tamagotchiSelectViewController, animated: true)
        } else {
            
            // 1. alert 창 구성
            let title = "데이터 초기화"
            let message = "정말 다시 처음부터 시작하실 건가용?"
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            // 2. alert button 구성
            let reset = UIAlertAction(title: "웅", style: .default) { [weak self] action in
                guard let self else { return }
                
                userDefaultsHelper.resetTamagochi()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationCenterName.resetButton), object: nil)
            }
            let cancel = UIAlertAction(title: "아냐!", style: .cancel)
            
            // 3. alert에 button 추가
            alert.addAction(reset)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        let setting = settingList[indexPath.row]
        cell.configureCellContent(setting)
        return cell
    }
}
