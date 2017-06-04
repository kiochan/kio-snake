{app, BrowserWindow} = require "electron"
path = require "path"
url = require "url"

win = null

createWindow = ->
  win = new BrowserWindow
    useContentSize: yes
    frame: false
    width: 400
    height: 300
    minWidth: 400
    minHeight: 300
    maxWidth: 400
    maxHeight: 300
    zoomFactor: 1
    fullscreen: no
    fullscreenable: no
  win.setMenu null
  win.loadURL url.format
    pathname: path.join __dirname, "renderer.html"
    protocol: "file:"
    slashes: true
  win.once "ready-to-show", (-> do win.show)
  win.on 'closed', (-> win = null)
  return

app.on 'ready', createWindow
app.on 'window-all-closed', (-> do app.quit)
