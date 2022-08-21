<?xml version="1.0" encoding= "UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html"/>
    <xsl:variable name="partier" select="document('partier.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Partier</title>
            </head>
            <body>
                <h1>Partier</h1>
                <table border="2">
                    <tr>
                        <th>Parti</th>
                        <th>Antal ledamöter</th>
                        <th>Antal ordförandeskap</th>
                        <th>Antal utskott med representation</th>
                    </tr>
                    <xsl:apply-templates select="$partier//Parti"/>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="Parti">
        <tr>
            <td> <xsl:value-of select="./@namn"/></td>
            <td> <xsl:value-of select="count(./Ledamot)"/> </td>
            <td> <xsl:value-of select="count(./Ledamot[Uppdrag/@roll='ordförande'])"/> </td>
            <td> <xsl:value-of select="count(Ledamot/Uppdrag/@utskott[not(. =
preceding::Uppdrag[../../@namn = current()/@namn]/@utskott)])"/> </td>
        </tr>
    </xsl:template>

</xsl:transform>