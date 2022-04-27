<?xml version="1.0" encoding="UTF-8"?>
<!--IV1023 Inlämningsuppgift 3, problem 2-->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:variable name="bok" select="document('books.xml')"/>
    <xsl:variable name="pub" select="document('publishers.xml')"/>
    <xsl:template match="/">
        <xsl:element name="Resultat">
            <xsl:for-each select="$bok//Translation[@Publisher and not(@Publisher=preceding::Translation/@Publisher)]">
                <xsl:sort select="@Publisher"/>

                <xsl:element name="Förlag">
                    <xsl:variable name="p" select="@Publisher"/>
                    <xsl:attribute name="Namn">
                        <xsl:value-of select="@Publisher"/>
                    </xsl:attribute>
                    <xsl:attribute name="Land">
                        <xsl:value-of select="$pub//Publisher[@Name=$p]//Country"/>
                    </xsl:attribute>

                    <xsl:for-each select="$bok//Book[.//Translation/@Publisher=$p]">
                        <xsl:element name="Bok">
                            <xsl:attribute name="Titel">
                                <xsl:value-of select="@Title"/>
                            </xsl:attribute>
                            <xsl:if test="@Genre">
                                <xsl:attribute name="Genre">
                                    <xsl:value-of select="@Genre"/>
                                </xsl:attribute>
                            </xsl:if>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>

            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:transform>