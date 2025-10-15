//
//  BrailleCellView.swift
//  BrailleToText
//
//  Created by Charles Owen on 10/14/25.
//
import SwiftUI

struct BrailleCellView: View {
   @State private var dots = [false, false, false, false, false, false]
   @State private var translatedText = ""
   
   let brailleMap: [String: String] = [
      "100000": "A/1", "110000": "B/2",
      "100100": "C/3", "100110": "D/4",
      "100010": "E/5", "110100": "F/6",
      "110110": "G/7", "110010": "H/8",
      "010100": "I/9", "010110": "J/0",
      
      "101000": "K", "111000": "L",
      "101100": "M", "101110": "N",
      "101010": "O", "111100": "P",
      "111110": "Q", "111010": "R",
      "011100": "S", "011110": "T",
      
      "101001": "U", "111001": "V",
      "010111": "W", "101101": "X",
      "101111": "Y", "101011": "X",
      
   ]
   
   @FocusState private var isFocused: Bool
   @State private var pressedKeys: Set<String> = []
   @State private var output: String = ""
   
   let keyToDot: [String: Int] = [
      "s": 0x01, "d": 0x02, "f": 0x04,
      "j": 0x08, "k": 0x10, "l": 0x20
   ]
   
   var body: some View {
      VStack(spacing: 20) {
         Text("Braille Translator")
            .font(.title)
         
         // Braille cell layout: 2 columns × 3 rows
         VStack {
            ForEach(0..<3) { row in
               HStack {
                  ForEach(0..<2) { col in
                     let index = row + col * 3
                     Button(action: {
                        dots[index].toggle()
                        translateBraille()
                     }) {
                        Circle()
                           .fill(dots[index] ? Color.blue : Color.gray)
                           .frame(width: 50, height: 50)
                     }
                  }
               }
            }
         }
         
         Text(" \(translatedText) ")
            .font(.system(size: 120, weight: .bold))
         
      }
      .padding()
      .focusable()
      .focused($isFocused)
      .onAppear { isFocused = true }

      .overlay(
         KeyCaptureRepresentable(
            onKeyDown: { event in
               print(event.characters)
               // lastKeyDown = event.charactersIgnoringModifiers ?? "Unknown"
            },
            onKeyUp: { event in
               print(event.characters)
               //lastKeyUp = event.charactersIgnoringModifiers ?? "Unknown"
            }
         )
      )
   }
   
   func translateBraille() {
      let key = dots.map { $0 ? "1" : "0" }.joined()
      translatedText = brailleMap[key] ?? "?"
   }
}

