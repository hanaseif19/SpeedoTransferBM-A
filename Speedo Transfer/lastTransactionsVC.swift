//
//  lastTransactionsVC.swift
//  Speedo Transfer
//
//

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
        lastTransactionsTableView.dataSource =  self
        let nib = UINib(nibName: "lastTransactionCell", bundle: nil)
        lastTransactionsTableView.register(nib, forCellReuseIdentifier: "lastTransactionCell")
       // self.GetTransactionHistory()
      
      //  print("size" , history?.transactions.count)
    }
     func GetTransactionHistory()  {
        let token=Session.shared.authToken
        
//        let param: [String: Any] = [
//            "page": 0,
//            "size": 10
//        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token ??  "ABC")"
        ]
        AF.request("https://banquemisr-transfer-service.onrender.com/api/transactions/history",
                   method: .get,
//                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers:headers)
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
                let array=decodedResponse.transactions
                for t in array {
                    print(t.amount)
                    print(t)
                    self.history.append(t)
                }
                print("size is ", self.history.count)
                self.lastTransactionsTableView.reloadData()
//                self.history = decodedResponse
//                let lastVC =   UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lastTransactionsVC") as! lastTransactionsVC
           
            
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
            }
          
        }
    }

   

}
extension lastTransactionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "lastTransactionCell", for: indexPath) 
        cell.selectionStyle = .none
//        let senderAcc = (history[indexPath.row].fromAccount)
//        let ReceiverAcc = history[indexPath.row].toAccount
//       let amount = history[indexPath.row].amount
//        let date=history[indexPath.row].timestamp
//        let amountString=String(amount)
//        cell.configureCell(SenderAccount: senderAcc , date: date, receiverAccount: ReceiverAcc, amount: amountString)

        
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionDetailsVC") as! TransactionDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 140
       }
       

    
    
    }
