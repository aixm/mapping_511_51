<?xml version="1.0" encoding="UTF-8"?>
<!--====================================================================-->
<!--AIXM 5.1.1-->
<!--www.aixm.aero-->
<!--Released:  June 2015-->
<!--Author: Andrei Ghencea (Trainee EUROCONTROL)-->
<!--====================================================================-->
<!--
		Copyright (c) 2015, EUROCONTROL
		=====================================
		All rights reserved.
		Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
			* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
			* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
			* Neither the names of EUROCONTROL or FAA nor the names of their contributors may be used to endorse or promote products derived from this specification without specific prior written permission.

		THIS SPECIFICATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
		==========================================
		Editorial note: this license is an instance of the BSD license template as
		provided by the Open Source Initiative:
		http://www.opensource.org/licenses/bsd-license.php
		==========================================
		Technical note:
			* The scripts have been tested using Saxon Home Edition 9.6.0.5. The transition from Xalan to Saxon was a prerequisite for using a new function implemented with XSLT 2.0 (i.e fn:matches)
			needed for the implementation of the change proposals. For more details and download links please the following link: http://saxon.sourceforge.net/ .
			* When the script is run using a Java extension the following warning will be prompted: The child axis starting at an attribute node will never select anything.
			This warning is a bug from Saxon which doesn't affect the output.
		==========================================
	-->
<!-- Component: XSLT scripts: backward mapping (AIXM 5.1.1 to AIXM 5.1) -->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:aixm="http://www.aixm.aero/schema/5.1"
                xmlns:gml="http://www.opengis.net/gml/3.2">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!--identity transformation to copy the unchanged nodes-->
<xsl:template match="@*|node()">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
</xsl:template>

	<!-- script implementing change proposal AIXM-139 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-139 )-->
<xsl:template match="aixm:RulesProcedures//aixm:title[text()='HOLDING_APPROACH_DEPARTURE_PROCEDURES']">
	<xsl:copy>
		<xsl:text>HOLDING_ APPROACH_DEPARTURE_PROCEDURES</xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="aixm:AircraftStand//aixm:visualDockingSystem[text()='AGNIS']">
	<xsl:copy>
		<xsl:text>AGNIS </xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="aixm:AircraftStand//aixm:visualDockingSystem[text()='AGNIS_STOP']">
	<xsl:copy>
		<xsl:text>AGNIS_STOP </xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="aixm:VerticalStructurePart/aixm:constructionStatus[text()='IN_DEMOLITION']">
	<xsl:copy>
		<xsl:text>IN_DEMOLITION </xsl:text>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-143 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-143 )-->
<xsl:template match="aixm:TerminalSegmentPoint//aixm:role[text()='LTP']">
	<xsl:copy>
		<xsl:text>OTHER:LTP</xsl:text>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-146 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-146 )-->
