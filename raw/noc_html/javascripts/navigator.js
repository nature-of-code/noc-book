(function() {

  addExpandLinks = function() {
    // Add expand links
    var chapters;
    chapters = $('#toc-list>ul>li');
    chapters.each(function() {
      $(this).append(' <span class="expand">l</span>')
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

    $toc = $('#toc-list');

    $('#toc-holder').fixed({'top':'10'});

    // Load in the TOC
    $.ajax('toc.html').done(function(data) {
      $toc.append(data);
      setupTOC();
    });

  });

}).call(this);