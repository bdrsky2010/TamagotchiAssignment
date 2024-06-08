//
//  TamagotchiViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import UIKit
import SnapKit

final class TamagotchiViewController: UIViewController, ConfigureViewProtocol {
    
    let tamagotchiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    private var tamagotchies: [Tamagotchi] = []
    
    public var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.tamagotchiBackgroundColor
        print(#function)
        
        tamagotchies = userDefaultsHelper.getTamagochi()
        
        configureHierarchy()
        configureLayout()
        configureCollectionView()
    }
    
    func configureHierarchy() {
        view.addSubview(tamagotchiCollectionView)
    }
    
    func configureLayout() {
        tamagotchiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        tamagotchiCollectionView.delegate = self
        tamagotchiCollectionView.dataSource = self
        tamagotchiCollectionView.register(TamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: TamagotchiCollectionViewCell.identifier)
        tamagotchiCollectionView.backgroundColor = .clear
        tamagotchiCollectionView.showsVerticalScrollIndicator = false
    }
}

extension TamagotchiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 16
        let width: CGFloat = (collectionView.bounds.width - (margin * 6)) / 3
        let height: CGFloat = width * 1.4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let tamagotchi = tamagotchies[indexPath.row]
        
        if tamagotchi.isAvailable {
            let tamagotchiPopupViewController = TamagotchiPopupViewController()
            tamagotchiPopupViewController.tamagotchi = tamagotchies[indexPath.row]
            
            // MARK: fullScreen vs overFullScreen
            // 'fullScreen'은 부모뷰를 모달 뷰가 다 가려버리는 modal style
            // 'overFullScreen'은 fullScreen처럼 모달 뷰가 다 가리긴하지만 배경색이 투명해지며
            // 부모뷰의 일부분이 보임
            tamagotchiPopupViewController.modalPresentationStyle = .overFullScreen
            present(tamagotchiPopupViewController, animated: true)
        }
    }
}

extension TamagotchiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as? TamagotchiCollectionViewCell else { return UICollectionViewCell() }
        let index = indexPath.row
        cell.tamagotchi = tamagotchies[index]
        cell.configureContent()
        return cell
    }
}
