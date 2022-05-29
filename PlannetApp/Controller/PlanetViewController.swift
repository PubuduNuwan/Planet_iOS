//
//  ViewController.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import UIKit
import RxSwift
import RxCocoa

class PlanetViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var planetsTableView: UITableView!
    private let disposeBag = DisposeBag()
    
    private let planetViewModel = PlanetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        bindTableView()
        
    }
    
    private func bindTableView() {
        
        planetViewModel.items.bind(to: planetsTableView.rx.items(cellIdentifier: "planet_table_view_cell", cellType: PlanetTableViewCell.self)) { (row,planet,cell) in
            cell.planet = planet
            if row == self.planetViewModel.itemsCount - 2 {
                self.planetViewModel.getPlanets()
            }
            
        }.disposed(by: disposeBag)
        
        planetsTableView.rx.modelSelected(Planet.self).subscribe(onNext: { item in
            self.performSegue(withIdentifier: "to_planet_info_vc", sender: item.url)
            
        }).disposed(by: disposeBag)
        
        planetViewModel.getPlanets()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "to_planet_info_vc" {
            if let vc = segue.destination as? PlanetInfoViewController {
                vc.planetUrl = sender as? String
            }
        }
    }
}


