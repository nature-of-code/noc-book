// Comments are documented according to http://tomdoc.org/

// Public: Add classes or add strong and em attributes to lines of code
// by detecting inline comments matching the pattern // [<STYLE>]
// Remove the comment from the DOM and apply styles to the parent
// .one-line element.
//
// comment - a jQuery object with corresponding to $('.c1')
//
// Return nothing.
var addStylesToCodeLines = function(comment) {
	match = $(comment).html().match(/\[(.*)\]/);

	if(match !== null && match.length >= 1){
		line = $(comment).parent('span.one-line');
		// Remove the comment and trailing whitespace.
		$(line).find('.c1').remove().end().html($(line).html().replace(/\s*$/,''));
		// Split any styles by commas.
		styles = match[1].split(',');
		// Add any comment values with strong, em, or class names.
		for(l = 0; l < styles.length; l++) {
			if(styles[l] === 'bold') {
				line.html("<strong>" + line.html() + "</strong>");
			} else if (styles[l] === 'italic') {
				line.html("<em>" + line.html() + "</em>");
			} else {
				line.addClass(styles[l]);
			}
		}
	}
}

// Public: Toggle between formatted code markup and a textarea of the raw code.
// Changes text of the button based on data attributes of button.toggle.
// To change what the button says, see `views/source.html.erb`.
//
// $toggle - a jQuery object corresponding to the clicked button.toggle
//
// Returns nothing.
var toggleCodeDisplay = function($toggle) {
	$sourceCode = $toggle.parent('div.source-code');
	if($toggle.html() === $toggle.data()['toRaw']){
		$sourceCode
			.find('textarea').show().end()
			.find('div.code-block').hide().end()
			.find('a.toggle').html($toggle.data()['toFormatted']);
	} else {
		$sourceCode
			.find('textarea').hide().end()
			.find('div.code-block').show().end()
			.find('a.toggle').html($toggle.data()['toRaw']);
	}
}

// Public: Run preformatting on the textarea elements so that toggling does not
// cause a huge shift in the layout. Does not guarantee that all code will be
// visible without scrolling.
//
// $sourceCode - a jQuery object of a div wrapping a code section.
//
// Returns nothing.
var setRawCodeHeight = function($sourceCode) {
	h = $sourceCode.find('div.code-block').height();
	$sourceCode.find('textarea').css('height', h);
}
