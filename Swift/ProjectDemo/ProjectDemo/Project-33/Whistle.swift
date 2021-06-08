//
//  Whistle.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import Foundation
import CloudKit

struct Whistle {
    var recordID: CKRecord.ID?
    var genre: String?
    var comments: String?
    var audio: URL?
}
