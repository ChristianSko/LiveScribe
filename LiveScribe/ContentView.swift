//
//  ContentView.swift
//  LiveScribe
//
//  Created by Christian Skorobogatow on 24/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    
    var body: some View {
        HSplitView {
            TextEditor(text: $input)
            SimpleWebView(
                content: MarkdownParser(
                    markdown: input
                ).text
            )
        }
    }
}

#Preview {
    ContentView()
}



