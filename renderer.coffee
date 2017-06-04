canvas = document.createElement "canvas"
canvas.width = "400"
canvas.height = "300"
document.body.appendChild canvas

context = canvas.getContext "2d"

speed = 60

fieldWidth = 40
fieldHeight = 30

# [x, y]
position = [0, 0]
direction = [1, 0]

positionStack = []

food = [0, 0]

spawnSnack = ->
  position = [13, 10]
  direction = [1, 0]
  positionStack = []
  positionStack.push [11, 10]
  positionStack.push [12, 10]
  positionStack.push [13, 10]
  drawContext 11, 10, "#0A0"
  drawContext 12, 10, "#0A0"
  drawContext 13, 10, "#0A0"
  return

spawnFood = ->
  x = ~~((do Math.random)*40)
  y = ~~((do Math.random)*30)
  while hit x, y
    x = (x + 1) % 40
    y = (y + 1) % 30
  food = [x, y]
  drawContext x, y, "#00A"
  return

hit = (x, y) ->
  res = no
  p = [x, y]
  for pos in positionStack
    if p[0] == pos[0] && p[1] == pos[1]
      res = yes
      break
  return res

moveSnack = ->

  position[0] += direction[0]
  if 0 > position[0]
    position[0] = 39
  if fieldWidth <= position[0]
    position[0] = 0

  position[1] += direction[1]
  if 0 > position[1]
    position[1] = 29
  if fieldHeight <= position[1]
    position[1] = 0

  drawContext position[0], position[1], "#0A0"

  console.log "x: #{position[0]}, y: #{position[1]}, l: #{positionStack.length}"

  if hit position[0], position[1]

    console.log "game over"
    do clearContext
    do spawnSnack
    do spawnFood

  else

    positionStack.push [position[0],position[1]]

    if food[0] == position[0] && food[1] == position[1]

      speed -= 0.1
      do spawnFood

    else

      last = do positionStack.shift
      removeContext last[0], last[1]

  return

clearContext = ->
  context.fillStyle = "#000"
  context.fillRect 0, 0, 400, 300
  return context

drawContext = (x, y, color) ->
  context.fillStyle = color
  context.fillRect x*10, y*10, 10, 10
  return context

removeContext = (x, y) ->
  context.fillStyle = "#000"
  context.fillRect x*10, y*10, 10, 10
  return context

speed = 60
ot = 0
render = (t) ->
  if t - ot > speed
    ot = t
    do moveSnack
  window.requestAnimationFrame render


document.body.onkeydown = (e) ->
  switch e.keyCode
    when 38
      if direction[1] == 0
        direction = [0, -1]
    when 39
      if direction[0] == 0
        direction = [1, 0]
    when 40
      if direction[1] == 0
        direction = [0, 1]
    when 37
      if direction[0] == 0
        direction = [-1, 0]
  return

do clearContext
do spawnSnack
do spawnFood
do render
