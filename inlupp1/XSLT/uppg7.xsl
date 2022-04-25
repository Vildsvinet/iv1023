<?xml version="1.0" encoding="UTF-8"?>
<!--IV1023 Inlämningsuppgift 1, problem 7-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="doc" select="document('filmer.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Produktionsbolag</title>
            </head>
            <body>
                <h1>Produktionsbolag</h1>
                <xsl:for-each select="$doc//Produktionsbolag[not(. = preceding::Produktionsbolag/.)]">
                    <xsl:sort select="." order="ascending"/>
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <!--Template för vad som ska renderas för varje bolag - en rubrik och en tabell-->
    <xsl:template match="Produktionsbolag">
        <xsl:variable name="b" select="."/>
        <p>
        <h2><xsl:value-of select="." /></h2>
        <table border = "2">
            <caption>Filmer som <xsl:value-of select="." /> producerat.</caption>
            <tr>
                <th>Filmtitel</th>
                <th>År</th>
                <th>Regissör namn</th>
                <th>Regissör land</th>
                <th>#Skådespelare</th>
            </tr>
            <xsl:for-each select="$doc//Film[Produktionsbolag/.=$b]">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </table>
        </p>
    </xsl:template>

    <!--Template för vad som ska renderas för varje film - en rad i tabellen-->
    <xsl:template match="Film">
        <tr>
            <td><xsl:value-of select="@Titel"/></td>
            <td><xsl:value-of select="@År"/></td>
            <xsl:apply-templates select="Regissör"/>
            <td><xsl:value-of select="count(Skådis)"/></td>
        </tr>
    </xsl:template>

    <!--Template för vad som ska renderas för varje regissör - två celler i tabellraden-->
    <xsl:template match="Regissör">
        <td><xsl:value-of select="@Namn"/></td>
        <td><xsl:value-of select="@Land"/></td>
    </xsl:template>

</xsl:transform>