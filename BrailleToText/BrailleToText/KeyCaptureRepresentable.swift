import SwiftUI
import AppKit

struct KeyCaptureRepresentable: NSViewRepresentable {
   var onKeyDown: (NSEvent) -> Void
   var onKeyUp: (NSEvent) -> Void
   
   func makeNSView(context: Context) -> KeyCaptureView {
      let view = KeyCaptureView()
      view.onKeyDown = onKeyDown
      view.onKeyUp = onKeyUp
      return view
   }
   
   func updateNSView(_ nsView: KeyCaptureView, context: Context) {}
}

