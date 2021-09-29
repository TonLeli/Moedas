//
//  TableViewCell.swift
//  Moedas
//
//  Created by user on 13/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24))
    }

}
