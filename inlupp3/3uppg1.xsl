<?xml version="1.0" encoding="UTF-8"?>
<!--IV1023 Inlämningsuppgift 3, problem 1-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    <xsl:variable name="bok" select="document('books.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Books by Genre</title>
            </head>
            <body>
                <xsl:for-each select="$bok//Book[not(@Genre=preceding::Book/@Genre)]">
                    <xsl:sort select="@Genre" order="ascending"/>
                    <xsl:variable name="g" select="@Genre"/>
                    <h1>
                        <xsl:value-of select="$g"/>
                    </h1>
                    <ul>
                        <xsl:for-each select="$bok//Book[@Genre=$g]">
                            <li>
                                <xsl:value-of select="@Title"/>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:transform>