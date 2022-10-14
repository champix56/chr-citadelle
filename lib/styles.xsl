<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:attribute-set name="title-1">
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="underline">
		<xsl:attribute name="text-decoration">underline</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="strong">
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="sup">
		<xsl:attribute name="vertical-align">super</xsl:attribute>
		<xsl:attribute name="font-size">smaller</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="sub">
		<xsl:attribute name="vertical-align">sub</xsl:attribute>
		<xsl:attribute name="font-size">smaller</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="s">
		<xsl:attribute name="text-decoration">line-through</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="td">
	</xsl:attribute-set>
	<xsl:attribute-set name="th">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="font-weight">900</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
