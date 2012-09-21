(function() {

  addExpandLinks = function() {
    // Add expand links
    var chapters;
    chapters = $('#toc-holder>ul>li');
    chapters.each(function() {
      $(this).append(' <a href="#" class="expand">↓</a>')
    });
  }

  expandChapter = function() {
    $('.expand').click(function() {
      $(this).closest('li').next().toggle();
      return false;
    });
  }

  setupTOC = function() {
    addExpandLinks();
    expandChapter();
  }

  $(function() {
    var $toc;

    $toc = $('#toc-holder');

    // Load in the TOC
    $.ajax('toc.html').done(function(data) {
      $toc.append(data);
      setupTOC();
    });

  });

}).call(this);