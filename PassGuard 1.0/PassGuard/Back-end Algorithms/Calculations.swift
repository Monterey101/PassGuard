//
//  Calculations.swift
//  PassGuard
//

import Foundation

/// Finds the storage used by all cards that belong to the user that is currently logged in
func findSizeOfCards() -> Float {
    var counter = 0
    var out: Float = 0.0
    for card in Cards_Array {
        if card.Account_ID == ContentView().GLB_Account_Id {
            counter += String(card.id).count                                                    //No. Bytes used by the card ID
            counter += card.URL.count                                                           //No. Bytes used by URL
            counter += card.cardName.count                                                      //No. Bytes used by Card Name
            counter += card.cardUsername.count                                                  //No. Bytes used by Username
            counter += card.cardPassword.count                                                  //No. Bytes used by Password
            counter += String(card.passwordStrength).count                                      //No. Bytes used by Password Strength
            counter += String(card.isFavourite).count                                           //No. Bytes used by Favourite Status (+1)
            counter += String(card.Account_ID).count                                            //No. Bytes used by Account ID
            counter += 16                                                                       //No. Bytes used by dilimeters
        }
    }
    out = Float(counter)/1024                                                                   //Convert bytes to kilobytes (KB)
    return round(out * 100) / 100                                                               //Round to 2 decimal places
}
