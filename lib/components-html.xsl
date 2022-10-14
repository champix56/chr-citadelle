<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:import href="./styles.xsl"/>
<xsl:template match="br">
	<fo:block/>
</xsl:template>
<xsl:template match="hr">
	<fo:block border-top="0.3mm solid black"/>
</xsl:template>
<xsl:template match="strong">
	<fo:inline xsl:use-attribute-sets="strong">
		<xsl:apply-templates select="*|text()"/>
	</fo:inline>
</xsl:template>
<xsl:template match="u">
	<fo:inline xsl:use-attribute-sets="underline">
		<xsl:apply-templates select="*|text()"/>
	</fo:inline>
</xsl:template>
<xsl:template match="sup">
	<fo:inline xsl:use-attribute-sets="sup" ><xsl:apply-templates select="*|text()"/></fo:inline>
</xsl:template>
<xsl:template match="sub">
	<fo:inline xsl:use-attribute-sets="sub" ><xsl:apply-templates select="*|text()"/></fo:inline>
</xsl:template>
<xsl:template match="s">
	<fo:inline xsl:use-attribute-sets="s" ><xsl:apply-templates select="*|text()"/></fo:inline>
</xsl:template>
<xsl:template match="div[contains(@style,'text-align: ')]">
<xsl:variable name="alignTypeWithPonctuation" select="substring(@style,13)"/>
<xsl:variable name="alignType" select="substring($alignTypeWithPonctuation,1,string-length($alignTypeWithPonctuation)-1)"/>
	<fo:block text-align="{$alignType}">
		<xsl:apply-templates select="*|text()"/>
	</fo:block>
</xsl:template>
</xsl:stylesheet>
