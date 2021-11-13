//
//  MainVC.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import ReactorKit
import RxViewController

final class MainVC: baseVC<MainReactor>{
    // MARK: - Properties
    private let mainImageView = UIImageView().then {
        $0.image = UIImage(named: "MainHanRiver")
    }
    private let locationButton = UIButton().then {
        $0.setImage(UIImage(named: "Icon_Location"), for: .normal)
    }
    private let logoIcon = UIImageView().then {
        $0.image = UIImage(named: "Icon_Bridge")?.resize(newWidth: 58)
        $0.frame = CGRect(x: 0, y: 0, width: 58, height: 31)
        $0.contentMode = .scaleAspectFit
    }
    private let currentDateLabel = UILabel().then {
        $0.textColor = .white
        $0.dynamicFont(fontSize: 30, fontName: "AppleSDGothicNeo-SemiBold")
    }
    private let currentTempLabel = UILabel().then {
        $0.textColor = .white
        $0.dynamicFont(fontSize: 52, fontName: "AppleSDGothicNeo-light")
    }
    
    // MARK: - Helpers
    override func addView() {
        [mainImageView, locationButton, logoIcon, currentDateLabel, currentTempLabel].forEach{view.addSubview($0)}
    }
    
    override func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        locationButton.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        logoIcon.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        currentDateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(bound.height*0.17)
            $0.trailing.equalToSuperview().inset(10)
        }
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(currentDateLabel.snp.bottom)
            $0.trailing.equalTo(currentDateLabel)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        self.navigationController?.navigationBar.isHidden = true
        setCurrentDateLabel()
    }
    
    private func setCurrentDateLabel(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 hh시"
        self.currentDateLabel.text = "\(dateFormatter.string(from: Date()))"
    }
    
    
    // MARK: - Reactor
    override func bindView(reactor: MainReactor) {
        locationButton.rx.tap
            .map{Reactor.Action.locationDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: MainReactor) {
        self.rx.viewWillAppear
            .map{ _ in Reactor.Action.loadTemp }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: MainReactor) {
        reactor.state.observe(on: MainScheduler.instance)
            .subscribe(onNext: { s in
                self.currentTempLabel.text = "\(s.temp ?? "")°C"
            })
            .disposed(by: disposeBag)
    }
    
}

