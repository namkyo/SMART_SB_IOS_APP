//
//  CertListVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/31.
//

import UIKit

class CertListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var complete:((Dictionary<String,Any>) -> Void)? = nil
    var failed:((String,String) -> Void)? = nil
    var parameters:[String:Any] = [:]
    var mode = 1
    
    var certManager: CertManager?
    
    
    @IBAction func 닫기Button(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.failed!("9997","취소")
        })
    }
    override func loadView() {
        super.loadView()
        Log.print("CertListVC loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.print("CertListVC viewDidLoad")
        setupUI()
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("CertListVC viewDidAppear")
        loadToCert()
    }
    
    private func setupUI() {
        let cellNib = UINib(nibName: "CertCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CertCell")
        tableView.separatorStyle = .none
    }
    
    private func loadToCert() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Log.print(message: "서버와의 통신이 원할하지 않습니다. 다시 시도해 주세요.")
            return
        }
        certManager = appDelegate.certManager
        if certManager?.count() == 0 {
            UIApplication.shared.showAlert(message: "등록된 공동인증서가 없습니다.", confirmHandler: {
                self.dismiss(animated: true, completion: {
                    //var resultData : Dictionary<String,String> = [String:String]()
                    self.failed!("9990","등록된 공동인증서가 없습니다.")
                })
            })
        }
        tableView.reloadData()
    }
    
    // Delete 인증서
    private func deleteCertificate(index: Int) {
        guard let ret = certManager?.delCert(Int32(index)), ret else {
            UIApplication.shared.showAlert(message: "삭제에 실패하였습니다.")
            return
        }
        UIApplication.shared.showAlert(message: "삭제되었습니다.")
        loadToCert()
    }
    
    
}
extension CertListVC: CertCellDelegate {
    // 비밀번호 변경 button callback
    func pressChangeCert(indexPath: IndexPath) {
        let vc = CertPwChangeVC.instantiate(storyboard: "CertPwChange")
        vc.indexPath = indexPath
        self.present(vc, animated: true, completion: nil)
    }
    
    // 인증서 삭제 button callback
    func pressDeleteCert(indexPath: IndexPath) {
        Log.print(message: Function.init())
        UIApplication.shared.showAlert(message: "공인인증서를 삭제하시겠습니까?", hideCancel: false, confirmHandler: {
            self.deleteCertificate(index: indexPath.row)
        })
    }
}

extension CertListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(certManager?.count() ?? 0)
    }
    
    // 테이블 뷰 이벤트
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CertCell", for: indexPath) as! CertCell
        let certRowData = certManager?.getCert(Int32(indexPath.row))
        cell.setupCell(cert: certRowData, indexPath: indexPath, delegate: self)
        
        return cell
    }
    
    // 테이블아이템 클릭이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch mode {
            case 1:
                let vc = CertManageVC.instantiate(storyboard: "CertManage")
                vc.certContent=certManager?.getCert(Int32(indexPath.row))
                self.present(vc, animated: true, completion: nil)
                break
            case 2:
                let vc = CertSignVC.instantiate(storyboard: "CertSign")
                vc.certContent=certManager?.getCert(Int32(indexPath.row))
                vc.index=Int32(indexPath.row)
                vc.indexPath = indexPath
                vc.parameters=self.parameters
                vc.certManager=self.certManager
                vc.mode=mode
                vc.complete = {
                    result in
                    Log.print("공동인증 서명 완료 ")
                    self.dismiss(animated: true, completion: {
                        self.complete?(result)
                    })
                }
                vc.failed = {
                    errcd,errMsg in
                    Log.print("errcd : " + errcd)
                    Log.print("errMsg : " + errMsg)
                    UIApplication.shared.showAlert(message: errMsg)
                    //self.dismiss(animated: true, completion: {
                    //    self.failed?(errcd,errMsg)
                    //})
                }
                self.present(vc, animated: true, completion: nil)
                break
                
                //스크랩핑
            case 3:
                let vc = CertSignVC.instantiate(storyboard: "CertSign")
                vc.certContent=certManager?.getCert(Int32(indexPath.row))
                vc.index=Int32(indexPath.row)
                vc.indexPath = indexPath
                vc.mode=mode
                vc.parameters=self.parameters
                vc.certManager=self.certManager
                vc.complete = {
                    result in
                    Log.print("스크래핑 공동인증 서명 완료 ")
                    
                    Scraping().runScraping(params: self.parameters,cert: result
                                           ,handler: {
                                            cd,result in
                                            Log.print("스크랩핑 완료 : \(cd)")
                                            
                                            if cd == "0000"{
                                                self.dismiss(animated: true, completion: {
                                                    self.complete?(result)
                                                })
                                            }
                                           })
                }
                vc.failed = {
                    errcd,errMsg in
                    Log.print("errcd : " + errcd)
                    Log.print("errMsg : " + errMsg)
                    UIApplication.shared.showAlert(message: errMsg)
                    //self.dismiss(animated: true, completion: {
                    //    self.failed?(errcd,errMsg)
                    //})
                }
                self.present(vc, animated: true, completion: nil)
                break
            default:
                Log.print(message: "미등록")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 177
    }
}


