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
</xsl:stylesheet>
