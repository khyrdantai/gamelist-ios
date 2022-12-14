//
//  login.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import UIKit
import Foundation
import SwiftUI

struct login: View {
    
    @StateObject var vm = loginAPI()
    
    @State var jwt_token: String = "empty"
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            Text("Click to login")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setInfo(username: "test", password: "test")
                vm.getData()
            }
            Text(Mem.dm.token)
            Text(Mem.dm.username)
            Text(Mem.dm.id)
            Text(Mem.dm.firstName)
            Text(Mem.dm.lastName)
            Text(Mem.dm.email)
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}

class loginAPI: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    
    func setInfo(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func getData() {
        getJWT {(token, user) in
            Mem.dm.token = token
            Mem.dm.id = user.id
            Mem.dm.verified = user.verified
            Mem.dm.username = user.username
            Mem.dm.firstName = user.firstName
            Mem.dm.lastName = user.lastName
            Mem.dm.email = user.email
        }
    }
    
    func getJWT(completion: @escaping decode_alias) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.login_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["userName": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
            else {
                return
            }
            guard
                error == nil
            else {
                return
            }
            guard
                let data = data
            else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(JWT.self, from: data)
                let payload = decode_jwt(jwt: decodedData.token)
                completion(decodedData.token, payload!)
            } catch {

            }
        }.resume()
    }
    
}

typealias decode_alias = (String, USER) -> Void










