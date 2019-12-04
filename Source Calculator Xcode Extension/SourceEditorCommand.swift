//
//  SourceEditorCommand.swift
//  Source Calculator Xcode Extension
//
//  Created by Anton Heestand on 2019-12-04.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    enum EditError: Error {
        case badLines
        case badSelections
        case multiRowNotSupported
    }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        do {
            try editSelections(buffer: invocation.buffer, edit: edit)
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
    func editSelections(buffer: XCSourceTextBuffer, edit: (String) throws -> (String)) throws {
        guard let lines = buffer.lines as? [String] else {
            throw EditError.badLines
        }
        guard let selectedRanges = buffer.selections as? [XCSourceTextRange] else {
            throw EditError.badSelections
        }
        for selectedRange in selectedRanges {
            let startLine = selectedRange.start.line
            let endLine = selectedRange.end.line
            let startColum = selectedRange.start.column
            let endColumn = selectedRange.end.column
            guard startLine == endLine else {
                throw EditError.multiRowNotSupported
            }
            let line = lines[startLine]
            let oldText = line[startColum...endColumn]
            let newText = try edit(oldText)
            buffer.lines[startLine] = line[0..<startColum] + newText + line[(endColumn + 1)..<line.count]
        }
    }
    
    func edit(_ text: String) throws -> String {
        text.replacingOccurrences(of: "R", with: "_")
    }
    
}

extension String {

    public subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    public subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

}
