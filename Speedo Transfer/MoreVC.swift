//
//  MoreVC.swift
//  Speedo Transfer
//
//  Created by Hana Seif on 09/09/2024.
//
//HIhi12345678
import UIKit
import FittedSheets
class MoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func FavouritesBtnTappes(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "favouritsVC") as! favouritsVC
        self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func TransferButton(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "transferAmountVC") as! transferAmountVC
        self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func HelpButton(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
       
            
            let sheetController = SheetViewController(controller: page, sizes: [.fixed(500), .percent(0.5), .intrinsic])
            sheetController.cornerRadius = 50
            sheetController.gripColor = UIColor(named: "LabelColor")
            self.present(sheetController, animated: true, completion: nil)
        
        
    }
    @IBAction func LogOutButton(_ sender: Any) {
        self.showLogoutAlert {
            let SignIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
            self.navigationController?.pushViewController(SignIn, animated: true)
        }
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