<xsl:template match="aixm:StandardLevelColumnTimeSlice[aixm:unitOfMeasurement]">
	<xsl:choose>
		<xsl:when test="aixm:unitOfMeasurement[@nilReason[text()=('inapplicable','missing','template','unknown','withheld')]]">
			<xsl:copy>
				<xsl:apply-templates select="@gml:id"/>
				<xsl:apply-templates select="gml:validTime"/>
				<xsl:apply-templates select="aixm:interpretation"/>
				<xsl:apply-templates select="aixm:sequenceNumber"/>
				<xsl:apply-templates select="aixm:correctionNumber"/>
				<xsl:apply-templates select="aixm:featureLifetime"/>
				<xsl:apply-templates select="aixm:series"/>
				<xsl:apply-templates select="aixm:unitOfMeasurement"/>
				<xsl:apply-templates select="aixm:separation"/>
				<xsl:apply-templates select="aixm:level"/>
				<xsl:apply-templates select="aixm:levelTable"/>
				<xsl:element name="aixm:annotation">
					<xsl:element name="aixm:Note">
						<xsl:attribute name="gml:id" select="generate-id()"/>
						<xsl:element name="aixm:propertyName">unitOfMeasurement</xsl:element>
						<xsl:element name="aixm:purpose">REMARK</xsl:element>
						<xsl:element name="aixm:translatedNote">
							<xsl:element name="aixm:LinguisticNote">
								<xsl:attribute name="gml:id" select="concat(generate-id(),'10')"/>
								<xsl:element name="aixm:note">
									<xsl:value-of select="aixm:unitOfMeasurement/@nilReason"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<xsl:apply-templates select="aixm:annotation"/>
				<xsl:apply-templates select="aixm:extension"/>
			</xsl:copy>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="aixm:MarkingBuoyTimeSlice[aixm:designator]">
	<xsl:choose>
		<xsl:when test="aixm:designator[@nilReason[text()=('inapplicable','missing','template','unknown','withheld')]]">
			<xsl:copy>
				<xsl:apply-templates select="@gml:id"/>
				<xsl:apply-templates select="gml:validTime"/>
				<xsl:apply-templates select="aixm:interpretation"/>
				<xsl:apply-templates select="aixm:sequenceNumber"/>
				<xsl:apply-templates select="aixm:correctionNumber"/>
				<xsl:apply-templates select="aixm:featureLifetime"/>
				<xsl:apply-templates select="aixm:designator"/>
				<xsl:apply-templates select="aixm:type"/>
				<xsl:apply-templates select="aixm:colour"/>
				<xsl:apply-templates select="aixm:theSeaplaneLandingArea"/>
				<xsl:apply-templates select="aixm:location"/>
				<xsl:element name="aixm:annotation">
					<xsl:element name="aixm:Note">
						<xsl:attribute name="gml:id" select="generate-id()"/>
						<xsl:element name="aixm:propertyName">designator</xsl:element>
						<xsl:element name="aixm:purpose">REMARK</xsl:element>
						<xsl:element name="aixm:translatedNote">
							<xsl:element name="aixm:LinguisticNote">
								<xsl:attribute name="gml:id" select="concat(generate-id(),'10')"/>
								<xsl:element name="aixm:note">
									<xsl:value-of select="aixm:designator/@nilReason"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<xsl:apply-templates select="aixm:annotation"/>
				<xsl:apply-templates select="aixm:extension"/>
			</xsl:copy>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="aixm:FASDataBlock">
	<xsl:choose>
		<xsl:when test="aixm:routeIndicator[@nilReason] or aixm:referencePathIdentifier[@nilReason] or aixm:codeICAO[@nilReason]">
			<xsl:copy>
				<xsl:apply-templates select="@gml:id"/>
				<xsl:apply-templates select="aixm:horizontalAlarmLimit"/>
				<xsl:apply-templates select="aixm:verticalAlarmLimit"/>
				<xsl:apply-templates select="aixm:thresholdCourseWidth"/>
				<xsl:apply-templates select="aixm:lengthOffset"/>
				<xsl:apply-templates select="aixm:CRCRemainder"/>
				<xsl:apply-templates select="aixm:operationType"/>
				<xsl:apply-templates select="aixm:serviceProviderSBAS"/>
				<xsl:apply-templates select="aixm:approachPerformanceDesignator"/>
				<xsl:apply-templates select="aixm:routeIndicator"/>
				<xsl:apply-templates select="aixm:referencePathDataSelector"/>
				<xsl:apply-templates select="aixm:referencePathIdentifier"/>
				<xsl:apply-templates select="aixm:codeICAO"/>
				<xsl:apply-templates select="aixm:annotation"/>
				<xsl:if test="aixm:routeIndicator[@nilReason[text()=('inapplicable','missing','template','unknown','withheld')]]">
					<xsl:element name="aixm:annotation">
						<xsl:element name="aixm:Note">
							<xsl:attribute name="gml:id" select="concat('g',generate-id())"/>
							<xsl:element name="aixm:propertyName">routeIndicator</xsl:element>
							<xsl:element name="aixm:purpose">REMARK</xsl:element>
							<xsl:element name="aixm:translatedNote">
								<xsl:element name="aixm:LinguisticNote">
									<xsl:attribute name="gml:id" select="concat('g',generate-id(),'10')"/>
									<xsl:element name="aixm:note">
										<xsl:value-of select="aixm:routeIndicator/@nilReason"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="aixm:referencePathIdentifier[@nilReason[text()=('inapplicable','missing','template','unknown','withheld')]]">
					<xsl:element name="aixm:annotation">
						<xsl:element name="aixm:Note">
							<xsl:attribute name="gml:id" select="concat('a',generate-id())"/>
							<xsl:element name="aixm:propertyName">referencePathIdentifier</xsl:element>
							<xsl:element name="aixm:purpose">REMARK</xsl:element>
							<xsl:element name="aixm:translatedNote">
								<xsl:element name="aixm:LinguisticNote">
									<xsl:attribute name="gml:id" select="concat('a',generate-id(),'10')"/>
									<xsl:element name="aixm:note">
										<xsl:value-of select="aixm:referencePathIdentifier/@nilReason"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:if test="aixm:codeICAO[@nilReason[text()=('inapplicable','missing','template','unknown','withheld')]]">
					<xsl:element name="aixm:annotation">
						<xsl:element name="aixm:Note">
							<xsl:attribute name="gml:id" select="concat('d',generate-id())"/>
							<xsl:element name="aixm:propertyName">codeICAO</xsl:element>
							<xsl:element name="aixm:purpose">REMARK</xsl:element>
							<xsl:element name="aixm:translatedNote">
								<xsl:element name="aixm:LinguisticNote">
									<xsl:attribute name="gml:id" select="concat('d',generate-id(),'10')"/>
									<xsl:element name="aixm:note">
										<xsl:value-of select="aixm:codeICAO/@nilReason"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<xsl:apply-templates select="aixm:extension"/>
			</xsl:copy>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

	<!--script implementing change proposal AIXM-147 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-147 )-->
<xsl:template match="aixm:Navaid//aixm:signalPerformance[text()=('IIIA','IIIB','IIIC')]">
	<xsl:copy>
		<xsl:value-of select="concat('OTHER:',.)"/>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-150 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-150 )-->
<xsl:template match="aixm:AircraftCharacteristic//aixm:engine[text()='ELECTRIC']">
	<xsl:copy>
		<xsl:value-of select="concat('OTHER:',.)"/>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-158 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-158 )-->
<xsl:template match="aixm:StandardLevelTable//aixm:name[text()='VFR_RVSM']">
	<xsl:copy>
		<xsl:text>VFR_RVMS</xsl:text>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-164 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-164 )-->
	<!--fn:matches was used to identify the required pattern for Note.propertyName-->
<xsl:template match="aixm:Note[aixm:propertyName]">
	<xsl:choose>
		<xsl:when test="aixm:propertyName[matches(text(),'^[a-z][A-Za-z]*$')]">
			<xsl:apply-templates select="."/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy>
				<xsl:apply-templates select="@gml:id"/>
				<xsl:apply-templates select="aixm:purpose"/>
				<xsl:element name="aixm:translatedNote">
					<xsl:element name="aixm:LinguisticNote">
						<xsl:attribute name="gml:id" select="generate-id()"/>
						<xsl:element name="aixm:note">
							<xsl:text>value-of Note.propertyName: </xsl:text><xsl:value-of select="aixm:propertyName"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<xsl:apply-templates select="aixm:translatedNote"/>
			</xsl:copy>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
