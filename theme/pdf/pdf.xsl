<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="h">


<!-- Callout handling: insert img tags with calculated numbers -->
<xsl:template match="h:a[@class='co']">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:element name="img">
      <xsl:choose>
        <xsl:when test="ancestor::h:pre">
          <xsl:attribute name="src">callouts/<xsl:number level="any" from="h:pre" format="1"/>.pdf</xsl:attribute>
          <xsl:attribute name="alt"><xsl:number level="any" from="h:pre" format="1"/></xsl:attribute>
        </xsl:when>
        <xsl:when test="ancestor::h:dt">
          <xsl:attribute name="src">callouts/<xsl:number level="any" from="h:dl" format="1"/>.pdf</xsl:attribute>
          <xsl:attribute name="alt"><xsl:number level="any" from="h:dl" format="1"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="get-number">
            <xsl:call-template name="substring-after-last-hyphen">
              <xsl:with-param name="string" select="@href" />
              <xsl:with-param name="delimiter" select="'-'" />
            </xsl:call-template>
          </xsl:variable>
          <xsl:attribute name="src">callouts/<xsl:value-of select="$get-number"/>.pdf</xsl:attribute>
          <xsl:attribute name="alt"><xsl:value-of select="$get-number"/></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:copy>
</xsl:template>

<xsl:template name="substring-after-last-hyphen">
  <xsl:param name="string"/>
  <xsl:param name="delimiter"/>
  <xsl:choose>
    <xsl:when test="contains($string, $delimiter)">
      <xsl:call-template name="substring-after-last-hyphen">
        <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
        <xsl:with-param name="delimiter" select="$delimiter" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>