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
		Technical note: the scripts have been tested using Saxon Home Edition 9.6.0.5. The transition from Xalan to Saxon was a prerequisite for using a new function implemented with XSLT 2.0 (i.e fn:matches)
		needed for the implementation of the change proposals. For more details and download links please use the following link: http://saxon.sourceforge.net/ .
		==========================================
	-->
<!-- Component: XSLT scripts: forward mapping (AIXM 5.1 to AIXM 5.1.1) -->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:src_aixm="http://www.aixm.aero/schema/5.1"
                xmlns:aixm="http://www.aixm.aero/schema/5.1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<!--identity transformation to copy the unchanged nodes-->
<xsl:template match="@*|node()">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
</xsl:template>

	<!-- script implementing change proposal AIXM-139 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-139 )-->
<xsl:template match="src_aixm:RulesProcedures//src_aixm:title[text()='HOLDING_ APPROACH_DEPARTURE_PROCEDURES']">
	<xsl:copy>
		<xsl:text>HOLDING_APPROACH_DEPARTURE_PROCEDURES</xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="src_aixm:AircraftStand//src_aixm:visualDockingSystem[text()='AGNIS ']">
	<xsl:copy>
		<xsl:text>AGNIS</xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="src_aixm:AircraftStand//src_aixm:visualDockingSystem[text()='AGNIS_STOP ']">
	<xsl:copy>
		<xsl:text>AGNIS_STOP</xsl:text>
	</xsl:copy>
</xsl:template>

<xsl:template match="src_aixm:VerticalStructurePart/src_aixm:constructionStatus[text()='IN_DEMOLITION ']">
	<xsl:copy>
		<xsl:text>IN_DEMOLITION</xsl:text>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-143 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-143 )-->
<xsl:template match="src_aixm:TerminalSegmentPoint//src_aixm:role[text()='OTHER:LTP']">
	<xsl:copy>
		<xsl:text>LTP</xsl:text>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-147 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-147 )-->
<xsl:template match="src_aixm:Navaid//src_aixm:signalPerformance[text()=('OTHER:IIIA','OTHER:IIIB','OTHER:IIIC')]">
	<xsl:copy>
		<xsl:value-of select="substring-after(.,'OTHER:')"/>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-150 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-150 )-->
<xsl:template match="src_aixm:AircraftCharacteristic//src_aixm:engine[text()='OTHER:ELECTRIC']">
	<xsl:copy>
		<xsl:value-of select="substring-after(.,'OTHER:')"/>
	</xsl:copy>
</xsl:template>

	<!--script implementing change proposal AIXM-158 (for more information please use the following link: https://aixmccb.atlassian.net/browse/AIXM-158 )-->
<xsl:template match="src_aixm:StandardLevelTable//src_aixm:name[text()='VFR_RVMS']">
	<xsl:copy>
		<xsl:text>VFR_RVSM</xsl:text>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
