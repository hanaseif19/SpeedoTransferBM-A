//
//  HomeVC.swift
//  Speedo Transfer
//


import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var InitialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var recentTransactions : [Transaction] = []
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
        homeTableView.allowsSelection = false
        homeTableView.isScrollEnabled = false
        nameLabel.text=CurrentUser.shared.name 
        let name = CurrentUser.shared.name ?? "N A"

        let initials = name.split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()

        InitialsLabel.text = initials.uppercased()
      
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
        }
            
       
        

    }
    
    func setUpRecentTransactions() {
        let transaction1 = Transaction(recipientName: "khalid", MasterCardId: "1456", amount: "1500", date: "Today 12:00 - Recived")
        recentTransactions.append(transaction1)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
