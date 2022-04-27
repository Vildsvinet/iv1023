<?xml version="1.0" encoding="UTF-8"?>
<!--IV1023 Inlämningsuppgift 3, problem 3-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    <xsl:variable name="books" select="document('books.xml')"/>

    <xsl:template match="/">
        <table border="2">
            <tr>
                <th>Språk</th>
                <th>Titel</th>
                <th>Genre</th>
            </tr>
            <xsl:for-each select="$books//Book[not(@OriginalLanguage=preceding::Book/@OriginalLanguage)]">
                <xsl:sort select="@OriginalLanguage"/>
                <xsl:apply-templates select="@OriginalLanguage"/>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="@OriginalLanguage">
        <xsl:variable name="ol" select="."/>
        <xsl:variable name="rs" select="count($books//Book[@OriginalLanguage=$ol])"/>
        <tr>
            <td rowspan="{$rs+1}">
                <xsl:value-of select="$ol"/>
            </td>
            <xsl:for-each select="$books//Book[@OriginalLanguage=$ol]">
                <xsl:sort select="@Title"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </tr>
    </xsl:template>

    <xsl:template match="Book">
        <tr>
            <td>
                <xsl:value-of select="@Title"/>
            </td>
            <td>
                <xsl:value-of select="@Genre"/>
            </td>
        </tr>
    </xsl:template>

</xsl:transform>