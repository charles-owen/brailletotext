//
//  BrailleCellView.swift
//  BrailleToText
//
//  Created by Charles Owen on 10/14/25.
//
import SwiftUI

struct BrailleCellView: View {
   @State private var dots = [false, false, false, false, false, false]
   @State private var translatedText = " "
   
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
      
      "111101": "and", "111111": "for",
      "111011": "of", "011101": "the",
      "011111": "with", "100001": "ch/child",
      "100101": "sh/shall", "100111": "th/his",
      "100011": "wh/which", "110011": "ou/out",
      "001100": "st/still",
      
      "010001": "en",
      "001010": "in",
      
      "010000": ",",
      "011000": ";/be",
      "010010": ":/can",
      "010011": "./dis",
      "011010": "!",
      "011001": "?",
      "001001": "-",
      
   ]
   
   @FocusState private var isFocused: Bool
   @State private var pressedKeys: Set<String> = []
   //@State private var output: String = ""
   
   let keyToDot: [String: Int] = [
      "s": 2, "d": 1, "f": 0,
      "j": 3, "k": 4, "l": 5
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
         
         Text("\(translatedText)")
            .font(.system(size: 120, weight: .bold))
         
      }
      .padding()
      .focusable()
      .focused($isFocused)
      .onAppear { isFocused = true }

      .overlay(
         KeyCaptureRepresentable(
            onKeyDown: { event in
               if pressedKeys.isEmpty {
                  dots = [false, false, false, false, false, false]
                  translatedText = " "
               }
               if let c = event.charactersIgnoringModifiers {
                  pressedKeys.insert(c)
                  
                  switch c {
                  case "s", "d", "f", "j", "k", "l":
                     let dotIndex = keyToDot[String(c)] ?? 0
                     dots[dotIndex] = true
                     translateBraille()
                  default:
                     break
                  }
                  
               }
            },
            onKeyUp: { event in
               if let c = event.charactersIgnoringModifiers {
                  pressedKeys.remove(c)
               }
            }
         )
      )
   }
   
   func translateBraille() {
      let key = dots.map { $0 ? "1" : "0" }.joined()
      if key == "000000" {
         translatedText = " "
      } else {
         translatedText = brailleMap[key] ?? "\u{2588}"
      }
   }
}

