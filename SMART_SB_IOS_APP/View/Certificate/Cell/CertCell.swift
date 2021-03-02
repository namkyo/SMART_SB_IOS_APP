//
//  CertCell.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/22.
//

import UIKit

protocol CertCellDelegate {
    func pressChangeCert(indexPath: IndexPath)
    func pressDeleteCert(indexPath: IndexPath)
}

class CertCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var certImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gubunLabel: UILabel!
    @IBOutlet weak var issureLabel: UILabel!
    @IBOutlet weak var endDtLabel: UILabel!
    @IBOutlet weak var changePwButton: UIButton!
    
    var indexPath: IndexPath!
    var delegate: CertCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupUI() {
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor.lightGray.cgColor
        baseView.layer.cornerRadius = 7
    }
    
    func setupCell(cert: Certificate?, indexPath: IndexPath, delegate: CertCellDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate
        nameLabel.text = cert?.getSubject()
        
        if let item = cert {
            nameLabel.text = item.getSubjectName()
            gubunLabel.text = item.getPolicy()
            issureLabel.text = item.getIssuerNameKorean()
            endDtLabel.text = item.getValidTo2()
            
            // 0:normal, 1:over, 2:almost
            changePwButton.isHidden = item.getCheckExpired() == 1 ? true : false
            
            switch item.getCheckExpired() {
            case 1:
                Log.print(message: "Expired over")
                certImg.image = UIImage(named: "cert_item_off")
                break
            case 2:
                Log.print(message: "Expired almost")
                certImg.image = UIImage(named: "cert_item_on")
                break
            default:
                Log.print(message: "Expired normal")
                certImg.image = UIImage(named: "cert_item_on")
            }
        }
    }
    
    @IBAction func pressChangePw(_ sender: UIButton) {
        delegate?.pressChangeCert(indexPath: indexPath)
    }
    
    @IBAction func pressDeleteCert(_ sender: UIButton) {
        delegate?.pressDeleteCert(indexPath: indexPath)
    }
    
}
