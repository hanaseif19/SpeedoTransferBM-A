import UIKit
import Alamofire

class lastTransactionsVC: UIViewController {

    @IBOutlet weak var lastTransactionsTableView: UITableView!
    var history: [TransactionHana] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
        title = "Transactions"
        
        lastTransactionsTableView.separatorStyle = .none
        lastTransactionsTableView.delegate = self
        lastTransactionsTableView.dataSource = self
        
        let nib = UINib(nibName: "lastTransactionCell", bundle: nil)
        lastTransactionsTableView.register(nib, forCellReuseIdentifier: "lastTransactionCell")
        
        self.GetTransactionHistory()
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
                    self.lastTransactionsTableView.reloadData()
                }

            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - TableView Delegate and DataSource
extension lastTransactionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lastTransactionCell", for: indexPath) as? lastTransactionCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let transaction = history[indexPath.row]
        let senderAcc = transaction.fromAccount
        let receiverAcc = transaction.toAccount
        let amount = transaction.amount
        let date = transaction.timestamp
        let amountString = String(amount)
        
        cell.configureCell(SenderAccount: senderAcc, date: date, receiverAccount: receiverAcc, amount: amountString)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let t = TransactionDetails(date: date , )
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsVC") as! TransactionDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
