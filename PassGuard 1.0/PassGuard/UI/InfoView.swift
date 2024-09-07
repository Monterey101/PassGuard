//
//  InfoView.swift
//  PassGuard
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        //All info
        VStack (alignment: .leading) {
            Text("")
            
            // Displays the version of the applicaiton in the HStack
            HStack {
                Text("Version:")
                Text("PassGuard 1.0").bold()
            }
            Text("")
            
            //Capacity used
            Text("Total Usage:")
            HStack {
                Text(String(ContentView().numAccounts)).bold()
                if ContentView().numAccounts == 1 {
                    Text("total account")
                }
                else {
                    Text("total accounts")
                }
            }
            //Calculates KB based on data stored within the @AppStorage accounts and cards strings
            HStack {
                Text(String(round((Float(ContentView().Accounts_Array_String.count + ContentView().Cards_Array_String.count))/1024 * 100)/100.0)).bold()
                Text("KB used")
            }
            Spacer()
            
        }.navigationBarTitle(Text("App Info")).frame(width: 350, height: 650, alignment: .leading)
    }
}

//Peviewer
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
