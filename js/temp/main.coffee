# /*! yet-another-coffescript-skeleton - v0.0.2 - last build: 2013-03-27 19:22:53 */
#helper

# a canvas full circle
CanvasRenderingContext2D::fillCircle = (x,y,radius) ->
  @beginPath()
  @arc(x,y,radius,0,2*Math.PI)
  @fill()

CanvasRenderingContext2D::strokeCircle = (x,y,radius) ->
  @beginPath()
  @arc(x,y,radius,0,2*Math.PI)
  @stroke()

CanvasRenderingContext2D::drawCircle = (x,y,radius) ->
  @beginPath()
  @arc(x,y,radius,0,2*Math.PI)
  @fill()
  @stroke()

#method to pause rendering
loop_id = 0
pause = () ->
  console.log('pause')
  window.cancelAnimationFrame(loop_id)

gotStream = (stream) ->
  window.setTimeout((()->
    #console.log(window.document.width)
    context = new webkitAudioContext()
    analyser = context.createAnalyser()
    canvas = document.createElement('canvas')
    ctx = canvas.getContext("2d")
    canvas.width = window.document.width or 1024;
    canvas.height = window.document.height or 600;
    document.body.appendChild(canvas)
    source = context.createMediaStreamSource( stream )
    source.connect(analyser);
    musicAnalyzer(canvas, ctx, analyser)
  ),1000)
#  #mediaStreamSource.connect( audioContext.destination )

musicAnalyzer = (canvas, ctx, analyser) ->
  loop_id = window.webkitRequestAnimationFrame((()->
    musicAnalyzer(canvas, ctx, analyser)))

  freqByteData = new Uint8Array(analyser.frequencyBinCount)
  analyser.getByteFrequencyData(freqByteData)
  
  draw(canvas, ctx, freqByteData)

draw = (canvas, ctx, freqData) ->
  #freqData.length is 1024
  ctx.clearRect(0, 0, canvas.width, canvas.height)
  for f, i in freqData 
    do (f, i) ->
      mitte = Math.floor(canvas.height/2)
      vmitte = Math.floor(canvas.width/2)
      ctx.fillStyle = "rgb("+0+","+f+","+0+")"
      ctx.fillRect(i, mitte, 1, -f*2)
      ctx.fillRect(i, mitte, 1, f*2)
      ctx.fillStyle = "rgb("+f+","+0+","+0+")"
      ctx.fillRect(canvas.width-i, mitte, 1, -f*2)
      ctx.fillRect(canvas.width-i, mitte, 1, f*2)
      ctx.fillStyle = "rgb("+0+","+0+","+f+")"
      ctx.fillRect(vmitte, i, f*2, 1)
      ctx.fillRect(vmitte, i, -f*2, 1)
      ctx.fillStyle = "rgb("+0+","+f+","+0+")"
      ctx.drawCircle(vmitte, mitte,f)

navigator.webkitGetUserMedia( {audio:true}, gotStream )


#http://jcla1.com/blog/2012/03/11/web-audio-api-overview-part1/
#view-source:http://html5-demos.appspot.com/static/webaudio/createMediaSourceElement.html

#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 14, 34, 33, 31, 33, 38, 46, 55, 60, 59, 70, 80, 83, 78, 80, 87, 82, 102, 120, 128, 132, 128, 123, 113, 107, 99, 86, 75, 65, 56, 44, 48, 50, 44, 33, 24, 21, 25, 22, 8, 15, 18, 15, 15, 11, 9, 9, 14, 17, 15, 15, 15, 16, 13, 1, 0, 5, 6, 3, 0, 5, 6, 3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…]
# main.js:76
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 31, 28, 26, 29, 33, 41, 49, 54, 52, 63, 74, 77, 71, 74, 80, 75, 96, 113, 121, 125, 121, 116, 106, 101, 92, 80, 69, 59, 52, 40, 42, 44, 38, 27, 19, 15, 19, 16, 7, 12, 14, 13, 13, 6, 7, 7, 10, 16, 14, 13, 15, 13, 9, 0, 0, 5, 4, 4, 4, 2, 4, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…]
# main.js:76
#[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 11, 30, 25, 21, 22, 29, 37, 43, 47, 46, 57, 67, 70, 65, 67, 74, 68, 89, 106, 114, 118, 114, 109, 100, 94, 86, 74, 64, 55, 46, 34, 37, 39, 32, 25, 17, 11, 17, 16, 9, 14, 14, 10, 9, 3, 6, 4, 6, 12, 10, 9, 10, 7, 5, 0, 0, 2, 4, 4, 4, 5, 6, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…]
