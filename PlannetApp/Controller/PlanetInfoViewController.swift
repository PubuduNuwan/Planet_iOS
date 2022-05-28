//
//  PlanetInfoViewControllrt.swift
//  PlannetApp
//
//  Created by user on 2022-05-28.
//

import UIKit
import RxSwift

class PlanetInfoViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = PlanetInfoViewModel()
    var planetUrl : String?
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = planetUrl {
            viewModel.getPlanetById(url: url)
        }
        
        bindView()
        
    }
    
    private func bindView(){        
        viewModel.planet.asObservable().subscribe(onNext: { planet in
            self.planetImageView.load(url: "https://picsum.photos/200")
            self.nameLabel.text = planet.name
            self.orbitalPeriodLabel.text = planet.orbitalPeriod
            self.gravityLabel.text = planet.gravity
        }).disposed(by: disposeBag)
        
    }
    
}
