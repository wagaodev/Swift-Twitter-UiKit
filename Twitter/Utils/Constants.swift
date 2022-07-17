//
//  Constants.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 17/07/22.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USER = DB_REF.child("users")


