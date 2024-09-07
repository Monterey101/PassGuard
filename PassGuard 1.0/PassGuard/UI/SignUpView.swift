//
//  SignUpView.swift
//  PassGuard
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username:String = ""                                                     //New Username
    @State private var password:String = ""                                                     //New Password
    
    @State private var success = false                                                          //Flag: Success status
    @State private var notPossible = false                                                      //Flag: Determines if any text field is empty
    @State var showInfo = false                                                                 //Flag: Preference to show info about Password Strength
    @State var showPass = false                                                                 //Flag: Preference to reveal/hide password
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    //Username text field
                    Section (header: Text("Username")){
                        TextField ("New Username", text: $username)
                    }
                    Section (header: Text("Password")) {
                        HStack {
                            //Password text field
                            if showPass {
                                TextField ("New Password", text: $password)
                            }
                            else {
                                SecureField ("New Password", text: $password)
                            }
                            
                            Spacer()
                            
                            //Toggle between revealing/hiding password
                            Button(action: {
                                showPass.toggle()
                            }, label: {
                                if showPass {
                                    Image(systemName: "eye")
                                }
                                else {
                                    Image(systemName: "eye.slash")
                                }
                            })
                        }
                        HStack {
                            //Password Strength
                            Text(String(Find_Strength(password))).foregroundColor(Find_Colour(Find_Strength(password)))
                            
                            Spacer()
                            
                            //Password Strength info button
                            Button(action: {
                                showInfo.toggle()
                            }, label: {
                                Image(systemName: "questionmark.circle")
                            })
                        }
                    }
                    
                    //Empty text field(s) warning
                    if notPossible {
                        Text("You must enter both a username and password").foregroundColor(.red)
                    }
                    
                    //Invalid username warning
                    if Check_Valid_Account(username) == false && success == false && username != "" {
                        Text("Username is taken").foregroundColor(.red)
                    }
                    
                    //Successful login message
                    if success == true {
                        Text("Account Successfully Created").foregroundColor(.green)
                    }
                }
                
                //Create Account Button
                Button(action: {
                    if success == false {
                        if Create_Account(username, password) {                                     //If account is successfully created
                            ContentView().numAccounts += 1                                          //Add 1 to total number of accounts
                            notPossible = false                                                     //Textfields are possible
                            success = true                                                          //Success is set to TRUE
                        }
                    }
                    if username == "" || password == "" {                                           //If either username OR password fields is empty
                        notPossible = true                                                          //Textfields are NOT possible
                    }
                    else {
                        notPossible = false                                                         //Otherwise Textfields ARE possible
                    }
                }, label: {
                    
                    if username == "" || password == "" {                                           //If either username OR password fields is empty
                        Text("Create Account").bold()
                            .frame(width: 350, height: 44, alignment: .center)
                            .cornerRadius(50)
                            .background(.gray)
                            .foregroundColor(.white).cornerRadius(22)                               //Textfields are NOT possible
                    }
                    else {
                        Text("Create Account").bold()
                            .frame(width: 350, height: 44, alignment: .center)
                            .cornerRadius(50)
                            .background(.blue)
                            .foregroundColor(.white).cornerRadius(22)                               //Otherwise Textfields ARE possible
                    }
                })
                    .padding()
                    .disabled(username == "" || password == "")
                
            }
            
            //Message explaining the password strength
            if showInfo {
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 300, height: 200)
                            .cornerRadius(25)
                            .shadow(radius: 25)
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    showInfo = false
                                }, label: {
                                    Image(systemName: "xmark").foregroundColor(.red)
                                })
                                Text("             ")
                            }
                            
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            Text("a").foregroundColor(.white)                                       //Matching displacement of the message
                            Text("a").foregroundColor(.white)
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            
                        }
                        VStack {
                            Text("Password Strength")
                                .bold()
                            Text("")
                            Text("")
                            Text("Your 'Password Strength' is")
                            Text("a score out of 10 showing how")                                   //Description of Password Strength
                            Text("secure your password is.")
                            Text("")
                            Text("")
                            
                            Button(action: {
                                showInfo = false
                            }, label: {
                                Text("OK").foregroundColor(.blue)
                            })
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

//Previewer
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
