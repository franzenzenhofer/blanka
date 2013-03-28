/*! yet-another-coffescript-skeleton - v0.0.2 - last build: 2013-03-27 19:22:53 */
(function() {
  var draw, gotStream, loop_id, musicAnalyzer, pause;

  CanvasRenderingContext2D.prototype.fillCircle = function(x, y, radius) {
    this.beginPath();
    this.arc(x, y, radius, 0, 2 * Math.PI);
    return this.fill();
  };

  CanvasRenderingContext2D.prototype.strokeCircle = function(x, y, radius) {
    this.beginPath();
    this.arc(x, y, radius, 0, 2 * Math.PI);
    return this.stroke();
  };

  CanvasRenderingContext2D.prototype.drawCircle = function(x, y, radius) {
    this.beginPath();
    this.arc(x, y, radius, 0, 2 * Math.PI);
    this.fill();
    return this.stroke();
  };

  loop_id = 0;

  pause = function() {
    console.log('pause');
    return window.cancelAnimationFrame(loop_id);
  };

  gotStream = function(stream) {
    return window.setTimeout((function() {
      var analyser, canvas, context, ctx, source;
      context = new webkitAudioContext();
      analyser = context.createAnalyser();
      canvas = document.createElement('canvas');
      ctx = canvas.getContext("2d");
      canvas.width = window.document.width || 1024;
      canvas.height = window.document.height || 600;
      document.body.appendChild(canvas);
      source = context.createMediaStreamSource(stream);
      source.connect(analyser);
      return musicAnalyzer(canvas, ctx, analyser);
    }), 1000);
  };

  musicAnalyzer = function(canvas, ctx, analyser) {
    var freqByteData;
    loop_id = window.webkitRequestAnimationFrame((function() {
      return musicAnalyzer(canvas, ctx, analyser);
    }));
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
        var mitte, vmitte;
        mitte = Math.floor(canvas.height / 2);
        vmitte = Math.floor(canvas.width / 2);
        ctx.fillStyle = "rgb(" + 0 + "," + f + "," + 0 + ")";
        ctx.fillRect(i, mitte, 1, -f * 2);
        ctx.fillRect(i, mitte, 1, f * 2);
        ctx.fillStyle = "rgb(" + f + "," + 0 + "," + 0 + ")";
        ctx.fillRect(canvas.width - i, mitte, 1, -f * 2);
        ctx.fillRect(canvas.width - i, mitte, 1, f * 2);
        ctx.fillStyle = "rgb(" + 0 + "," + 0 + "," + f + ")";
        ctx.fillRect(vmitte, i, f * 2, 1);
        ctx.fillRect(vmitte, i, -f * 2, 1);
        ctx.fillStyle = "rgb(" + 0 + "," + f + "," + 0 + ")";
        return ctx.drawCircle(vmitte, mitte, f);
      })(f, i));
    }
    return _results;
  };

  navigator.webkitGetUserMedia({
    audio: true
  }, gotStream);

}).call(this);
