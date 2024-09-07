//
//  Objects.swift
//  PassGuard
//

import Foundation
import SwiftUI

/// Object which the user creates and logs into to access their cards
class Account {
    var AccountUsername: String                                                                 //Username of the account
    var AccountPassword: String                                                                 //Password of the account
    var ProfilePictureString: String                                                            //String reference for the SF Symbol icon
    var Account_ID: Int                                                                         //Unique ID of the account
    
    init (_ username:String, _ password:String, _ id:Int, _ imagestring:String) {
        self.AccountUsername = username
        self.AccountPassword = password
        self.ProfilePictureString = imagestring
        self.Account_ID = id
    }
}

/// Object which stores all information about an online account; in particular the password
class Card: Identifiable {
    var id: Int                                                                                 //Specific ID of the card (CAN CHANGE)
    var cardName: String                                                                        //Name of the Card (e.g. Google)
    var URL: String                                                                             //URL of the card (e.g. https://google.com)
    var cardUsername: String                                                                    //Username of the card
    var cardPassword: String                                                                    //Password of the card
    var passwordStrength: Float                                                                 //Strength of the password
    var isFavourite: Bool                                                                       //Preference for the card to be a favourite
    var Account_ID: Int                                                                         //ID of the account which made it
    
    init (_ id: Int, _ name: String, _ url:String, _ username:String, _ password:String, _ strength:Float, _ isfavourite: Bool, _ accountid:Int) {
        self.id = id
        self.cardName = name
        self.URL = url
        self.cardUsername = username
        self.cardPassword = password
        self.passwordStrength = strength
        self.isFavourite = isfavourite
        self.Account_ID = accountid
    }
}
