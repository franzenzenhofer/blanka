# /*! yet-another-coffescript-skeleton - v0.0.2 - last build: 2013-03-23 20:47:17 */
#Create an <audio> element dynamically.
#audio = new Audio()
#audio.src = 'a/wrong.mp3'
#audio.controls = true
#audio.autoplay = false
#audio.addEventListener('play', ((e) -> musicAnalyzer()))
#audio.addEventListener('pause', ((e) -> pause()))

loop_id = 0

pause = () ->
  console.log('pause')
  window.cancelAnimationFrame(loop_id)

context = new webkitAudioContext()
analyser = context.createAnalyser()

canvas = document.createElement('canvas')
ctx = canvas.getContext("2d")



#document.body.appendChild(canvas)

window.addEventListener('load', ((e)->init(e)))

init = () ->
  #alert('init')

  
#  document.body.appendChild(audio)
#  source = context.createMediaElementSource(audio)
#  source.connect(analyser);
#  analyser.connect(context.destination);


gotStream = (stream) ->
  console.log('gotStream')

  console.log(window.document.width)
  canvas.width = window.document.width or 1024;
  canvas.height = window.document.height or 600;
  document.body.appendChild(canvas)
  source = context.createMediaStreamSource( stream )
  source.connect(analyser);
  musicAnalyzer()
#  #mediaStreamSource.connect( audioContext.destination )
#
window.setTimeout((() ->
  navigator.webkitGetUserMedia( {audio:true}, gotStream )
  ),500)

musicAnalyzer = () ->
  loop_id = window.webkitRequestAnimationFrame(musicAnalyzer)
  freqByteData = new Uint8Array(analyser.frequencyBinCount)
  analyser.getByteFrequencyData(freqByteData)
  #console.log(freqByteData)
  draw(canvas, ctx, freqByteData)

draw = (canvas, ctx, freqData) ->
  #console.log(freqData.length)
  #freqData = 1024
  ctx.clearRect(0, 0, canvas.width, canvas.height)
  for f, i in freqData 
    do (f, i) ->
      #console.log(f)
      #console.log(i)
      #magnitude = freqData[i + offset]
      #magnitude = freqData[i]
      #fillRect(x,y,width,height) 
      r = f%Math.floor(Math.random()*255)
      #g = Math.floor(Math.random()*255)
      g=f
      b = f%Math.floor(Math.random()*255)#0#Math.floor(Math.random()*255)
      mitte = Math.floor(canvas.height/2)
      ctx.fillStyle = "rgb("+r+","+g+","+b+")"
      ctx.fillRect(i, mitte, 1, -f)
      ctx.fillRect(i, mitte, 1, f)
#http://jcla1.com/blog/2012/03/11/web-audio-api-overview-part1/
#view-source:http://html5-demos.appspot.com/static/webaudio/createMediaSourceElement.html

