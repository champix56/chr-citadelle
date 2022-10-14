<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:import href="./traitementsData.xsl"/>
	<xsl:template match="service">
		<fo:block>
			<xsl:apply-templates select="sections/section"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="sections/section">
		<fo:block margin-bottom="8mm">
			<xsl:apply-templates select="ligne"/>
			<xsl:if test="@isMaster= 'true' ">
				<fo:block margin-bottom="5mm"/>
			</xsl:if>
		</fo:block>
	</xsl:template>
	<xsl:template match="section/ligne">
		<xsl:variable name="boldValue">
			<xsl:choose>
				<xsl:when test="@titre">900</xsl:when>
				<xsl:otherwise>500</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:block font-weight="{$boldValue}">
			<xsl:copy-of select="text()|*"/>
		</fo:block>
	</xsl:template>
	<xsl:template name="static-contents">
		<!--si le champ hidden est present pour la spec lié a la convention de nommage de fichier pour le service, il est placé par defaut dans le param-->
		<xsl:param name="service" select="/*/hdd_SpecialiteCartouche"/>
		<xsl:variable name="doc_name" select="concat('../services/',$service,'.xml')"/>
		<xsl:variable name="doc_service" select="document($doc_name)"/>
		<xsl:variable name="img_service">
			<xsl:choose>
				<xsl:when test="string-length($doc_service/service/@logoLeft)>4">
					<xsl:value-of select="$doc_service/service/@logoLeft"/>
				</xsl:when>
				<xsl:otherwise>logoCitadelle.png</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:static-content flow-name="avecCartouche">
			<fo:block font-size="7pt" margin-left="3mm" margin-top="30mm">
				<xsl:apply-templates select="$doc_service/service"/>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="sansCartouche">
			<fo:block/>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-before">
			<fo:block>
				<fo:table background-color="skyblue" margin-left="-3cm">
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									<fo:external-graphic src="./logo/{$img_service}" scaling="uniform" content-height="3cm" content-width="5cm"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:if test="string-length($doc_service/service/@logoRight)>4">
										<fo:external-graphic src="./logo/{$doc_service/service/@logoRight}" scaling="uniform" content-height="3cm" content-width="5cm"/>
									</xsl:if>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:static-content>
		<fo:static-content flow-name="xsl-region-after">
			<fo:block>
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="50%"/>
					<fo:table-body>
						<fo:table-row border-bottom="0.3mm solid black">
							<fo:table-cell>
								<fo:block>
									<xsl:call-template name="toUpperCase">
										<xsl:with-param name="str" select="/*/@patLastName"/>
									</xsl:call-template>
									<xsl:text> </xsl:text>
									<xsl:call-template name="toUpperCase">
										<xsl:with-param name="str" select="/*/@patFirstName"/>
									</xsl:call-template> - 
									<xsl:call-template name="dateToLocale">
										<xsl:with-param name="str" select="/*/@noteDate"/>
									</xsl:call-template>
									<fo:block font-style="italic" font-size="6pt">
									Imprimé le <xsl:call-template name="dateToLocale">
											<xsl:with-param name="str" select="/*/@impressionTs"/>
										</xsl:call-template> à <xsl:call-template name="timeToLocale">
											<xsl:with-param name="str" select="substring(/*/@impressionTs,9)"/>
										</xsl:call-template> par <xsl:value-of select="/*/@userFirstName"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="/*/@userLastName"/>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right">pages : <fo:page-number/></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	<xsl:template name="layout">
		<fo:layout-master-set>
			<xsl:call-template name="layout-sets"/>
		</fo:layout-master-set>
	</xsl:template>
	<xsl:template name="layout-sets">
		<!-- Première Page - Cartouche - En-tete -->
		<fo:simple-page-master master-name="premierePage" page-height="297mm" page-width="21cm">
			<fo:region-body margin-bottom="2.5cm" margin-top="3.5cm" margin-left="4.5cm" margin-right="1.5cm"/>
			<fo:region-before extent="3cm"/>
			<fo:region-after extent="2cm"/>
			<fo:region-start extent="4cm" region-name="avecCartouche"/>
			<fo:region-end extent="1.5cm"/>
		</fo:simple-page-master>
		<!-- Pages suivantes - pas de cartouche - pas d'en-tete -->
		<fo:simple-page-master master-name="autresPages" page-height="297mm" page-width="21cm">
			<fo:region-body margin-bottom="2.5cm" margin-top="3cm" margin-left="4.5cm" margin-right="1.5cm"/>
			<fo:region-before extent="3cm"/>
			<fo:region-after extent="2cm"/>
			<fo:region-start extent="4cm" region-name="sansCartouche"/>
			<fo:region-end extent="1.5cm"/>
		</fo:simple-page-master>
		<!-- A appeler dans le document principal -->
		<fo:page-sequence-master master-name="documentPrincipal">
			<fo:repeatable-page-master-alternatives>
				<fo:conditional-page-master-reference master-reference="premierePage" page-position="first"/>
				<fo:conditional-page-master-reference master-reference="autresPages" page-position="rest"/>
			</fo:repeatable-page-master-alternatives>
		</fo:page-sequence-master>
	</xsl:template>
</xsl:stylesheet>
