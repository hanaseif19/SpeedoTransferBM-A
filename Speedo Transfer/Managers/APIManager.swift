//
//  APIManager.swift
//  Speedo Transfer
//
//  Created by Hana Seif on 10/09/2024.
//

//
//  APIManager.swift
//  AuthenticationApp
//
//  Created by Hana Seif on 02/09/2024.
//

import Foundation
import Alamofire
class APIManager
{
//    static func loadShowData(completion : @escaping ( _ error: Error? , _ arrOfItunes: [iTunes]?)->(),_ term: String)
//    {
//        AF.request("https://itunes.apple.com/search",method:.get, parameters:["media":"movie", "term":term], headers:nil).response {
//            response in
//            
//            guard let data = response.data // we got results back
//            else
//            {
//                completion(response.error,nil)
//                return
//            }
//            do {
//                let decoder=JSONDecoder()
//                let itunesResponse = try decoder.decode(iTunesResponse.self, from: data)
//                let arrOfResults=itunesResponse.results
//                completion(nil,arrOfResults)
//                for iTunes in arrOfResults{
//                    print(iTunes.imageURL ?? "N/A")
//                }
//            }
//            catch let error {
//                print(error.localizedDescription)
//            }
//            
//        }
//    }
//    
    // copy
    static func PostRegisterationData (user: UserRegistrationRequest)
    {
////        {
//        "name": "hana",
//        "email": "h@gmail.com",
//        "password": "Hh12345",
//        "confirmPassword": "Hh12345",
//        "country": "EG",
//        "birthDate": "2024-09-08"
//       }
        let param: [String:Any] = ["name": user.name,
                                   "email" : user.email ,
                                   "password" :user.password,
                                   "confirmPassword" : user.confirmPassword,
                                   "country" : user.country,
                                   "birthDate": user.birthDate
                            
        ]
        
        AF.request("https://banquemisr-transfer-service.onrender.com/api/auth/register",method:.post, parameters:param,encoding: JSONEncoding.default).response {
            response in
            
            guard let data = response.data
            else
            {
               
                return
            }
            do {
                let decoder=JSONDecoder()
                let response = try decoder.decode(PostRegisterBaseResponse.self, from: data)
                print(response.httpStatus ?? "N/A")
//              
               }
            
            catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
}

