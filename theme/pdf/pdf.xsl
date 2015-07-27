<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="h l">

  <!-- Repurpose figure.border.div to add extra div child around figure content, per RB -->
  <xsl:param name="figure.border.div" select="1"/>

  <!-- Adding a numeration format for sect1s -->
  <xsl:param name="label.numeration.by.data-type">
appendix:A
chapter:1
part:I
sect1:1
sect2:none
sect3:none
sect4:none
sect5:none
</xsl:param>

  <xsl:variable name="lowercase-letters" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase-letters" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <!-- Handling for <div> child for figures, per RB -->
  <xsl:template name="process-figure-contents">
    <xsl:param name="node" select="."/>
    <xsl:param name="figure.border.div" select="$figure.border.div"/>
    <!-- If the parameter $figure.border.div is enabled, and there is a figure caption, add a child div and put everything but the caption in it -->
    <!-- Switch to the appropriate context node -->
    <xsl:for-each select="$node[1]">
      <xsl:choose>
	<!-- BEGIN OVERRIDE -->
	<!-- Figcaption can stay inside the figure div, per RB -->
	<xsl:when test="($figure.border.div = 1) and not(@data-type='cover')">
	  <div class="figure-container">
	    <xsl:apply-templates/>
	  </div>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates/>
	</xsl:otherwise>
      </xsl:choose>
      <!-- END OVERRIDE -->
    </xsl:for-each>
  </xsl:template>

  <!-- Add an extra <div> child to "exercise" asides, per RB -->
  <!-- Overrides aside template handling in elements.xsl in core HTMLBook stylesheets -->
  <xsl:template match="h:aside[@class='exercise']">
        <xsl:param name="html4.structural.elements" select="$html4.structural.elements"/>
    <xsl:variable name="output-element-name">
      <xsl:call-template name="html.output.element">
	<xsl:with-param name="html4.structural.elements" select="$html4.structural.elements"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:copy>
      <xsl:apply-templates select="@*[not(local-name() = 'id')]"/>
      <xsl:choose>
	<!-- If output element name matches local name (i.e., HTML4 fallback elements disabled), copy element as is and process descendant content -->
	<!-- ToDo: Refactor duplicate code in when/otherwise; perhaps do an apply-templates select="." with a process-section mode -->
	<xsl:when test="$output-element-name = local-name()">
	  <xsl:attribute name="id">
	    <xsl:call-template name="object.id"/>
	  </xsl:attribute>
	  <!-- BEGIN OVERRIDE -->
	  <!-- Per RB, wrap all child content in a <div> except the initial heading -->
	  <xsl:apply-templates select="*[1][self::h:h1 or self::h:h2 or self::h:h3 or self::h:h4 or self::h:h5 or self::h:h6]"/>
	  <div class="exercise-div">
	    <xsl:apply-templates select="*[not((position() = 1) and (self::h:h1 or self::h:h2 or self::h:h3 or self::h:h4 or self::h:h5 or self::h:h6))]"/>
	  </div>
	  <!-- END OVERRIDE -->
	  <xsl:if test="$process.footnotes = 1">
	    <xsl:call-template name="generate-footnotes"/>
	  </xsl:if>
	</xsl:when>
	<!-- If output element name does not match local name (i.e., HTML4 fallback elements enabled), copy element, but add an HTML4
	     fallback child wrapper to include descendant content -->
	<xsl:otherwise>
	  <xsl:element name="{$output-element-name}" namespace="http://www.w3.org/1999/xhtml">
	    <!-- Put a class on it with the proper semantic name -->
	    <xsl:attribute name="class">
	      <xsl:call-template name="semantic-name"/>
	    </xsl:attribute>
	    <xsl:attribute name="id">
	      <xsl:call-template name="object.id"/>
	    </xsl:attribute>
	    <!-- BEGIN OVERRIDE -->
	    <!-- Per RB, wrap all child content in a <div> except the initial heading -->
	    <xsl:apply-templates select="*[1][self::h:h1 or self::h:h2 or self::h:h3 or self::h:h4 or self::h:h5 or self::h:h6]"/>
	    <div class="exercise-div">
	      <xsl:apply-templates select="not(*[1][self::h:h1 or self::h:h2 or self::h:h3 or self::h:h4 or self::h:h5 or self::h:h6])"/>
	    </div>
	    <!-- END OVERRIDE -->
	    <xsl:if test="$process.footnotes = 1">
	      <xsl:call-template name="generate-footnotes"/>
	    </xsl:if>
	  </xsl:element>
	</xsl:otherwise>
      </xsl:choose>      
    </xsl:copy>
  </xsl:template>

  <!-- In this template, Parts are numbered with English words (e.g., "one", "two", etc.), so add those in data-label attrs -->
  <xsl:template match="h:div[@data-type='part']/h:h1" mode="process-heading">
    <xsl:param name="autogenerate.labels" select="$autogenerate.labels"/>
    <!-- Labeled element is typically the parent element of the heading (e.g., <section> or <figure>) -->
    <xsl:param name="labeled-element" select="(parent::h:header/parent::*|parent::*[not(self::h:header)])[1]"/>
    <!-- Labeled element semantic name is typically the parent element of the heading's @data-type -->
    <xsl:param name="labeled-element-semantic-name" select="(parent::h:header/parent::*|parent::*[not(self::h:header)])[1]/@data-type"/>
    <!-- Name for output heading element; same as current node name by default -->
    <xsl:param name="output-element-name" select="local-name(.)"/>
    <xsl:element name="{$output-element-name}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="@*"/>
      <!-- BEGIN OVERRIDE -->
      <!-- No autogeneration of labels in content; instead, we add a data-label attribute -->
      <xsl:variable name="arabic-label">
	<!-- Note: Didn't use label.markup here, as it's configured to output Roman numerals, and didn't want to tweak that logic just yet,
	     in case it was needed for other aspects of the book. Figured it was better to just silo the logic for data-label for now -->

	<!-- Switch context node to Part to be labeled, just to be safe -->
	<xsl:for-each select="$labeled-element">
	  <xsl:number count="h:div[@data-type='part']" level="any"/>
	</xsl:for-each>
      </xsl:variable>
      <!-- Convert to words -->
      <xsl:attribute name="data-label">
	<xsl:variable name="number-word">
	  <xsl:call-template name="get-localization-value">
	    <xsl:with-param name="context" select="'number-words'"/>
	    <xsl:with-param name="gentext-key" select="$arabic-label"/>
	  </xsl:call-template>
	</xsl:variable>
	<!-- Uppercase first letter of number word -->
	<xsl:value-of select="concat(translate(substring($number-word, 1, 1), $lowercase-letters, $uppercase-letters), substring($number-word, 2))"/>
      </xsl:attribute>
      <!-- END OVERRIDE -->
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- In this template, Parts are called "Lessons", so update data-pdf-bookmark attrs accordingly -->
  <xsl:template match="h:div[@data-type='part']" mode="pdf-bookmark">
    <xsl:choose>
      <xsl:when test="@data-pdf-bookmark">
	<xsl:attribute name="data-pdf-bookmark" select="@data-pdf-bookmark"/>
      </xsl:when>
      <xsl:when test="h:h1 or h:header/h:h1">
	<xsl:variable name="processed-heading">
	  <xsl:apply-templates select="(h:h1|h:header/h:h1)[1]" mode="process-heading">
	    <!-- BEGIN OVERRIDE -->
	    <!-- No labels; we'll prepend something custom-defined in this template -->
	    <xsl:with-param name="autogenerate.labels" select="0"/>
	    <!-- END OVERRIDE -->
	  </xsl:apply-templates>
	</xsl:variable>
	<xsl:attribute name="data-pdf-bookmark">
	  <!-- BEGIN OVERRIDE -->
	  <!-- Prepend "Lesson #." to heading -->
	  <xsl:text>Lesson </xsl:text>
	  <xsl:number count="h:div[@data-type='part']" level="any"/>
	  <xsl:text>. </xsl:text>
	  <!-- END OVERRIDE -->
	  <xsl:value-of select="$processed-heading"/>
	</xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Custom XREF handling for asides with class of "exercise" -->
  <xsl:template match="h:aside[contains(@class, 'exercise')]" mode="xref-to">
    <xsl:param name="referrer"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="verbose" select="1"/>
    
    <xsl:apply-templates select="." mode="object.xref.markup">
      <xsl:with-param name="purpose" select="'xref'"/>
      <!-- BEGIN THEME OVERRIDE -->
      <xsl:with-param name="xrefstyle" select="'template:Exercise %n'"/>
      <!-- END THEME OVERRIDE -->
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="verbose" select="$verbose"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Custom XREF handling for Chapter Sect1s of format "Section #-#" -->
  <xsl:template match="h:section[@data-type='chapter']//h:section[@data-type='sect1']" mode="xref-to">
    <xsl:param name="referrer"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="verbose" select="1"/>
    
    <xsl:apply-templates select="." mode="object.xref.markup">
      <xsl:with-param name="purpose" select="'xref'"/>
      <!-- BEGIN THEME OVERRIDE -->
      <xsl:with-param name="xrefstyle" select="'template:Section %n'"/>
      <!-- END THEME OVERRIDE -->
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="verbose" select="$verbose"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Custom XREF handling for Parts (which should be called Lessons) -->
  <xsl:template match="h:div[@data-type='part']" mode="xref-to">
    <xsl:param name="referrer"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="verbose" select="1"/>
    
    <xsl:apply-templates select="." mode="object.xref.markup">
      <xsl:with-param name="purpose" select="'xref'"/>
      <!-- BEGIN THEME OVERRIDE -->
      <xsl:with-param name="xrefstyle" select="'template:Lesson %n'"/>
      <!-- END THEME OVERRIDE -->
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="verbose" select="$verbose"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Custom XREF handling for XREFs to "p" elements with class of "error": no gentext (page number only, handled in following template -->
  <xsl:template match="h:p[@class='error']" mode="object.xref.markup"/>

  <!-- Custom class.value handling for XREFs to "p" elements with class of "error" (turn on page numbering) -->
  <xsl:template match="h:a[@data-type='xref']" mode="class.value">
    <xsl:param name="class" select="@class"/>
    <xsl:param name="xref.elements.pagenum.in.class" select="$xref.elements.pagenum.in.class"/>
    <xsl:param name="xref.target"/>
    <xsl:choose>
      <!-- BEGIN THEME OVERRIDE -->
      <xsl:when test="$xref.target[self::h:p[contains(@class, 'error')]]">
	<xsl:value-of select="normalize-space(concat($class, ' pagenum_only'))"/>
      </xsl:when>
      <!-- END THEME OVERRIDE -->
      <xsl:otherwise>
	<!-- Use main HTMLBook stylesheet for everything else -->
	<xsl:choose>
	  <!-- If there's an xref target, process that to determine whether a pagenum value should be added to the class -->
	  <xsl:when test="$xref.target">
	    <xsl:variable name="xref.target.semantic.name">
	      <xsl:call-template name="semantic-name">
		<xsl:with-param name="node" select="$xref.target"/>
	      </xsl:call-template>
	    </xsl:variable>
	    <xsl:if test="$class != ''">
	      <xsl:value-of select="$class"/>
	    </xsl:if>
	    <!-- Check if target semantic name is in list of XREF elements containing pagenum -->
	    <!-- ToDo: Consider modularizing logic into separate function if needed for reuse elsewhere -->
	    <xsl:variable name="space-delimited-pagenum-elements" select="concat(' ', normalize-space($xref.elements.pagenum.in.class), ' ')"/>
	    <xsl:variable name="substring-before-target-name" select="substring-before($space-delimited-pagenum-elements, $xref.target.semantic.name)"/>
	    <xsl:variable name="substring-after-target-name" select="substring-after($space-delimited-pagenum-elements, $xref.target.semantic.name)"/>
	    <!-- Make sure a match is both preceded and followed by a space -->
	    <xsl:if test="substring($substring-after-target-name, 1, 1) and
			  substring($substring-before-target-name, string-length($substring-before-target-name), 1)">
	      <xsl:if test="$class != ''"><xsl:text> </xsl:text></xsl:if>
	      <xsl:text>pagenum</xsl:text>
	    </xsl:if>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:if test="$class != ''">
	      <xsl:value-of select="$class"/>
	    </xsl:if>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Custom label markup for asides with class "exercise": which should be #-# -->
  <xsl:template match="h:aside[contains(@class, 'exercise')]" mode="label.markup">
    <xsl:apply-templates select="." mode="label.formal.ancestor"/>
    <xsl:apply-templates select="." mode="intralabel.punctuation"/>
    <xsl:number count="h:aside[contains(@class, 'exercise')]" 
		from="h:section[contains(@data-type, 'acknowledgments') or
		      contains(@data-type, 'afterword') or
		      contains(@data-type, 'appendix') or
		      contains(@data-type, 'bibliography') or
		      contains(@data-type, 'chapter') or
		      contains(@data-type, 'colophon') or
		      contains(@data-type, 'conclusion') or
		      contains(@data-type, 'copyright-page') or
		      contains(@data-type, 'dedication') or
		      contains(@data-type, 'foreword') or
		      contains(@data-type, 'glossary') or
		      contains(@data-type, 'halftitlepage') or
		      contains(@data-type, 'index') or
		      contains(@data-type, 'introduction') or
		      contains(@data-type, 'preface') or
		      contains(@data-type, 'titlepage') or
		      contains(@data-type, 'toc')]|
		      h:div[contains(@data-type, 'part')]" level="any" format="1"/>
  </xsl:template>

  <!-- Same exact handling in core HTMLBook as for figures/tables/examples -->
  <xsl:template match="h:aside[contains(@class, 'exercise')]" mode="label.formal.ancestor">
    <xsl:choose>
      <!-- For Preface and Introduction, custom label prefixes for formal ancestor
	   (don't use label.markup template here, as these labels are typically specific to just formal-object context -->
      <xsl:when test="ancestor::h:section[@data-type = 'preface']">P</xsl:when>
      <xsl:when test="ancestor::h:section[@data-type = 'introduction']">I</xsl:when>
      <xsl:otherwise>
	<!-- Otherwise, go ahead and use label.markup to get proper label numeral for ancestor -->
	<xsl:apply-templates select="(ancestor::h:section[contains(@data-type, 'acknowledgments') or
				     contains(@data-type, 'afterword') or
				     contains(@data-type, 'appendix') or
				     contains(@data-type, 'bibliography') or
				     contains(@data-type, 'chapter') or
				     contains(@data-type, 'colophon') or
				     contains(@data-type, 'conclusion') or
				     contains(@data-type, 'copyright-page') or
				     contains(@data-type, 'dedication') or
				     contains(@data-type, 'foreword') or
				     contains(@data-type, 'glossary') or
				     contains(@data-type, 'halftitlepage') or
				     contains(@data-type, 'index') or
				     contains(@data-type, 'introduction') or
				     contains(@data-type, 'preface') or
				     contains(@data-type, 'titlepage') or
				     contains(@data-type, 'toc')]|
				     ancestor::h:div[@data-type = 'part'])[last()]" mode="label.markup"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="h:aside[contains(@class, 'exercise')]|h:section[@data-type='sect1']" mode="intralabel.punctuation">
    <xsl:text>-</xsl:text>
  </xsl:template>

  <!-- Figures are not captioned in this theme, so don't exclude ones with empty figcaptions from labeling -->
  <xsl:template match="h:figure" mode="label.markup">
    <xsl:param name="label.formal.with.ancestor" select="$label.formal.with.ancestor"/>
    <xsl:choose>
      <xsl:when test="$label.formal.with.ancestor != 0">
	<xsl:apply-templates select="." mode="label.formal.ancestor"/>
	<xsl:apply-templates select="." mode="intralabel.punctuation"/>
	<!-- BEGIN THEME OVERRIDE -->
	<xsl:number count="h:figure[not(contains(@data-type, 'cover'))]" from="h:section[contains(@data-type, 'acknowledgments') or
					   contains(@data-type, 'afterword') or
					   contains(@data-type, 'appendix') or
					   contains(@data-type, 'bibliography') or
					   contains(@data-type, 'chapter') or
					   contains(@data-type, 'colophon') or
					   contains(@data-type, 'conclusion') or
					   contains(@data-type, 'copyright-page') or
					   contains(@data-type, 'dedication') or
					   contains(@data-type, 'foreword') or
					   contains(@data-type, 'glossary') or
					   contains(@data-type, 'halftitlepage') or
					   contains(@data-type, 'index') or
					   contains(@data-type, 'introduction') or
					   contains(@data-type, 'preface') or
					   contains(@data-type, 'titlepage') or
					   contains(@data-type, 'toc')]|
					   h:div[contains(@data-type, 'part')]" level="any" format="1"/>
	<!-- END THEME OVERRIDE -->
      </xsl:when>
      <xsl:otherwise>
	<!-- BEGIN THEME OVERRIDE -->
	<xsl:number count="h:figure[not(contains(@data-type, 'cover'))]" level="any" format="1"/>
	<!-- END THEME OVERRIDE -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- In this series, sect1 headings get labels like this #-#. No punction between label and title -->
  <xsl:template match="h:section[@data-type='chapter' or @data-type='appendix']//h:section[@data-type='sect1']//h:h1" mode="process-heading">
    <xsl:param name="autogenerate.labels" select="$autogenerate.labels"/>
    <!-- Labeled element is typically the parent element of the heading (e.g., <section> or <figure>) -->
    <xsl:param name="labeled-element" select="(parent::h:header/parent::*|parent::*[not(self::h:header)])[1]"/>
    <!-- Labeled element semantic name is typically the parent element of the heading's @data-type -->
    <xsl:param name="labeled-element-semantic-name" select="(parent::h:header/parent::*|parent::*[not(self::h:header)])[1]/@data-type"/>
    <!-- Name for output heading element; same as current node name by default -->
    <xsl:param name="output-element-name" select="local-name(.)"/>
    <xsl:element name="{$output-element-name}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="@*"/>
      <!-- BEGIN THEME OVERRIDE -->
      <xsl:variable name="heading.label">
	<xsl:apply-templates select="$labeled-element" mode="label.markup"/>
      </xsl:variable>
      <xsl:if test="$heading.label != ''">
	<span class="label">
	  <xsl:value-of select="$heading.label"/>
	  <!-- Label and title separator is just a space -->
	  <xsl:text> </xsl:text>
	</span>
      </xsl:if>
      <!-- END THEME OVERRIDE -->
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- Overriding to label sect1s with chapter or appendix ancestor -->
  <xsl:template match="h:section[@data-type='chapter' or @data-type='appendix']//h:section[@data-type='sect1']" mode="label.markup">
    <xsl:variable name="current-node" select="."/>
    <!-- BEGIN THEME OVERRIDE -->
    <xsl:for-each select="ancestor::h:section">
      <xsl:call-template name="get-label-from-data-type">
	<xsl:with-param name="data-type" select="@data-type"/>
      </xsl:call-template>
      <xsl:apply-templates select="$current-node" mode="intralabel.punctuation"/>
    </xsl:for-each>
    <xsl:number count="h:section[@data-type='sect1']" level="any" format="1" from="h:section[@data-type='chapter']|h:section[@data-type='appendix']"/>
    <!-- END THEME OVERRIDE -->
  </xsl:template>

  <!-- No PDF bookmark labels for sect1s not in chapters -->
  <xsl:template match="h:section[@data-type='sect1' and not(ancestor::h:section[@data-type='chapter'] 
		                                         or ancestor::h:section[@data-type='appendix'])]" mode="pdf-bookmark">
    <xsl:choose>
      <xsl:when test="@data-pdf-bookmark">
	<xsl:attribute name="data-pdf-bookmark" select="@data-pdf-bookmark"/>
      </xsl:when>
      <xsl:when test="h:h1 or h:header/h:h1">
	<xsl:variable name="processed-heading">
	  <xsl:apply-templates select="(h:h1|h:header/h:h1)[1]" mode="process-heading">
	    <!-- BEGIN THEME OVERRIDE -->
	    <!-- No Labels! -->
	    <xsl:with-param name="autogenerate.labels" select="0"/>
	    <!-- END THEME OVERRIDE -->
	  </xsl:apply-templates>
	</xsl:variable>
	<xsl:attribute name="data-pdf-bookmark">
	  <xsl:value-of select="$processed-heading"/>
	</xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
