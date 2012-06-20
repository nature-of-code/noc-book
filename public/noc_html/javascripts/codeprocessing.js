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
		for( l = 0; l < styles.length; l++) {
			if(styles[l].trim() === 'bold') {
				line.html("<strong>" + line.html() + "</strong>");
			} else if (styles[l].trim() === 'italic') {
				line.html("<em>" + line.html() + "</em>");
			} else {
				line.addClass(styles[l].trim());
			}
		}
	}
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
	pair = $codeCommentPair;
	line = $(pair.find('.code-comment-line'));
	firstCodeLine = $(pair.find('.one-line')[0]);
	firstElement = $(firstCodeLine.find('span')[0]);

	line.css('position','absolute');
	if(0 != firstElement.length){
		line.css('left', firstElement.position().left + 'px');
		line.css('width', $(pair).width() - firstElement.position().left);
	}
}

$(document).ready(function(){
	$('.c1').each(function(){
		addStylesToCodeLines($(this));
	});

	$('.code-comment-pair').each(function(){
		leftAlignCommentLine($(this));
	});
});
