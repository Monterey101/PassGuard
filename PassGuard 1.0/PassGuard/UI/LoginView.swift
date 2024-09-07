//
//  LoginView.swift
//  PassGuard
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username:String = ""                                                     //Entered Username
    @State private var password:String = ""                                                     //Entered Password
    
    @State private var success:Bool = false                                                     //Flag: Successful login status
    @State private var tried: Bool = false                                                      //Flag: Attempt used status
    @State private var notPossible = false                                                      //Flag: Invalid input for Username / Password
    
    var body: some View {
        VStack {
            Form {
                
                //Username field
                Section (header: Text("Username")){
                    TextField ("Username", text: $username)
                }
                
                //Password field
                Section (header: Text("Password")) {
                    SecureField("Password", text: $password)
                }
                
                if notPossible {
                    Text("You must enter both a username and password").foregroundColor(.red)   //Error message for invalid input
                }
                else if tried == true && success == false {
                    Text("Incorrect Username / Password").foregroundColor(.red)                 //Error message for incorrect Username / Password
                }
            }
            
            Button(action: {
                tried = true
                if username == "" || password == "" {                                           //Checks if entered username / password is empty
                    notPossible = true                                                          //Raise error flag is empty
                }
                else {
                    notPossible = false                                                         //Otherwise lower error flag
                }
                if Login(username, password) {                                                  //Try to establish connection with entered values
                    success = true                                                              //Raise successful connection flag
                    ContentView().Logged_In = true                                              //Set app login status to TRUE
                }
            }, label: {
                
                if username == "" || password == "" {
                    Text("Login").bold()
                        .frame(width: 350, height: 44, alignment: .center)
                        .cornerRadius(50)
                        .background(.gray)
                        .foregroundColor(.white).cornerRadius(22)                               //Input is INVALID
                }
                else {
                    Text("Login").bold()
                        .frame(width: 350, height: 44, alignment: .center)
                        .cornerRadius(50)
                        .background(.blue)
                        .foregroundColor(.white).cornerRadius(22)                               //Input is VALID
                }
                
                
            })
                .padding()
                .disabled(username == "" || password == "")                                     //Disable the button if either field is empty
            
        }.onAppear {
            tried = false                                                                       //Reset UI by forgetting previous attempt
            success = false                                                                     //Success status is set to FALSE by default
        }
    }
}

//Previewer
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
