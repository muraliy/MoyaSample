//
//  UserService.swift
//  MoyaSample
//
//  Created by Murali Yarramsetti on 06/08/20.
//  Copyright © 2020 Murali Yarramsetti. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case createUser(name:String)
    case readUsers
    case updateUser(id:Int , name: String)
    case deleteUser(id : Int)
}

extension UserService  : TargetType {
    var baseURL: URL {
        return URL(string: "BaseUrl")!
    }
    
    var path: String {
        switch self {
        case .readUsers , .createUser(_):
            return "/extension"
        case  .deleteUser(let id) , .updateUser( let id,_) :
            return "/\(id)"
        default:
            break
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser(_):
          return  .post
        case .readUsers:
          return  .get
        case .updateUser(_ , _):
            return . put
        case .deleteUser(_):
            return .delete
        default:
            break
        }
    }
   
    var sampleData: Data {
        switch self {
        case .createUser(let name):
            return "{'parameterName':'\(name)'}".data(using: .utf8)!
        case .readUsers:
        return Data()
        case .updateUser(let id , let name):
            return "{'parameterName':'\(id)','parameterName':'\(name)'}".data(using: .utf8)!
            
        case .deleteUser(let id):
            return "{'parameterName':'\(id)'}".data(using: .utf8)!

        default:
            break
        }
    }
    
    var task: Task {
        switch self {
        case .readUsers , .deleteUser(_):
            return .requestPlain
            
        case .createUser(let name) , .updateUser(_ , let name):
            return .requestParameters(parameters: ["name":name], encoding: JSONEncoding.default)
        default:
            break
        }
    }
    
    var headers: [String : String]? {
        return ["Content_Typer" : "application/json"]
    }
    
    
}

