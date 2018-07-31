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
          file.$el('figure[data-pde-sketch^="http"]').each(function(i, el) { 
            var jel = file.$el(this);
            var source = jel.attr('data-pde-sketch');
            jel.after('<iframe src="' + source + '" style="width:640px;height:360px;"></iframe>');
            //jel.attr("style","display:none;");
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