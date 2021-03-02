//
//  CertListCell.swift
//  JTSB
//
//  Created by 최지수 on 02/05/2020.
//  Copyright © 2020 CJS. All rights reserved.
//

import UIKit

class CertListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView(index: Int) {
        
      //  if let item = RSKSWCertManager.getInstance()?.getCert(Int32(index)) {
       //     nameLabel.text = item.getSubjectCn()//
       //     contentLabel.text = item.getPolicy() + "/" + item.getIssuerCnKorean()
      //      dateLabel.text = item.getNotAfter()
      //  }
    }

}
