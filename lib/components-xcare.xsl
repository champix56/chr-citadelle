<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="*">
		<fo:block border="0.3mm solid red" padding="2mm">
			style : <xsl:value-of select="@style"/>
			<fo:block font-size="8pt" font-style="italic">
				<xsl:value-of select="name()"/>
				<fo:block/>
				label/unformat : <xsl:value-of select="@label"/> / <xsl:value-of select="@unformattedLabel"/>
			</fo:block>
		</fo:block>
	</xsl:template>

	<xsl:template match="*[@style='txt' or @style='textArea']">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="*[@style='lbl']">
		<xsl:choose>
			<xsl:when test="string-length(@unformattedLabel)>0">
				<xsl:value-of select="@unformattedLabel"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@label"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
