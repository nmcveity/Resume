<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<h1><xsl:value-of select="/Resume/Contact[1]/FirstName/text()"/><xsl:text> </xsl:text><xsl:value-of select="/Resume/Contact[1]/Surname/text()"/></h1>
		<p class="document" id="target">
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="Contact">
		<h2>Contact</h2>
		<table class="border">
			<xsl:for-each select="Email">
				<tr><td class="strong border">email</td><td class="border"><xsl:value-of select="text()"/></td></tr>
			</xsl:for-each>
			<tr><td class="strong border">phone</td><td class="border"><em>Please email for phone number</em></td></tr>
			<tr><td class="strong border">postal</td><td class="border"><em>Please email for postal address</em></td></tr>
			<tr><td class="strong border">me</td><td class="border"><img><xsl:attribute name="src"><xsl:value-of select="Portrait/text()"/></xsl:attribute></img></td></tr>
		</table>
	</xsl:template>

	<xsl:template match="History">
		<h2>Professional History</h2>
		<table class="border">
			<xsl:for-each select="Job">
				<tr>
					<td class="strong border"><xsl:value-of select="Period/text()" /></td>
					<td class="border">
						<xsl:value-of select="Role/text()" /><xsl:text>, </xsl:text>
						<a><xsl:attribute name="href"><xsl:value-of select="EmployerURL/text()"/></xsl:attribute><xsl:value-of select="Employer/text()"/></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="border">
						<xsl:copy-of select="Description/*" />
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="Skills">
		<h2>Skills</h2>
		<table class="caption-bottom border">
			<xsl:for-each select="Skill[text()]">
				<tr>
					<td class="strong border"><xsl:value-of select="@name" /></td>
					<td class="border"><xsl:value-of select="text()" /></td>
				</tr>
			</xsl:for-each>
			<caption class="border">
				<xsl:text>Additional experience with: </xsl:text>
				<xsl:for-each select="Skill[not(text())]">
					<xsl:value-of select="@name" />
					<xsl:if test="not(position()=last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</caption>
		</table>
	</xsl:template>
	
	<xsl:template match="Education">
		<h2>Education</h2>
		<table class="border">
			<xsl:for-each select="Qualification">
				<tr>
					<td class="strong border"><xsl:value-of select="Period/text()" /></td>
					<td class="border">
						<xsl:value-of select="Name/text()" />
						<br/>
						<xsl:value-of select="Institution/text()" />
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="Interests">
		<h2>Interests</h2>
		<table class="border">
			<tr>
				<td>
					<ul>
						<xsl:for-each select="Interest[not(Photo)]">
							<li><xsl:value-of select="text()"/></li>
						</xsl:for-each>
					</ul>
				</td>
				<xsl:for-each select="Interest[Photo]">
					<td>
						<ul><li><xsl:value-of select="text()"/></li></ul>
						<xsl:for-each select="Photo">
							<img>
								<xsl:attribute name="src"><xsl:value-of select="text()"/></xsl:attribute>
							</img>
							<xsl:if test="not(position()=last())">
								<br/>
							</xsl:if>
						</xsl:for-each>
					</td>
				</xsl:for-each>
			</tr>
		</table>
			<!--
			<xsl:for-each select="Interest">
				<xsl:value-of select="text()" />
				<xsl:choose>
					<xsl:when test="position()=last()-1">
						<xsl:text> and </xsl:text>
					</xsl:when>
					<xsl:when test="position()=last()">
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			-->
	</xsl:template>

	<xsl:template match="References">
		<h2>References</h2>
		<table class="caption-bottom border">
			<tr>
				<xsl:for-each select="Reference">
					<td class="border">
						<span class="strong"><xsl:value-of select="Name/text()" /></span>
						<br/>
						<xsl:value-of select="Role/text()" /><xsl:text>, </xsl:text><xsl:value-of select="RoleCompany/text()" />
						<br/>
					</td>
				</xsl:for-each>
			</tr>
			<caption><em>(please email for referee contact details)</em></caption>
		</table>
	</xsl:template>
	
	<xsl:template match="Links">
		<h2>Links</h2>
		<table>
			<xsl:for-each select="Link">
				<tr><td>
					<a><xsl:attribute name="href"><xsl:value-of select="@href" /></xsl:attribute><xsl:value-of select="@text"/></a>
				</td><td>
					<xsl:value-of select="text()"/>
				</td></tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="Gallery">
		<h2>Gallery</h2>
		<center>
			<xsl:for-each select="Image">
				<img class="gallery">
					<xsl:attribute name="src"><xsl:value-of select="text()"/></xsl:attribute>
				</img>
			</xsl:for-each>
		</center>
	</xsl:template>

	<xsl:template match="text()" />

</xsl:stylesheet>