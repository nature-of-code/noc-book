/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/wiki/SyntaxHighlighter:Donate
 *
 * @version
 * 2.0.320 (May 03 2009)
 * 
 * @copyright
 * Copyright (C) 2004-2009 Alex Gorbatchev.
 *
 * @license
 * This file is part of SyntaxHighlighter.
 * 
 * SyntaxHighlighter is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * SyntaxHighlighter is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with SyntaxHighlighter.  If not, see <http://www.gnu.org/copyleft/lesser.html>.
 */
SyntaxHighlighter.brushes.Processing = function()
{
	// Copyright 2009 Sebastian Korczak
	
	var keywords1 =	'ArrayList Boolean Byte Character Class Double Float Integer HashMap String StringBuffer Thread abstract assert boolean break byte catch char class continue default do double else enum extends false final finally for float if implements import instanceof int interface long native new null package private protected public return short static strictfp super switch synchronized this throw throws transient true try void volatile while Array ArrayList boolean break byte case char color  continue default double else extends false final float for HashMap if implements import int long new null Object PFont PGraphics PImage PrintWriter private PShape public PVector return static String super this true void while XMLElement arraycopy openStream cache abs acos alpha ambient ambientLight append applyMatrix arc arrayCopy asin atan atan2 background beginCamera beginRaw beginRecord beginShape bezier bezierDetail bezierPoint bezierTangent bezierVertex binary binary blend blendColor blue boolean box brightness byte camera ceil char char color colorMode concat constrain copy cos createFont createGraphics createImage createInput createOutput createReader createWriter cursor curve curveDetail curvePoint curveTangent curveTightness curveVertex day degrees delay directionalLight dist ellipse ellipseMode emissive endCamera endRaw endRecord endShape exit exp expand fill filter float floor frameRate frustum get green hex hint hour hue image imageMode int join keyPressed keyReleased keyTyped lerp lerpColor lightFalloff lights lightSpecular line link loadBytes loadFont loadImage loadPixels loadShape loadStrings log loop mag map match matchAll max millis min minute modelX modelY modelZ month mouseClicked mouseDragged mouseMoved mousePressed mouseReleased nf nfc nfp nfs noCursor noFill noise noiseDetail noiseSeed noLights noLoop norm normal noSmooth noStroke noTint open ortho param perspective list beginDraw endDraw alpha blend copy filter get loadPixels mask resize save set updatePixels point point popMatrix pow print printCamera println printMatrix printProjection close flush print println disableStyle enableStyle getChild getHeight getWidth isVisible resetMatrix rotate rotateX rotateY rotateZ scale setVisible translate pushMatrix add angleBetween array copy cross dist div dot get limit mag mult normalize set sub quad radians random randomSeed rect rectMode red redraw requestImage resetMatrix reverse rotate rotateX rotateY rotateZ round saturation save saveBytes saveFrame saveStream saveStrings scale screenX screenY screenZ second selectFolder selectInput selectOutput set shape shapeMode shininess shorten sin size smooth sort specular sphere sphereDetail splice split splitTokens spotLight sq sqrt status str charAt equals indexOf length substring toLowerCase toUpperCase stroke strokeCap strokeJoin strokeWeight subset switch tan text textAlign textAscent textDescent textFont textLeading textMode textSize texture textureMode textWidth tint translate triangle trim unbinary unhex updatePixels vertex getChild getChildCount getChildren getContent getFloatAttribute getIntAttribute getName getStringAttribute year';

	var keywords2 =	'ADD ALIGN_CENTER ALIGN_LEFT ALIGN_RIGHT ALPHA ALPHA_MASK ALT AMBIENT ARROW ARGB BACKSPACE BASELINE BEVEL BLEND BLUE_MASK BLUR BOTTOM BURN CENTER CHATTER CODED COMPLAINT COMPOSITE COMPONENT CONCAVE_POLYGON CONTROL CONVEX_POLYGON CORNER CORNERS CLOSE CMYK CODED COMPLAINT CONTROL CORNER CORNERS CROSS CUSTOM DARKEST DEGREES DEG_TO_RAD DELETE DIAMETER DIFFERENCE DIFFUSE DILATE DIRECTIONAL DISABLE_ACCURATE_TEXTURES DISABLE_DEPTH_SORT DISABLE_NATIVE_FONTS DISABLE_OPENGL_ERROR_REPORT DISABLE_TEXT_SMOOTH DISABLED DODGE DOWN DXF ENABLE_ACCURATE_TEXTURES ENABLE_DEPTH_SORT ENABLE_NATIVE_FONTS DISABLE_OPENGL_2X_SMOOTH ENABLE_OPENGL_4X_SMOOTH ENABLE_OPENGL_ERROR_REPORT ENTER EPSILON ERODE ESC EXCLUSION GIF GRAY GREEN_MASK GROUP HALF HALF_PI HAND HARD_LIGHT HINT_COUNT HSB IMAGE INVERT JAVA2D JPEG LEFT LIGHTEST LINES LINUX MACOSX MAX_FLOAT MAX_INT MITER MODEL MOVE MULTIPLY NORMAL NO_DEPTH_TEST NTSC ONE OPAQUE OPEN OPENGL ORTHOGRAPHIC OVERLAY PAL P2D P3D PERSPECTIVE PI PIXEL_CENTER POINT POINTS POSTERIZE PROBLEM PROJECT QUAD_STRIP QUADS QUARTER_PI RAD_TO_DEG RADIUS RADIANS RED_MASK REPLACE RETURN RGB RIGHT ROUND SCREEN SECAM SHIFT SPECULAR SOFT_LIGHT SQUARE SUBTRACT SVIDEO TAB TARGA TEXT TFF THIRD_PI THRESHOLD TIFF TOP TRIANGLE_FAN TRIANGLES TRIANGLE_STRIP TUNER TWO TWO_PI UP WAIT WHITESPACE focused frameCount frameRate HALF_PI height key keyCode keyPressed mouseButton mousePressed mouseX mouseY online PI height pixels width pixels pmouseX pmouseY screen TWO_PI width';
					
	var keywords3 =	'draw popStyle pushStyle setup';

	this.regexList = [
		{ regex: SyntaxHighlighter.regexLib.singleLineCComments,	css: 'comments' },			// one line comments
		{ regex: SyntaxHighlighter.regexLib.multiLineCComments,		css: 'comments' },			// multiline comments
		{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'color4' },			// strings
		{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'color4' },			// strings
		{ regex: /^ *#.*/gm,										css: 'preprocessor' },
		{ regex: new RegExp(this.getKeywords(keywords1), 'gm'),		css: 'color5' },
		{ regex: new RegExp(this.getKeywords(keywords2), 'gm'),		css: 'color4' },
		{ regex: new RegExp(this.getKeywords(keywords3), 'gm'),		css: 'color5 bold' }
		];
};

SyntaxHighlighter.brushes.Processing.prototype	= new SyntaxHighlighter.Highlighter();
SyntaxHighlighter.brushes.Processing.aliases	= ['Processing', 'processing'];
