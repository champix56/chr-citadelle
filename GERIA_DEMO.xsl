<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:import href="./lib/layout.xsl"/>
	<xsl:import href="./lib/styles.xsl"/>
	<xsl:import href="./lib/components-xcare.xsl"/>
	<xsl:output method="xml" version="1.0" indent="yes"/>
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<xsl:call-template name="layout-sets"/>
				<fo:simple-page-master master-name="10x15">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="documentPrincipal">
				<xsl:call-template name="static-contents">
					<xsl:with-param name="service">pediatrie</xsl:with-param>
				</xsl:call-template>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<fo:block xsl:use-attribute-sets="underline h1">
						DEBUG DOC
					</fo:block>
					Bonjour cher c<xsl:apply-templates select="/*/@patFirstName"/><xsl:apply-templates select="/*/@patLastName"/>
				<fo:block xsl:use-attribute-sets="h1">Graphique + tableau</fo:block>
						<xsl:apply-templates select="/*/grf_temperature"/>
						<fo:block xsl:use-attribute-sets="hr"/>
						<xsl:apply-templates select="/*/grf_temperature" mode="graph"/>
						<fo:block xsl:use-attribute-sets="hr"/>
						<xsl:apply-templates select="/*/*"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
