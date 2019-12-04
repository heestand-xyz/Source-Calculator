//
//  SourceEditorCommand.swift
//  Source Calculator Xcode Extension
//
//  Created by Anton Heestand on 2019-12-04.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Foundation
import XcodeKit
import Expression

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        do {
            try editSelections(buffer: invocation.buffer, edit: edit)
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
    func editSelections(buffer: XCSourceTextBuffer, edit: (String) throws -> (String)) throws {
        guard let lines = buffer.lines as? [String] else { return }
        guard let selectedRanges = buffer.selections as? [XCSourceTextRange] else { return }
        for selectedRange in selectedRanges {
            let startLine = selectedRange.start.line
            let endLine = selectedRange.end.line
            let startColum = selectedRange.start.column
            let endColumn = selectedRange.end.column
            guard startLine == endLine else {
                throw NSError(domain: "Source Calculator", code: 2, userInfo: [
                    NSLocalizedDescriptionKey : "Selection can not span multiple rows."
                ])
            }
            let line = lines[startLine]
            let oldText = line[startColum...endColumn]
            let newText = try edit(oldText)
            buffer.lines[startLine] = line[0..<startColum] + newText + line[(endColumn + 1)..<line.count]
        }
    }
    
    func edit(_ text: String) throws -> String {
        let expression = Expression(text)
        do {
            let result = try expression.evaluate()
            var resultText = String(describing: result)
            if resultText[(resultText.count - 2)..<resultText.count] == ".0" {
                resultText = resultText[0..<(resultText.count - 2)]
            }
            return resultText
        } catch {
            throw NSError(domain: "Source Calculator", code: 1, userInfo: [
                NSLocalizedDescriptionKey : String(describing: error)
            ])
        }
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
