//
//  MarkdownParser.swift
//  LiveScribe
//
//  Created by Christian Skorobogatow on 25/2/25.
//

import Foundation
import Markdown

struct MarkdownParser: MarkupVisitor {
    var text = ""
    
    init(markdown: String) {
        let document = Document(parsing: markdown)
        text = visit(document)
    }
    
    mutating func defaultVisit(_ markup: any Markup) -> String {
        var result = ""
        for child in markup.children {
            result += visit(child)
        }
        return result
    }
    
    func visitText(_ text: Text) -> String {
        text.plainText
    }
    
    mutating func visitParagraph(_ paragraph: Paragraph) -> String {
        var result = "<p>"
        
        for child in paragraph.children {
            result += visit(child)
        }
        
        result += "</p>"
        return result
    }
    
    mutating func visitStrong(_ strong: Strong) -> String {
        var result = "<strong>"
        
        for child in strong.children {
            result += visit(child)
        }
        
        result += "</strong>"
        return result
    }
    
    mutating func visitEmphasis(_ emphasis: Emphasis) -> String {
        var result = "<em>"
        
        for child in emphasis.children {
            result += visit(child)
        }
        
        result += "</em>"
        return result
    }
    
    mutating func visitLink(_ link: Link) -> String {
        var result = #"<a href="\#(link.destination ?? "#")">"#
        
        for child in link.children {
            result += visit(child)
        }
        
        result += "</a>"
        return result
    }
    
    mutating func visitHeading(_ heading: Heading) -> String {
        var result = "<h\(heading.level)>"
        
        for child in heading.children {
            result += visit(child)
        }
        
        result += "</h\(heading.level)>"
        return result
    }
}
