<?xml version="1.0" encoding="UTF-8"?>
<!--slack-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head><title>Produktionsbolag</title></head>
            <body>
                <h1>Bolag</h1>
                <p>
                    <xsl:apply-templates select="document('filmer.xml')//Produktionsbolag" />
                </p>

                <hr/>
                <h1>Filmer</h1>
                <table border="1">
                    <!-- <caption><xsl:value-of select="@Titel"/></caption> -->
                    <tr>
                        <th>Filmtitel</th>
                        <th>År</th>
                        <th>Regissör namn</th>
                        <th>Regissör land</th>
                        <th>#skådespelare</th>
                    </tr>
                    <xsl:apply-templates select="document('filmer.xml')//Film" />
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="Produktionsbolag">
        <h2><xsl:value-of select="." /></h2>
        <table border = "1">
            <tr>
                <th>Filmtitel</th>
                <th>År</th>
                <th>Regissör namn</th>
                <th>Regissör land</th>
                <th>#skådespelare</th>
            </tr>
            <xsl:apply-templates select=".."/>
        </table>
    </xsl:template>


    <xsl:template match="Film">
        <tr>
            <td><xsl:value-of select="@Titel"/></td>
            <td><xsl:value-of select="@År"/></td>
            <xsl:apply-templates select="Regissör"/>
            <td><xsl:value-of select="Produktionsbolag"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="Regissör">
        <td><xsl:value-of select="@Namn"/></td>
        <td><xsl:value-of select="@Land"/></td>
    </xsl:template>



    <!-- <xsl:template match="Skådis"> -->
    <!-- <td><xsl:value-of select="@Namn"/></td> -->
    <!-- </xsl:template> -->
</xsl:transform>