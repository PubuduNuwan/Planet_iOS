//
//  PlanetTableViewCell.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetClimate: UILabel!
    
    var planet : Planet? = nil {
        didSet {
            planetName.text = planet?.name
            planetClimate.text = planet?.climate
            planetImageView.load(url: "https://picsum.photos/200")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
