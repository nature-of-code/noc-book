var fs = require('fs');
var path = require('path');
var through = require('through2');
var cheerio = require('cheerio');

// This constructor function will be called once per format
// for every build. It received a plugin registry object, which
// has .add(), .before() and .after() functions that can be used
// to register plugin functions in the pipeline.

var Plugin = function(registry){
  registry.after('markdown:convert', 'addP5:insert', this.addFrames);
};

Plugin.prototype = {

  addFrames: function(config, stream, extras, cb) {
    if(config.format == "html") {

    stream = stream.pipe(through.obj(function(file, enc, cb) {
        if(!file.$el) file.$el = cheerio.load(file.contents.toString());
          // Loop through all figures to replace with iframes
          file.$el('figure[data-p5-sketch^="http"]').each(function(i, el) { 
            var jel = file.$el(this);
            //<p class="caption">angleVel = 0.05</p>
            var source = jel.attr('data-p5-sketch');
            if (jel.attr('class') && jel.attr('class').indexOf('two-col') > -1) {
              var newel = '<div class="two-col"><iframe class="two-col" data-src="' + source + '" width="640" height="360" frameborder="0" allowfullscreen></iframe></div>';
              if (jel.prev().attr('class') && jel.prev().attr('class').indexOf('two-col-wrapper') > -1) {
                jel.prev().find('div.two-col-container').append(newel);
              } else {
                jel.before('<div class="two-col-wrapper"><div class="two-col-container">' + newel + '</div></div>');
              }
            } else if (jel.attr('class') && jel.attr('class').indexOf('three-col') > -1) {
              var newel = '<div class="three-col"><iframe class="three-col" data-src="' + source + '" width="640" height="360" frameborder="0" allowfullscreen></iframe></div>';
              if (jel.prev().attr('class') && jel.prev().attr('class').indexOf('three-col-wrapper') > -1) {
                jel.prev().find('div.three-col-container').append(newel);
              } else {
                jel.before('<div class="three-col-wrapper"><div class="three-col-container">' + newel + '</div></div>');
              }
            } else {
              var newel = '<div class="one-col-wrapper"><iframe data-src="' + source + '" width="640" height="360" frameborder="0" allowfullscreen></iframe></div>';
              jel.before(newel);
            }
            // check for a caption; if found, add to new element
            var caption = jel.find('figcaption');
            if (caption.length > 0 && /\S+/.test(caption.text())) {
              var prevframe = jel.prev().find('iframe').last();
              prevframe.after('<p class="caption">' + caption.html() + '</p>');
            }
            jel.empty();
            jel.remove();
          });

        // pass file through the chain
        cb(null, file);
      }))

    }

    cb(null, config, stream, extras);
  }

}

module.exports = Plugin;