//
//  ContentView.swift
//  Source Calculator
//
//  Created by Anton Heestand on 2019-12-04.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Source Calculator")
                .font(.system(.title, design: .monospaced))
            Text("Evaluate Expressions in Xcode")
                .font(.system(.subheadline, design: .monospaced))
                .layoutPriority(1)
            Button(action: {
                guard let settingsUrl = URL(string: "x-apple.systempreferences:com.apple.preference.extensions?Xcode_Source_Editor") else { return }
                NSWorkspace.shared.open(settingsUrl)
            }) {
                Text("Activate in System Preferences")
            }
            Text("Extensions / Xcode Source Editor")
                .opacity(0.5)
        }
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
