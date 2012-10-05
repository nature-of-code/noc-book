$(function(){
  $('.reset').click(function() {
    var controls = $(this).closest('.sketch-controls');
    var pjsID = $(controls).prev().attr('id');
    var pjs = Processing.getInstanceById(pjsID);
    pjs.setup();
    pjs.redraw();
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