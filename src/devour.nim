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
  
  # If args have spaces, escape with backslash
  let 
    # Right now only support 2 arguments
    cmd = paramStr(1)
    file = paramStr(2)

  var new_cmd = cmd & "  "

  for ch in file:
    if ch != ' ':
      new_cmd.add(ch)
    else:
      new_cmd.add("\\ ")

  # Run the command to be devoured
  discard execProcess(new_cmd)

  discard XMapWindow(display, win)
  discard XCloseDisplay(display)

  return


when isMainModule:
  main()
