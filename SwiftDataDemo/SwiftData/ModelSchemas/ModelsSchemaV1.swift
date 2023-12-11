//
//  ModelsSchema.swift
//  SwiftDataDemo
//
//  Created by Jason Stout on 12/9/23.
//

import SwiftUI
import SwiftData

enum ModelsShemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Video.self, Keyword.self]
    }
    
    @Model
    class Video {
        var title: String
        var date: Date
        @Relationship(deleteRule: .cascade) var keywords: [Keyword]
        
        init(title: String = "") {
            self.title = title
            self.date = .now
            self.keywords = []
        }
    }
    
    @Model
    class Keyword {
        @Attribute(.unique) var title: String
        
        init(title: String = "") {
            self.title = title
        }
    }
}
