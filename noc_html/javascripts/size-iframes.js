function sizeIframes() {
  $('iframe.three-col, iframe.two-col, iframe.two-col-borderless').css('display', 'inline');
  var w = $('div#container').outerWidth();

  $('div.two-col-wrapper, div.three-col-wrapper').each(function() {
    if ($(this).attr('class').indexOf('two-col-wrapper') > -1) {
      scale = 0.46;
    } else {
      scale = 0.32;
    }

    var scalecalc = (w*scale) / $(this).find('iframe').first().attr('width');
    var newh = ((w*scale) / $(this).find('iframe').first().attr('width')) * $(this).find('iframe').first().attr('height');
    $(this).find('div.two-col-container, div.three-col-container').css("transform","scale(" + scalecalc + ")");
    $(this).find('div.two-col-container, div.three-col-container').css("transform-origin","left top");

    var captions = $(this).find('p.caption');
    var maxheight = 0;
    if (captions.length > 0) {
      captions.each(function() {
        var myheight = $(this).outerHeight();
        if (myheight > maxheight) {
          maxheight = myheight;
        }
      });
      captions.each(function() {
        $(this).css('height',maxheight);
      })
    }

    maxheight = maxheight * scale;

    $(this).css("height",newh + maxheight);
    $(this).css("width",w);
  });
}

$(document).ready(function(){
  sizeIframes();
  $(window).resize(sizeIframes);
});