$(function(){
  // Reload the sketch from sources. Also set paused to false
  $('.reset').click(function() {
    var controls = $(this).closest('.sketch-controls');
    var pjsID = $(controls).prev().attr('id');
    var sketch = document.getElementById(pjsID);

    // Adapted from Processingjs lazyloading extension.
    // https://github.com/processing-js/processing-js/blob/master/extensions/processing-lazyload.js
    var processingSources = sketch.getAttribute('data-processing-sources');
    var filenames = processingSources.split(' ');
    for (var j = 0; j < filenames.length;) {
      if (filenames[j]) { j++; }
      else { filenames.splice(j, 1); }}
    Processing.loadSketchFromSources(sketch, filenames);

    $(controls).find('.pause').data()['paused'] = 'false';
  });

  $('.pause').click(function() {
    var controls = $(this).closest('.sketch-controls');
    var pjsID = $(controls).prev().attr('id');
    var pjs = Processing.getInstanceById(pjsID);
    if($(this).data()['paused'] === 'true') {
      pjs.loop();
      $(this).data()['paused'] = 'false';
    } else {
      pjs.noLoop();
      $(this).data()['paused'] = 'true';
    }
  });
});