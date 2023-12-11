//
//  DatabaseMigrationPlan.swift
//  SwiftDataDemo
//
//  Created by Jason Stout on 12/10/23.
//

import SwiftUI
import SwiftData

enum DatabaseMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type] {
        [ModelsShemaV1.self, ModelsShemaV2.self]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: ModelsShemaV1.self, toVersion: ModelsShemaV2.self) { context in
        let videos = try context.fetch(FetchDescriptor<ModelsShemaV1.Video>())
        
        var usedTitles = Set<String>()
        for video in videos {
            if usedTitles.contains(video.title) {
                context.delete(video)
            }
            
            usedTitles.insert(video.title)
        }
        
        try context.save()
        
    } didMigrate: { _ in
        
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
}
