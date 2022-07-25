//
//  RegisterPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//


import SwiftUI

struct RegisterPage : View {
    
    @State var email: String = ""
    @State var first_name: String = ""
    @State var last_name: String = ""
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirm_password: String = ""
    
    @StateObject var reg = registerAPI()
    
    @ObservedObject var dmv = Mem.dm
    
    @State var reg_pressed = false
    
    
    var body: some View {
        
        VStack () {

            Form {
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirm_password)
                }
                
                Section(header: Text("Info")) {
                    TextField("First Name", text: $first_name)
                    TextField("Last Name", text: $last_name)
                    TextField("Email", text: $email)
                }
                
                // add text here for confirmation or error message
                
                
            }
            
            Button(action: {
                reg.setInfo(user: username, pass: password, first: first_name, last: last_name, email: email)
                reg.sendData()
            }) {
                DoRegisterButton()
            }
        }
        .navigationTitle(Text("Register"))
    }
}



struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}


struct DoRegisterButton: View {
    var body: some View {
        Text("Register")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

