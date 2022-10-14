<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:include href="./components-html.xsl"/>
<xsl:template match="*[@style='richetxt']">
	<fo:block>
			<xsl:apply-templates select="text()|*"/>
	</fo:block>
</xsl:template>
<xsl:template match="*[@style='richetxt']//text()">
	<xsl:value-of select="."/>
</xsl:template>
</xsl:stylesheet>
