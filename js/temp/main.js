(function() {
  var analyser, canvas, context, ctx, draw, gotStream, init, loop_id, musicAnalyzer, pause;

  loop_id = 0;

  pause = function() {
    console.log('pause');
    return window.cancelAnimationFrame(loop_id);
  };

  context = new webkitAudioContext();

  analyser = context.createAnalyser();

  canvas = document.createElement('canvas');

  ctx = canvas.getContext("2d");

  window.addEventListener('load', (function(e) {
    return init(e);
  }));

  init = function() {};

  gotStream = function(stream) {
    var source;
    console.log('gotStream');
    console.log(window.document.width);
    canvas.width = window.document.width || 1024;
    canvas.height = window.document.height || 600;
    document.body.appendChild(canvas);
    source = context.createMediaStreamSource(stream);
    source.connect(analyser);
    return musicAnalyzer();
  };

  window.setTimeout((function() {
    return navigator.webkitGetUserMedia({
      audio: true
    }, gotStream);
  }), 500);

  musicAnalyzer = function() {
    var freqByteData;
    loop_id = window.webkitRequestAnimationFrame(musicAnalyzer);
    freqByteData = new Uint8Array(analyser.frequencyBinCount);
    analyser.getByteFrequencyData(freqByteData);
    return draw(canvas, ctx, freqByteData);
  };

  draw = function(canvas, ctx, freqData) {
    var f, i, _i, _len, _results;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    _results = [];
    for (i = _i = 0, _len = freqData.length; _i < _len; i = ++_i) {
      f = freqData[i];
      _results.push((function(f, i) {
        var b, g, mitte, r;
        r = f % Math.floor(Math.random() * 255);
        g = f;
        b = f % Math.floor(Math.random() * 255);
        mitte = Math.floor(canvas.height / 2);
        ctx.fillStyle = "rgb(" + r + "," + g + "," + b + ")";
        ctx.fillRect(i, mitte, 1, -f);
        return ctx.fillRect(i, mitte, 1, f);
      })(f, i));
    }
    return _results;
  };

}).call(this);
