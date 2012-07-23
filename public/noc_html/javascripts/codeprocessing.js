// Comments are documented according to http://tomdoc.org/

// Public: Add classes or add strong and em attributes to lines of code
// by detecting inline comments matching the pattern // [<STYLE>]
// Remove the comment from the DOM and apply styles to the parent
// .one-line element.
//
// comment - a jQuery object with corresponding to $('.c1')
//
// Return nothing.
addStylesToCodeLines = function(comment) {
	match = $(comment).html().match(/\[(.*)\]/);

	if(match !== null && match.length >= 1){
		line = $(comment).parent('.one-line');
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

// Public: Find instances of [inline]// and remove [inline]
//
// code - a <code> element
//
// Returns nothing
inlineComments = function(code) {
	$(code).html($(code).html().replace(
		'<span class="o">[</span><span class="n">inline</span><span class="o">]</span>',
		''
	));
}

// Public: Adjust the size and left position of the div that draws the line
// connecting a line of code to its comment. Aligns the left end of the line to
// the left most position of the code.
//
// $codeCommentPair - a jQuery object containing a code block, a comment and a
//                    code-comment-line.
//
// Returns nothing.
leftAlignCommentLine = function($codeCommentPair) {
	var pair = $codeCommentPair;
	var line = $(pair.find('.code-comment-line'));
	var firstCodeLine = $(pair.find('.one-line')[0]);
	var firstElement = $(firstCodeLine.find('span')[0]);

	// Set left position based on .position() if available.
	try {
		if(0 != firstElement.length){
			line.css('left', firstElement.position().left + 'px');
		}
	} catch (e) {
		var html = firstCodeLine.html();
		var match = html.match(/^(\<.*?\>)*(\s+)/);
		if (match !== null && match !== 'undefined') {
			var last = match.length - 1;
			if (match[last].length >= 1) {
				line.css('left', (match[last].length / 2) + 'em');
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
toggleCodeDisplay = function($toggle) {
	$sourceCode = $toggle.parent('.source-code');
	if($toggle.html() === $toggle.data()['toRaw']){
		$sourceCode
			.find('textarea').show().end()
			.find('.code-block').hide().end()
			.find('.toggle').html($toggle.data()['toFormatted']);
	} else {
		$sourceCode
			.find('textarea').hide().end()
			.find('.code-block').show().end()
			.find('.toggle').html($toggle.data()['toRaw']);
	}
}

// Public: Run preformatting on the textarea elements so that toggling does not
// cause a huge shift in the layout. Does not guarantee that all code will be
// visible without scrolling.
//
// $sourceCode - a jQuery object of a div wrapping a code section.
//
// Returns nothing.
setRawCodeHeight = function($sourceCode) {
	h = $sourceCode.find('.code-block').height();
	$sourceCode.find('textarea').css('height', h);
}

$(document).ready(function(){
	$('.c1').each(function(){ addStylesToCodeLines($(this)); });
	$('code').each(function(){ inlineComments($(this)); });
	$('.code-comment-pair').each(function(){ leftAlignCommentLine($(this)); });
	$('.source-code').each(function(){ setRawCodeHeight($(this)); });
	$('.toggle').click(function(){ toggleCodeDisplay($(this)); return false; });
});
