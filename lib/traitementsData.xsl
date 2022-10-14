<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="toUpperCase">
		<xsl:param name="str"/>
		<xsl:value-of select="translate($str,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	</xsl:template>
	<xsl:template name="toLowerCase">
		<xsl:param name="str"/>
		<xsl:value-of select="translate($str,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>
	<xsl:template name="dateToLocale">
		<xsl:param name="str"/>
		<xsl:value-of select="substring($str,7,2)"/>/<xsl:value-of select="substring($str,5,2)"/>/<xsl:value-of select="substring($str,1,4)"/>
	</xsl:template>
	<xsl:template name="timeToLocale">
		<xsl:param name="withSecondes" select=" 'true'  "/>
		<xsl:param name="str"/>
		<xsl:value-of select="substring($str,1,2)"/>:<xsl:value-of select="substring($str,3,2)"/>
		<xsl:if test="string-length($str)>4 and $withSecondes='true' ">:<xsl:value-of select="substring($str,5,2)"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
