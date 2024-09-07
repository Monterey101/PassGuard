//
//  OnboardingView.swift
//  PassGuard
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        //Guide is divided in tabs that the user must swipe through
        TabView {
            
            //Welcome Page
            VStack {
                Spacer()
                Image (systemName: "lock.shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
                Text("Welcome to PassGuard").font(.system(size: 25))
                Spacer()
                Text("Heres a quick guide to get started")
                Text("Swipe across →")
                Text("")
                Text("")
                Spacer()
            }
            
            //How to create an account
            VStack {
                Image ("Sign_Up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("First, create an account").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //How to login
            VStack {
                Image ("Login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("Then login").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //How to create cards
            VStack {
                Image ("Create_A_Card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("Click the + to add a card").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //How to view cards
            VStack {
                Image ("View_A_Card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("Click a card to view it").font(.system(size: 25))
                Text("")
                Text("")
                
            }
            
            //Other card options
            VStack {
                Image ("Card_Toolbar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                Text("Favourite, Delete or Edit cards").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //How to filter through cards
            VStack {
                Image ("Filtering_Cards")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                Text("Filter by favourites or search").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //How to view the user profile
            VStack {
                Image ("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("View and edit your profile").font(.system(size: 25))
                Text("")
                Text("")
            }
            
            //End of tutorial
            VStack {
                Spacer()
                Image (systemName: "lock.shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue)
                Text("Simple as that!").font(.system(size: 25))
                Text("").foregroundColor(.white)
                Text("").foregroundColor(.white)
                Text("").foregroundColor(.white)
                Text("").foregroundColor(.white)
                Spacer()
                
                Button (action: {
                    PassGuardApp().onboarded = true
                }, label: {
                    Text("Get Started!").font(.system(size: 25))
                })
                Spacer()
            }
        }.tabViewStyle(PageTabViewStyle())
    }
}

//Previewer
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
