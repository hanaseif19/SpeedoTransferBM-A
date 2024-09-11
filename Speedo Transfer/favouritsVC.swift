import UIKit
import Alamofire

class favouritsVC: UIViewController {

    @IBOutlet weak var favoritsTableView: UITableView!
    var arr: [FavoriteData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        favoritsTableView.delegate = self
        favoritsTableView.dataSource = self
        favoritsTableView.separatorStyle = .none
        favoritsTableView.register(UINib(nibName: "favoritsTableViewCell", bundle: nil), forCellReuseIdentifier: "favoritsTableViewCell")
        bindTableDate()
    }

    func bindTableDate() {
        let token = Session.shared.authToken
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token ?? "ABC")"
        ]

        AF.request("https://banquemisr-transfer-service.onrender.com/api/favourites",
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
                    let decodedResponse = try decoder.decode([FavoriteData].self, from: data)
                    
                    // Update the array and reload the table view on the main thread
                    DispatchQueue.main.async {
                        self.arr = decodedResponse
                        self.favoritsTableView.reloadData()
                    }
                    
                } catch let error {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
    }
}

extension favouritsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritsTableView.dequeueReusableCell(withIdentifier: "favoritsTableViewCell", for: indexPath) as? favoritsTableViewCell else {
            return UITableViewCell()
        }
        
        let favorite = arr[indexPath.row]
        cell.configureCell(name: favorite.recipientName ?? "No Name", account: favorite.accountNumber ?? "No Account")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}
