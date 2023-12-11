//
//  VideosView.swift
//  SwiftDataDemo
//
//  Created by Jason Stout on 12/10/23.
//

import SwiftUI
import SwiftData

struct VideosView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedVideo: Video?
    @State private var deletedVideo: Video?
    @State private var sortDescriptor = SortDescriptor(\Video.title)
    @State private var searchText = ""
    var body: some View {
        VideosListView(sortDescriptor: sortDescriptor, searchText: searchText, selectedVideo: $selectedVideo, deletedVideo: $deletedVideo)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add Video", systemImage: "plus", action: addVideo)
                    
                    Menu("Menu", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortDescriptor) {
                            Text("Title")
                                .tag(SortDescriptor(\Video.title))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Video.date, order: .reverse))
                        }
                    }
                }
            }
            .onChange(of: deletedVideo) { _, newValue in
                guard let video = newValue else { return }
                delete(video)
            }
            .searchable(text: $searchText)
    }
    
    func addVideo() {
        let video = Video()
        selectedVideo = video
        modelContext.insert(video)
    }
    
    func delete(_ video: Video) {
        modelContext.delete(video)
    }
}

