import SwiftUI
import AppKit

class KeyCaptureView: NSView {
   var onKeyDown: ((NSEvent) -> Void)?
   var onKeyUp: ((NSEvent) -> Void)?
   
   override var acceptsFirstResponder: Bool { true }
   
   override func keyDown(with event: NSEvent) {
      onKeyDown?(event)
   }
   
   override func keyUp(with event: NSEvent) {
      onKeyUp?(event)
   }
   
   override func viewDidMoveToWindow() {
      window?.makeFirstResponder(self)
   }
}

