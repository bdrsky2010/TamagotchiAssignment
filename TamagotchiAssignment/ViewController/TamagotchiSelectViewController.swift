//
//  TamagotchiViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import UIKit
import SnapKit

final class TamagotchiSelectViewController: UIViewController, ConfigureViewProtocol {
    
    private let tamagotchiCollectionView: UICollectionView = {
        let collectioViewLayout: UICollectionViewFlowLayout = {
            
            let layout = UICollectionViewFlowLayout()
            let sectionSpacing: CGFloat = 16
            let cellSpacing: CGFloat = 12
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let width: CGFloat = windowScene.screen.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
                layout.minimumLineSpacing = cellSpacing
                layout.minimumInteritemSpacing = cellSpacing
                layout.itemSize = CGSize(width: width / 3, height: width / 2.5)
                layout.sectionInset = UIEdgeInsets(
                    top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            }
            return layout
        }()
        return UICollectionView(frame: .zero, collectionViewLayout: collectioViewLayout)
    }()
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    private var tamagotchies: [Tamagotchi] = []
    
    private lazy var navigationTitle = tamagotchiSelectType?.naviagtionTitle
    
    var tamagotchiSelectType: TamagotchiUsed.TamagotchiSelectType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBackgroundColor
        
        tamagotchies = userDefaultsHelper.getTamagotchies()
        configureHierarchy()
        configureLayout()
        configureNavigation()
        configureCollectionView()
    }
    
    func configureHierarchy() {
        view.addSubview(tamagotchiCollectionView)
    }
    
    func configureLayout() {
        tamagotchiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = navigationTitle
        navigationController?.configureTamagotchiStyle()
        navigationController?.navigationBar.tintColor = TamagotchiUsed.Color.tamagotchiBorderColor
        if navigationController?.topViewController != self {
            let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(leftBarButtonAction))
            
            navigationItem.leftBarButtonItem = leftBarButton
        }
    }
    
    @objc
    private func leftBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureCollectionView() {
        tamagotchiCollectionView.delegate = self
        tamagotchiCollectionView.dataSource = self
        tamagotchiCollectionView.register(TamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: TamagotchiCollectionViewCell.identifier)
        tamagotchiCollectionView.backgroundColor = .clear
        tamagotchiCollectionView.showsVerticalScrollIndicator = false
    }
}

extension TamagotchiSelectViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let tamagotchi = tamagotchies[indexPath.row]
        
        if tamagotchi.isAvailable {
            let tamagotchiPopupViewController = TamagotchiPopupViewController()
            tamagotchiPopupViewController.tamagotchi = tamagotchies[indexPath.row]
            tamagotchiPopupViewController.tamagotchiSelectType = tamagotchiSelectType
            // MARK: fullScreen vs overFullScreen
            // 'fullScreen'은 부모뷰를 모달 뷰가 다 가려버리는 modal style
            // 'overFullScreen'은 fullScreen처럼 모달 뷰가 다 가리긴하지만 배경색이 투명해지며
            // 부모뷰의 일부분이 보임
            tamagotchiPopupViewController.modalPresentationStyle = .overFullScreen
            present(tamagotchiPopupViewController, animated: true)
        }
    }
}

extension TamagotchiSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as? TamagotchiCollectionViewCell else { return UICollectionViewCell() }
        let index = indexPath.row
        let tamagotchi = tamagotchies[index]
        cell.configureContent(tamagotchi)
        return cell
    }
}
