//
//  ViewController.swift
//  MoyaSample
//
//  Created by Murali Yarramsetti on 06/08/20.
//  Copyright © 2020 Murali Yarramsetti. All rights reserved.
//

import UIKit
import Moya
class UserViewController: UITableViewController {
    var users = [User]()
    let userProvider = MoyaProvider<UserService>()
    @IBOutlet weak var userTableVIew :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userProvider.request(.readUsers){ (result) in
            switch result {
            case .success(let response):
                let json  = try! JSONSerialization.jsonObject(with: response.data, options:[])
                
                self.users = try! JSONDecoder().decode([User].self , from:response.data)
                self.userTableVIew.reloadData()
                debugPrint(json)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func moyaServiceCall(){
        userProvider.request(.readUsers){ (result) in
            switch result {
            case .success(let response):
                let json  = try! JSONSerialization.jsonObject(with: response.data, options:[])
                
                self.users = try! JSONDecoder().decode([User].self , from:response.data)
                self.userTableVIew.reloadData()
                debugPrint(json)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = userTableVIew.dequeueReusableCell(withIdentifier: "UserTableViewCell")  as? UserTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        let user = users[indexPath.row]
        cell.nameLbl.text = user.name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let tuser = users[indexPath.row]
        
        userProvider.request(.updateUser(id: tuser.id, name: "[Modified]")){ (results) in
            switch results {
            case .success (let response):
                let   modifieduser = try! JSONDecoder().decode(User.self , from:response.data)
                self.users[indexPath.row ] = modifieduser
                self.userTableVIew.reloadData()
                
            case .failure (let error):
                debugPrint(error)
            }
        }
}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        guard editingStyle == .delete else {return }
        let tuser = users[indexPath.row]
        userProvider.request(.deleteUser(id: tuser.id)){ (results) in

            switch results {
            case .success (let response):
                let json  = try! JSONSerialization.jsonObject(with: response.data, options:[])
                debugPrint(json)
                self.users.remove(at: indexPath.row)
                self.userTableVIew.reloadData()
            case .failure (let error):
            debugPrint(error)
        
        }
        }
        
    }
}

