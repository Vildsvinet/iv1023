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

            <xsl:apply-templates
                    select="$books//Book[not(@OriginalLanguage=preceding::Book/@OriginalLanguage)]/@OriginalLanguage">
                <xsl:sort select="."/>
            </xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="@OriginalLanguage">
        <xsl:variable name="ol" select="."/>
        <xsl:variable name="bs" select="$books//Book[@OriginalLanguage=$ol]"/>
        <xsl:variable name="rs" select="count($bs)"/>
        <xsl:for-each select="$bs">
            <xsl:sort select="@Title"/>
            <tr>
                <xsl:if test="position() = 1">
                    <td rowspan="{$rs}">
                        <xsl:value-of select="$ol"/>
                    </td>
                </xsl:if>
                <td>
                    <xsl:value-of select="@Title"/>
                </td>
                <td>
                    <xsl:value-of select="@Genre"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

</xsl:transform>