//
//  HomeVC.swift
//  Speedo Transfer
//


import UIKit
import Alamofire

class HomeVC: UIViewController {

  
    @IBOutlet weak var InitialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var history: [TransactionHana] = []
   // var recentTransactions : [Transaction] = []
    var hiddenFlag:Bool = true
    
    @IBOutlet weak var homeTableView: UITableView!   
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var hiddenBalanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAccountBalance()
       //UserDefaultsManager.shared().isLoggedIn = true
        self.navigationItem.hidesBackButton = true
        hiddenBalanceButton.layer.cornerRadius = hiddenBalanceButton.frame.width/2
        hiddenBalanceButton.layer.masksToBounds = true
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
      
        
        let nib = UINib(nibName: "HomeTransactionTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "HomeTransactionTableViewCell")
        homeTableView.allowsSelection = false
        homeTableView.isScrollEnabled = false
        nameLabel.text=CurrentUser.shared.name 
        let name = CurrentUser.shared.name ?? "N A"

        let initials = name.split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()

        InitialsLabel.text = initials.uppercased()
        let pullToRefreshGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePullToRefresh))
               view.addGestureRecognizer(pullToRefreshGesture)
        self.GetTransactionHistory()
      
    }
    
    @objc func handlePullToRefresh(_ gesture: UIPanGestureRecognizer) {
           if gesture.state == .ended {
               updateView()
           }
       }
    func GetTransactionHistory()  {
        guard let token = Session.shared.authToken else {
            print("No auth token available")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("https://banquemisr-transfer-service.onrender.com/api/transactions/history",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .response { response in
            if let error = response.error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = response.data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TransactionHistoryResponse.self, from: data)
                let arr = decodedResponse.transactions
                self.history.removeAll()
                self.history.append(contentsOf: arr)
                
                print("Transactions fetched: \(self.history.count)")
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }

            } catch let error {
                print("Home Error Decoding error: \(error.localizedDescription)")
            }
        }
    }
       func updateView() {
           fetchAccountBalance()
       }
    private func fetchAccountBalance() {
        // Use the token from the Session singleton
        let token = Session.shared.authToken ?? "N/A"
        
        if token.isEmpty {
            print("Token is empty")
            self.balanceLabel.text = "1000 EG"
            return
        }
        else
        {   self.balanceLabel.text = "\(CurrentUser.shared.accounts[0].balance ?? 1200) EG"
            self.nameLabel.text = CurrentUser.shared.name
            let initials =  self.nameLabel.text!.split(separator: " ")
                .compactMap { $0.first }
                .map { String($0) }
                .joined()

            self.InitialsLabel.text = initials.uppercased()
        }
            
       
        

    }
    
    func setUpRecentTransactions() {
       
            guard let token = Session.shared.authToken else {
                print("No auth token available")
                return
            }

            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            
            AF.request("https://banquemisr-transfer-service.onrender.com/api/transactions/history",
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .response { response in
                if let error = response.error {
                    print("Request error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = response.data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(TransactionHistoryResponse.self, from: data)
                    let arr = decodedResponse.transactions
                    for t in arr {
                        
                      
                        self.history.append(t)
                        
                       
                    }
                    
                   

                } catch let error {
                    print("HOME VC Decoding error: \(error.localizedDescription)")
                }
            }
        }
    

      
    
    
    @IBAction func hiddenBalanceBTN(_ sender: Any) {

        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = balanceLabel.bounds
        blurView.layer.cornerRadius = 15
        blurView.layer.masksToBounds = true
        
        if hiddenFlag == true {
            
            balanceLabel.addSubview(blurView)
           
            
            hiddenBalanceButton.setImage(UIImage.init(systemName: "eye.slash.fill"), for: .normal)
            
            hiddenFlag = false
        } else {
            
            for view in self.balanceLabel.subviews {
                view.removeFromSuperview()
            }
                        
            hiddenBalanceButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
            
            hiddenFlag = true
        }
    }
    

    @IBAction func viewAllTransactionsBtnTapped(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 2
    }
    
    
    @IBAction func transferBtnTapped(_ sender: Any) {
        let transfer = self.storyboard?.instantiateViewController(withIdentifier: "transferAmountVC") as! transferAmountVC
           self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func transactionBtnTapped(_ sender: Any) {
        let transaction = self.storyboard?.instantiateViewController(withIdentifier: "lastTransactionsVC") as! lastTransactionsVC
             self.tabBarController?.selectedIndex = 2
    }
    

    @IBAction func accountBtnTapped(_ sender: Any) {
        let account = self.storyboard?.instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
        self.navigationController?.pushViewController(account, animated: true)
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
    
        let notivication = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
           self.navigationController?.pushViewController(notivication, animated: true)
    }   
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTransactionTableViewCell", for: indexPath) as! HomeTransactionTableViewCell
        cell.selectionStyle = .none
       
           let transaction = history[indexPath.row]
           let senderAcc = transaction.fromAccount
           let receiverAcc = transaction.toAccount
           let amount = transaction.amount
           let date = transaction.timestamp
           let amountString = String(amount)
        
        cell.configureCell(senderAcc: senderAcc, Racc: receiverAcc, datee: date, amount: amountString)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
