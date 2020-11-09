import 
  x11/xlib,
  x11/x,
  os,
  osproc

proc main =
  var
    display: PDisplay
    rev: cint
    win: Window

  # Open display
  display = XOpenDisplay(nil)
  if display == nil:
    quit "Failed to open display"

  # Get window for current focused window
  discard XGetInputFocus(display, win.addr, rev.addr)

  discard XUnmapWindow(display, win)
  discard XFlush(display)
  
  # Run the command to be devoured
  discard execProcess(paramStr(1))

  discard XMapWindow(display, win)
  discard XCloseDisplay(display)
  return

when isMainModule:
  main()
