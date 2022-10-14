<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:import href="./styles.xsl"/>
	<xsl:template name="indexOfChar">
		<xsl:param name="string"/>
		<xsl:param name="char"/>
		<xsl:param name="i" select="1"/>
		<xsl:param name="strlen" select="string-length($string)"/>
		<xsl:choose>
			<xsl:when test="$i>$strlen">-1</xsl:when>
			<xsl:when test="substring($string,$i,1)=$char">
				<xsl:value-of select="$i"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="indexOfChar">
					<xsl:with-param name="i" select="$i+1"/>
					<xsl:with-param name="strlen" select="$strlen"/>
					<xsl:with-param name="string" select="$string"/>
					<xsl:with-param name="char" select="$char"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--auto merge style-->
	<xsl:template match="div" priority="2">
		<xsl:variable name="indexOf">
			<xsl:call-template name="indexOfChar">
				<xsl:with-param name="char">:</xsl:with-param>
				<xsl:with-param name="string" select="@style"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="propriete" select="substring(@style,1,$indexOf - 1)"/>
		<xsl:variable name="valueWithPonctuation" select="substring(@style,$indexOf + 1)"/>
		<xsl:variable name="value" select="substring($valueWithPonctuation,2,string-length($valueWithPonctuation)-1)"/>
		<xsl:element name="fo:block">
			<xsl:attribute name="{$propriete}"><xsl:value-of select="$value"/></xsl:attribute>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
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
		<fo:inline xsl:use-attribute-sets="sup">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="sub">
		<fo:inline xsl:use-attribute-sets="sub">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="s">
		<fo:inline xsl:use-attribute-sets="s">
			<xsl:apply-templates select="*|text()"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="div[contains(@style,'margin')]" priority="2">
		<!--exception pour les div avec des style margin-->
		<xsl:variable name="colonPosition">
			<xsl:call-template name="indexOfChar">
				<xsl:with-param name="string" select="@style"/>
				<xsl:with-param name="char">:</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="margin">
			<xsl:value-of select="substring(@style,1,$colonPosition - 1 )"/>
		</xsl:variable>
		<!--<xsl:variable name="marginType">
			<xsl:value-of select="substring(@style,8,$colonPosition - 8)"/>
		</xsl:variable>-->
		<xsl:variable name="propertyValueWithSemicolon" select="substring(@style,$colonPosition+2)"/>
		<xsl:variable name="propertyValue" select="substring($propertyValueWithSemicolon,1,string-length($propertyValueWithSemicolon)-1)"/>
		<xsl:element name="fo:block">
			<xsl:attribute name="{$margin}"><xsl:value-of select="$propertyValue"/></xsl:attribute>
				MARGIN - <xsl:value-of select="$margin"/>
			<fo:block/>
			<xsl:apply-templates select="*|text()"/>
		</xsl:element>
	</xsl:template>
	<!--	

		deprecié et remplacé par div[@style]

-->
	<!--<xsl:template match="div[contains(@style,'text-align: ')]">
		<xsl:variable name="alignTypeWithPonctuation" select="substring(@style,13)"/>
		<xsl:variable name="alignType" select="substring($alignTypeWithPonctuation,1,string-length($alignTypeWithPonctuation)-1)"/>
		<fo:block text-align="{$alignType}">
			<xsl:apply-templates select="*|text()"/>
		</fo:block>
	</xsl:template>-->
</xsl:stylesheet>
