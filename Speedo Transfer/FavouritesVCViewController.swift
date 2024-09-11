//
//  FavouritesVCViewController.swift
//  Speedo Transfer Project
//
//

import UIKit
import FittedSheets
import Alamofire

class FavouritesVCViewController: UIViewController {
    var arr: [FavoriteData] = []
  
    @IBOutlet weak var favouriteTableView: UITableView!
    let favCell: String = "FavouriteListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerNavigationBarTitle()
        favouriteTableView.dataSource = self
        favouriteTableView.delegate = self
        favouriteTableView.register(UINib(nibName: "FavouriteListCell", bundle: nil), forCellReuseIdentifier: favCell)
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
                        self.favouriteTableView.reloadData()
                    }
                    
                } catch let error {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
    }


    func centerNavigationBarTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Favourite"
        titleLabel.textColor = UIColor.init(named: "FavouriteWordColor")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.sizeToFit()
        self.navigationItem.style = .editor
        navigationItem.titleView = titleLabel
    }
}

extension FavouritesVCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favCell , for: indexPath) as! FavouriteListCell
        cell.delegate = self
        let favorite = arr[indexPath.row]
        cell.configureCell(name: favorite.recipientName ?? "No Name", account: favorite.accountNumber ?? "No Account")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension FavouritesVCViewController: FavouriteListCellDelegate {
    func didTapEditButton(in cell: FavouriteListCell) {
        guard let indexPath = favouriteTableView.indexPath(for: cell) else { return }
        print("Edit button tapped in row \(indexPath.row)")
        
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "EditVC") as? EditVC else {
            print("Could not instantiate EditVC")
            return
        }
        
        let sheetController = SheetViewController(controller: editVC, sizes: [.fixed(500), .percent(0.5), .intrinsic])
        sheetController.cornerRadius = 50
        sheetController.gripColor = UIColor(named: "LabelColor")
        self.present(sheetController, animated: true, completion: nil)
    }
}
