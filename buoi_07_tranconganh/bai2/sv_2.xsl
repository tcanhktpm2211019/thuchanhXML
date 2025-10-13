<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Xuất ra văn bản JSON -->
    <xsl:output method="text" encoding="UTF-8" indent="no" />

    <xsl:template match="/"> { &#10; "students": [ <xsl:for-each select="school/student"> &#10; {
        "id": "<xsl:value-of select='id' />", "name": "<xsl:value-of select='name' />", "date": "<xsl:value-of
                select='date' />" }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        &#10; ] &#10;} </xsl:template>

</xsl:stylesheet>