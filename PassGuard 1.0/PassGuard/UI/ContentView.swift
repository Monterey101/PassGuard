//
//  ContentView.swift
//  PassGuard
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage ("userID") public var GLB_Account_Id: Int = 0                                   //Holds the ID of the account currently logged in
    @AppStorage ("loginStatus") public var Logged_In: Bool = false                              //Current login status
    
    @AppStorage ("accounts") public var Accounts_Array_String: String = ""                      //String holding all accounts data
    @AppStorage ("numAccounts") public var numAccounts: Int = 0                                 //Holds total number of accounts IN USE
    @AppStorage ("cards") var Cards_Array_String: String = ""                                   //String holding all cards data
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                //Main Logo
                Image(systemName: "lock.shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
                Text("PassGuard")
                    .foregroundColor(.blue)
                    .scaleEffect(2)
                
                Spacer()
                
                //Login button
                NavigationLink (destination: LoginView().navigationTitle("Login"), label: {
                    Text("Login")
                        .bold()
                        .frame(width: 90, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                })
                
                //Sign up button
                NavigationLink (destination: SignUpView().navigationTitle("Create New Account"), label: {
                    Text("Sign Up")
                        .bold()
                })
                
                //Navigates user straight to main menu if they are already logged in
                NavigationLink(isActive: $Logged_In, destination: {
                    CardsView()
                }, label: {
                    EmptyView()
                })
                
                Spacer()
                
                //App info button
                HStack {
                    NavigationLink(destination: {
                        InfoView()
                    }, label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .leading)
                    })
                    Spacer()
                }.padding(30)
            }.navigationBarBackButtonHidden(true)
        }
    }
}

//Previewer
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
