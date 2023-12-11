//
//  EditVideoView.swift
//  SwiftDataDemo
//
//  Created by Jason Stout on 12/10/23.
//

import SwiftUI

struct EditVideoView: View {
    @Bindable var video: Video
    @State private var newKeywordName = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $video.title)
            DatePicker("Date", selection: $video.date)
            
            Section("Tags") {
                ForEach(video.keywords) { keyword in
                    Text(keyword.title)
                }
                
                HStack {
                    TextField("Add a new keyword for \(video.title)", text: $newKeywordName)
                    
                    Button("Add", action: addKeyword)
                }
            }
        }
        .navigationTitle("Edit Video")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addKeyword() {
        guard newKeywordName.isEmpty == false else { return }
        
        withAnimation {
            let keyword = Keyword(title: newKeywordName)
            video.keywords.append(keyword)
            newKeywordName = ""
        }
    }
}

//#Preview {
//    EditVideoView()
//}
