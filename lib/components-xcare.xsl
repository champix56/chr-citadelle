<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:import href="./styles.xsl"/>
	<xsl:include href="./components-richtext.xsl"/>
	<xsl:template match="*">
		<fo:block border="0.3mm solid red" padding="2mm">
			style : <xsl:value-of select="@style"/> / name : <xsl:value-of select="name()"/>
			<fo:block font-size="8pt" font-style="italic">
				<fo:block/>
				label/unformat : <xsl:value-of select="@label"/> / <xsl:value-of select="@unformattedLabel"/>
				<fo:block/>
				content : <xsl:apply-templates select="*|text()"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="*[@style='txt'] | *[@style='txtArea'] | *[@style='date' ]">
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
	<xsl:template match="*[@style='draw']">
		<!--|*[@style='zoneDraw']-->
		<xsl:param name="width">5cm</xsl:param>
		<xsl:param name="height">5cm</xsl:param>
		<fo:external-graphic src="data:image;base64,{.}" content-height="{$height}" content-width="{$width}" scaling="uniform"/>
	</xsl:template>
	<xsl:template name="makeSVGPointValue">
		<xsl:param name="nodesList"/>
		<xsl:param name="ratioX"/>
		<xsl:param name="ratioY"/>
		<xsl:for-each select="$nodesList/*">
			<xsl:value-of select="$ratioX * position()"/>,<xsl:value-of select="$ratioY * ."/>
			<xsl:if test="position() != last()">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="*[@style='defTab']" mode="graph">
		<xsl:param name="width">5cm</xsl:param>
		<xsl:param name="height">5cm</xsl:param>
		<fo:instream-foreign-object scaling="uniform" content-height="{$height}" content-width="{$width}">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="-30 -20 1540 1030">
			<text x="0" y="0">Hellllllo</text>
				<xsl:variable name="values">
					<xsl:call-template name="makeSVGPointValue">
						<xsl:with-param name="nodesList">
							<xsl:for-each select="./row">
								<values>
									<xsl:value-of select="col[@name='Température']"/>
								</values>
							</xsl:for-each>
						</xsl:with-param>
						<xsl:with-param name="ratioX" select="1500 div count(row)"/>
						<xsl:with-param name="ratioY" select="1000 div 40"/>
					</xsl:call-template>
				</xsl:variable>
				<polyline points="{$values}" stroke="black" stroke-width="5"/>
				<!--			<defs>
					<marker id="arrow" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
						<path d="M 0 0 L 10 5 L 0 10 z"/>
					</marker>
					<marker id="dot" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="5" markerHeight="5">
						<circle cx="5" cy="5" r="5" fill="red"/>
					</marker>
				</defs>
				<g>
					<line y1="80" x1="0" x2="230" y2="80" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="80" class="_GraphCloudPoint-module__legendValue__3_LV5">8</text>
				</g>
				<g>
					<line y1="60" x1="0" x2="230" y2="60" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="60" class="_GraphCloudPoint-module__legendValue__3_LV5">16</text>
				</g>
				<g>
					<line y1="40" x1="0" x2="230" y2="40" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="40" class="_GraphCloudPoint-module__legendValue__3_LV5">24</text>
				</g>
				<g>
					<line y1="20" x1="0" x2="230" y2="20" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="20" class="_GraphCloudPoint-module__legendValue__3_LV5">32</text>
				</g>
				<g>
					<line y1="0" x1="0" x2="230" y2="0" class="_GraphCloudPoint-module__grid__3lSVD"/>
					<text alignment-baseline="middle" text-anchor="end" x="-2" y="0" class="_GraphCloudPoint-module__legendValue__3_LV5">40</text>
				</g>
				<polyline points="16.428571428571427,0 49.28571428571428,22.5 82.14285714285714,42.5 114.99999999999999,0 147.85714285714283,25 180.7142857142857,70 213.57142857142853,42.5" fill="none" stroke="black" marker-start="url(#dot)" marker-end="url(#dot)" marker-mid="url(#dot)"/>
				<polyline points="0,-5 0,100 230,100" fill="none" stroke="black" marker-start="url(#arrow)" marker-end="url(#arrow)"/>-->
			</svg>
		</fo:instream-foreign-object>
		<xsl:value-of select=".//*"/>
	</xsl:template>
	<xsl:template match="*[@style='defTab']">
		<xsl:if test="./row/col">
			<fo:table>
				<fo:table-header>
					<fo:table-row>
						<xsl:for-each select="./row[1]/col/@name">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="th">
									<xsl:value-of select="."/>
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:apply-templates select="row"/>
				</fo:table-body>
			</fo:table>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*[@style='defTab']/row">
		<fo:table-row>
			<xsl:apply-templates select="col"/>
		</fo:table-row>
	</xsl:template>
	<xsl:template match="*[@style='defTab']/row/col">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="."/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	<xsl:template match="*[@toPrint=0] | *[@style='hidden']" priority="10000"/>
	<xsl:template match="list[@style='rad'] | list[@style='chk']">
		<fo:block>
			<xsl:apply-templates select="*"/>
		</fo:block>
	</xsl:template>
	<!--<xsl:template match="list[@style='rad']/*" mode="horizontal">
	
	</xsl:template>-->
	<xsl:template name="svg-checkbox">
		<xsl:param name="isChecked" select="."/>
		<svg width="535" height="531" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
			<title>nxt_checkbox_checked_not_ok</title>
			<defs>
				<linearGradient id="linearGradient3996">
					<stop stop-color="#b8b8b8" id="stop3998" offset="0"/>
					<stop stop-color="#b8b8b8" stop-opacity="0" id="stop4000" offset="1"/>
				</linearGradient>
				<linearGradient y2="1498.8496" x2="-727.92688" y1="1498.8496" x1="-481.63879" gradientTransform="matrix(0.97994177,0,0,1.5038759,-12.092225,-449.52009)" gradientUnits="userSpaceOnUse" id="linearGradient4027" xlink:href="#linearGradient3996"/>
				<linearGradient y2="1498.8496" x2="-727.92688" y1="1498.8496" x1="-481.63879" gradientTransform="matrix(1.1726642,0,0,1.2567202,-14.470369,-375.64336)" gradientUnits="userSpaceOnUse" id="linearGradient4057" xlink:href="#linearGradient3996"/>
				<pattern height="100" width="100" y="0" x="0" patternUnits="userSpaceOnUse" id="gridpattern">
					<image height="100" width="100" y="0" x="0"/>
				</pattern>
				<symbol width="320" id="svg_4" height="320">
					<g id="svg_2">
						<path fill="#0e0" fill-rule="evenodd" stroke-width="0.25pt" id="svg_3" d="m20,200l100,90l180,-180l-35,-35l-145,145l-60,-60l-40,40z"/>
					</g>
				</symbol>
			</defs>
			<metadata id="metadata7">image/svg+xml</metadata>
			<g>
				<title>Layer 1</title>
				<g id="layer2">
					<path fill="none" stroke="#000000" stroke-width="55" stroke-linejoin="round" stroke-miterlimit="4" d="m146.32692,35.025715l244.661789,0c59.216797,0 106.889587,43.416195 106.889587,97.345806l0,263.749268c0,53.929535 -47.672791,97.345764 -106.889587,97.345764l-244.661789,0c-59.216812,0 -106.88958,-43.416229 -106.88958,-97.345764l0,-263.749268c0,-53.929611 47.672768,-97.345806 106.88958,-97.345806z" id="rect2816"/>
				</g>
				<xsl:if test="$isChecked='on' ">
					<use x="104.80185" y="535.339816" transform="matrix(1.43701 0 0 1.75587 -112.523 -996.765)" xlink:href="#svg_4" id="svg_5"/>
				</xsl:if>
			</g>
		</svg>
	</xsl:template>
	<xsl:template match="list[@style='chk']/*">
		<fo:table>
			<fo:table-column column-width="6mm"/>
			<fo:table-column/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell display-align="center">
						<fo:block text-align="center">
							<fo:instream-foreign-object content-height="5mm" content-width="5mm">
								<xsl:call-template name="svg-checkbox"/>
							</fo:instream-foreign-object>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell display-align="center">
						<fo:block>
							<xsl:apply-templates select="@unformattedLabel"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template match="list[@style='rad']/*">
		<fo:table>
			<fo:table-column column-width="6mm"/>
			<fo:table-column/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell display-align="center">
						<fo:block text-align="center">
							<fo:instream-foreign-object content-height="5mm" content-width="5mm">
								<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 100 100">
									<circle r="48" cx="50" cy="50" stroke="black" fill="none" stroke-width="3"/>
									<xsl:if test=".='on' ">
										<circle r="40" cx="50" cy="50" stroke="none" fill="tomato"/>
									</xsl:if>
								</svg>
							</fo:instream-foreign-object>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell display-align="center">
						<fo:block>
							<xsl:apply-templates select="@unformattedLabel"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
</xsl:stylesheet>
