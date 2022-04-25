<?xml version="1.0" encoding="UTF-8"?>
<!--IV1023 Inlämningsuppgift 1, problem 8-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:variable name="doc" select="document('filmer.xml')"/>
    <xsl:template match="/">
        <xsl:element name="Filmer">

            <xsl:comment>Loopa genom filmerna och rendera sorterade på år</xsl:comment>
            <xsl:for-each select="$doc//Film">
                <xsl:sort select="@År" order="ascending"/>
                <xsl:variable name="f" select="."/>
                <xsl:element name="Film" >
                    <xsl:attribute name="Titel">
                        <xsl:value-of select="@Titel"/>
                    </xsl:attribute>
                    <xsl:attribute name="År">
                        <xsl:value-of select="@År"/>
                    </xsl:attribute>
                    <xsl:attribute name="Bolag">
                        <xsl:value-of select="$f/Produktionsbolag/."/>
                    </xsl:attribute>
                    <xsl:attribute name="Regissör">
                        <xsl:value-of select="$f/Regissör/@Namn"/>
                    </xsl:attribute>

                    <xsl:comment>Loopa genom skådisarna för film och rendera</xsl:comment>
                    <xsl:for-each select="$f/Skådis">
                        <xsl:element name="Skådis">
                            <xsl:value-of select="@Namn"/>
                        </xsl:element>
                    </xsl:for-each>

                </xsl:element>
            </xsl:for-each>

        </xsl:element>
    </xsl:template>
</xsl:transform>