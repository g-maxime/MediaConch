<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="https://mediaarea.net/mediaconch" xmlns:ma="https://mediaarea.net/mediaarea" xmlns:mi="https://mediaarea.net/mediainfo" xmlns:mt="https://mediaarea.net/mediatrace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:str="http://exslt.org/strings" version="1.0" extension-element-prefixes="xsi ma mi mt str">
    <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
    <xsl:template match="mt:MediaTrace/mt:block">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:variable name="minimum_verbosity_for_pass">4</xsl:variable>
    <xsl:template match="ma:MediaArea">
        <MediaConch>
            <xsl:attribute name="version">
                <xsl:text>0.1</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="ma:media">
                <media>
                    <xsl:attribute name="ref">
                        <xsl:value-of select="./@ref"/>
                    </xsl:attribute>
                    <implementationChecks>
                        <name>MediaConch EBML Implementation Checker</name>
                        <xsl:choose>
                            <xsl:when test="//mi:Format='Matroska' or //mi:Format='WebM'">
                                <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                    <check icid="IS_EBML" version="1">
                                        <context field="mi:Format">
                                            <xsl:attribute name="value">
                                                <xsl:value-of select="//mi:Format"/>
                                            </xsl:attribute>
                                        </context>
                                        <test outcome="pass"/>
                                    </check>
                                </xsl:if>
                                <xsl:variable name="EBMLVersion">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='646']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='646']"/>
                                        </xsl:when>
                                        <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="EBMLReadVersion">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='759']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='759']"/>
                                        </xsl:when>
                                        <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="EBMLMaxIDLength">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='754']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='754']"/>
                                        </xsl:when>
                                        <xsl:otherwise>4</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="EBMLMaxSizeLength">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='755']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='755']"/>
                                        </xsl:when>
                                        <xsl:otherwise>8</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="DocType">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='642']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='642']"/>
                                        </xsl:when>
                                        <xsl:otherwise>matroska</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="DocTypeVersion">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='647']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='647']"/>
                                        </xsl:when>
                                        <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="DocTypeReadVersion">
                                    <xsl:choose>
                                        <xsl:when test="//mt:data[../mt:block/mt:data='645']">
                                            <xsl:value-of select="//mt:data[../mt:block/mt:data='645']"/>
                                        </xsl:when>
                                        <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="GlobalElements">
                                    <xsl:for-each select="document($schema)//element[@global='1']">
                                        <xsl:value-of select="@id"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:for-each>
                                </xsl:variable>
                                <!-- EBML-ELEM-START -->
                                <xsl:call-template name="x_equals_y">
                                    <xsl:with-param name="icid">EBML-ELEM-START</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:data[@offset='0']"/>
                                    <xsl:with-param name="x_name">First Element ID</xsl:with-param>
                                    <xsl:with-param name="y">172351395</xsl:with-param>
                                    <xsl:with-param name="y_name">Expected First Element ID</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-ELEM-START -->
                                <!-- EBML-VER-COH -->
                                <xsl:call-template name="x_is_less_than_or_equal_to_y">
                                    <xsl:with-param name="icid">EBML-VER-COH</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="$EBMLReadVersion"/>
                                    <xsl:with-param name="x_name">EBMLReadVersion</xsl:with-param>
                                    <xsl:with-param name="y" select="$EBMLVersion"/>
                                    <xsl:with-param name="y_name">EBMLVersion</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-VER-COH -->
                                <!-- EBML-DOCVER-COH -->
                                <xsl:call-template name="x_is_less_than_or_equal_to_y">
                                    <xsl:with-param name="icid">EBML-DOCVER-COH</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="$DocTypeReadVersion"/>
                                    <xsl:with-param name="x_name">DocTypeReadVersion</xsl:with-param>
                                    <xsl:with-param name="y" select="$DocTypeVersion"/>
                                    <xsl:with-param name="y_name">DocTypeVersion</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-DOCVER-COH -->
                                <!-- EBML-ELEMENT-VALID-PARENT -->
                                <xsl:call-template name="x_has_valid_parent">
                                    <xsl:with-param name="icid">EBML-ELEMENT-VALID-PARENT</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:MediaTrace/mt:block//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']]"/>
                                    <xsl:with-param name="x_name">EBML Element</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-ELEMENT-VALID-PARENT -->
                                <!-- EBML-ELEMENT-NONMULTIPLES -->
                                <xsl:call-template name="x_does_not_repeat_in_parent">
                                    <xsl:with-param name="icid">EBML-ELEMENT-NONMULTIPLES</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:MediaTrace//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']]"/>
                                    <xsl:with-param name="x_name">EBML Element</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-ELEMENT-NONMULTIPLES -->
                                <!-- EBML-ELEMENT-CONTAINS-MANDATES -->
                                <xsl:call-template name="x_contains_mandates">
                                    <xsl:with-param name="icid">EBML-ELEMENT-CONTAINS-MANDATES</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:MediaTrace//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']][not(mt:data)]"/>
                                    <xsl:with-param name="x_name">EBML Element</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-ELEMENT-CONTAINS-MANDATES -->
                                <!-- EBML-VALID-MAXID -->
                                <xsl:call-template name="x_is_less_than_or_equal_to_y">
                                    <xsl:with-param name="icid">EBML-VALID-MAXID</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x">4</xsl:with-param>
                                    <xsl:with-param name="x_name">Minimum valid EBMLMaxIDLength</xsl:with-param>
                                    <xsl:with-param name="y" select="$EBMLMaxIDLength"/>
                                    <xsl:with-param name="y_name">EBMLMaxIDLength</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-VALID-MAXID -->
                                <!-- EBML-VALID-MAXSIZE -->
                                <xsl:call-template name="x_is_less_than_or_equal_to_y">
                                    <xsl:with-param name="icid">EBML-VALID-MAXSIZE</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x">0</xsl:with-param>
                                    <xsl:with-param name="x_name">Minimum valid EBMLMaxSizeLength</xsl:with-param>
                                    <xsl:with-param name="y" select="$EBMLMaxSizeLength"/>
                                    <xsl:with-param name="y_name">EBMLMaxSizeLength</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-VALID-MAXSIZE -->
                                <!-- ELEMENTS-WITHIN-MAXIDLENGTH -->
                                <xsl:variable name="context">
                                    <context field="EBMLMaxIDLength">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="$EBMLMaxIDLength"/>
                                        </xsl:attribute>
                                    </context>
                                </xsl:variable>
                                <xsl:variable name="tests">
                                    <xsl:choose>
                                        <xsl:when test="//mt:block[@name='Header']/mt:data[@name='Size'][@offset &gt; (../../mt:block/@offset + $EBMLMaxIDLength)]">
                                            <xsl:for-each select="//mt:block[@name='Header']/mt:data[@name='Size'][@offset &gt; (../../mt:block/@offset + $EBMLMaxIDLength)]">
                                                <test>
                                                    <xsl:attribute name="outcome">fail</xsl:attribute>
                                                    <xsl:attribute name="reason">
                                                        <xsl:text>Element ID Length greater than EBMLMaxIDLength.</xsl:text>
                                                    </xsl:attribute>
                                                    <value>
                                                        <xsl:attribute name="offset">
                                                            <xsl:value-of select="@offset"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="name">
                                                            <xsl:value-of select="../../@name"/>
                                                            <xsl:text>:Element_ID_Length</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="@offset - ../../mt:block/@offset"/>
                                                    </value>
                                                </test>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                                <test>
                                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                                </test>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:if test="$tests != ''">
                                    <xsl:call-template name="check">
                                        <xsl:with-param name="icid">ELEMENTS-WITHIN-MAXIDLENGTH</xsl:with-param>
                                        <xsl:with-param name="version">1</xsl:with-param>
                                        <xsl:with-param name="context" select="$context"/>
                                        <xsl:with-param name="test" select="$tests"/>
                                    </xsl:call-template>
                                </xsl:if>
                                <!-- /ELEMENTS-WITHIN-MAXIDLENGTH -->
                                <!-- ELEMENTS-WITHIN-MAXSIZELENGTH -->
                                <xsl:variable name="context2">
                                    <context field="EBMLMaxSizeLength">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="$EBMLMaxSizeLength"/>
                                        </xsl:attribute>
                                    </context>
                                </xsl:variable>
                                <xsl:variable name="testsA">
                                    <xsl:choose>
                                        <xsl:when test="//mt:block/mt:data[@name='Size'][(../../mt:data/@offset - @offset) &gt; $EBMLMaxSizeLength]">
                                            <xsl:for-each select="//mt:block/mt:data[@name='Size'][(../../mt:data/@offset - @offset) &gt; $EBMLMaxSizeLength]">
                                                <test>
                                                    <xsl:attribute name="outcome">fail</xsl:attribute>
                                                    <xsl:attribute name="reason">
                                                        <xsl:text>An Element at has an Element Size Length greater than EBMLMaxSizeLength.</xsl:text>
                                                    </xsl:attribute>
                                                    <value>
                                                        <xsl:attribute name="offset">
                                                            <xsl:value-of select="@offset"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="name">
                                                            <xsl:value-of select="../../@name"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="../../mt:data/@offset - @offset"/>
                                                    </value>
                                                </test>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                                <test>
                                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                                    <value>
                                                        <xsl:attribute name="name">
                                                            <xsl:text>EBMLMaxSizeLength</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$EBMLMaxSizeLength"/>
                                                    </value>
                                                </test>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:if test="$testsA != ''">
                                    <xsl:call-template name="check">
                                        <xsl:with-param name="icid">ELEMENTS-WITHIN-MAXSIZELENGTH</xsl:with-param>
                                        <xsl:with-param name="version">1</xsl:with-param>
                                        <xsl:with-param name="context" select="$context2"/>
                                        <xsl:with-param name="test" select="$testsA"/>
                                    </xsl:call-template>
                                </xsl:if>
                                <!-- /ELEMENTS-WITHIN-MAXSIZELENGTH -->
                                <!-- EBML-CRC-FIRST -->
                                <xsl:call-template name="x_is_first_child">
                                    <xsl:with-param name="icid">EBML-CRC-FIRST</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']='63']"/>
                                    <xsl:with-param name="x_name">EBML Element</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-CRC-FIRST -->
                                <!-- EBML-CRC-VALID -->
                                <xsl:call-template name="child_data_info_is_ok">
                                    <xsl:with-param name="icid">EBML-CRC-VALID</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']='63']"/>
                                    <xsl:with-param name="x_name">EBML Element</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-CRC-VALID -->
                                <!-- EBML-CRC-LEGNTH -->
                                <xsl:call-template name="x_value_is_y_bytes">
                                    <xsl:with-param name="icid">EBML-CRC-LENGTH</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']='63']"/>
                                    <xsl:with-param name="y">4</xsl:with-param>
                                </xsl:call-template>
                                <!-- /EBML-CRC-LENGTH -->
                                <!-- MKV-SEEK-RESOLVE -->
                                <xsl:call-template name="seek_element_resolves">
                                    <xsl:with-param name="icid">MKV-SEEK-RESOLVE</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="seek_element" select="//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']='3515']"/>
                                </xsl:call-template>
                                <!-- /MKV-SEEK-RESOLVE -->
                                <!-- MKV-SEGMENT-UID-LEGNTH -->
                                <xsl:call-template name="x_value_is_y_bytes">
                                    <xsl:with-param name="icid">MKV-SEGMENT-UID-LEGNTH</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <!-- SegmentUID is 13220, PrevUID is 1,882,403, NextUID is 2,013,475, Segment Family is 1,092 -->
                                    <xsl:with-param name="x" select="//mt:block[mt:block[1][@name='Header'][mt:data[@name='Name']='13220' or mt:data[@name='Name']='1882403' or mt:data[@name='Name']='2013475' or mt:data[@name='Name']='1092']]"/>
                                    <xsl:with-param name="y">16</xsl:with-param>
                                </xsl:call-template>
                                <!-- /MKV-SEGMENT-UID-LEGNTH -->
                                <!-- MKV-VALID-TRACKTYPE-VALUE -->
                                <xsl:call-template name="x_is_in_list">
                                    <xsl:with-param name="icid">MKV-VALID-TRACKTYPE-VALUE</xsl:with-param>
                                    <xsl:with-param name="version">1</xsl:with-param>
                                    <xsl:with-param name="x" select="//mt:block[mt:block[1][@name='Header']/mt:data[@name='Name']='3']"/>
                                    <xsl:with-param name="x_name">Track Type</xsl:with-param>
                                    <xsl:with-param name="list">1 2 3 16 17 18 32</xsl:with-param>
                                </xsl:call-template>
                                <!-- /MKV-VALID-TRACKTYPE-VALUE -->
                                <xsl:for-each select="//mt:block[@name='SimpleTag'][mt:block[@name='TagName'][@info='TOTAL_PARTS']]/mt:block[@name='TagString']/mt:data">
                                    <implementation>
                                        <xsl:attribute name="name">TOTAL_PARTS is number</xsl:attribute>
                                        <xsl:call-template name="is_number">
                                            <xsl:with-param name="xpath" select="."/>
                                            <xsl:with-param name="field">TOTAL_PARTS</xsl:with-param>
                                        </xsl:call-template>
                                    </implementation>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <check icid="IS_EBML" version="1">
                                    <context field="mi:Format">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="//mi:Format"/>
                                        </xsl:attribute>
                                    </context>
                                    <test outcome="n/a">
                                        <value name="reason">
                                            <xsl:text>Not recognized as an EBML format</xsl:text>
                                        </value>
                                    </test>
                                </check>
                            </xsl:otherwise>
                        </xsl:choose>
                    </implementationChecks>
                </media>
            </xsl:for-each>
        </MediaConch>
    </xsl:template>
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:variable name="digit" select="'0123456789'"/>
    <xsl:variable name="period" select="'.'"/>
    <xsl:variable name="comma" select="','"/>
    <xsl:variable name="decimal" select="concat($digit, $period, $comma)"/>
    <xsl:template name="is_true">
        <xsl:param name="xpath"/>
        <xsl:param name="value"/>
        <xsl:param name="field"/>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="expected">
                <xsl:value-of select="$value"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$xpath">
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">pass</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">fail</xsl:attribute>
                        <xsl:attribute name="reason">is not true</xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="is_equal">
        <xsl:param name="xpath"/>
        <xsl:param name="value"/>
        <xsl:param name="field"/>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="expected">
                <xsl:value-of select="$value"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$xpath = $value">
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">pass</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">fail</xsl:attribute>
                        <xsl:attribute name="reason">is not equal</xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="is_not_equal">
        <xsl:param name="xpath"/>
        <xsl:param name="value"/>
        <xsl:param name="field"/>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="expected">
                <xsl:value-of select="$value"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$xpath != $value">
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">pass</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">fail</xsl:attribute>
                        <xsl:attribute name="reason">is equal</xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="x_is_less_than_y">
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="y"/>
        <xsl:param name="y_name"/>
        <xsl:element name="test">
            <xsl:choose>
                <xsl:when test="$x &lt; $y">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">
                        <xsl:value-of select="$x_name"/>
                        <xsl:text> is not less than </xsl:text>
                        <xsl:value-of select="$y_name"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$x_name"/>
                </xsl:attribute>
                <xsl:value-of select="$x"/>
            </value>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$y_name"/>
                </xsl:attribute>
                <xsl:value-of select="$y"/>
            </value>
        </xsl:element>
    </xsl:template>
    <xsl:template name="x_has_valid_parent">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:variable name="GlobalElements">
            <xsl:for-each select="document($schema)//element[@global='1']">
                <xsl:value-of select="@id"/>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="ElementListWIthParents">
            <xsl:for-each select="document($schema)//element">
                <xsl:value-of select="@id"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="../@id"/>
                <xsl:text>.</xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="parentVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="../mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="allowedParentVINT">
                    <xsl:value-of select="substring-before(substring-after($ElementListWIthParents,concat($xVINT,',')),'.')"/>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="$x_name"/>
                        </xsl:attribute>
                        <xsl:value-of select="$xVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="name">
                            <xsl:text>Allowed EBML Parent Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$allowedParentVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="../@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Parent Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$parentVINT"/>
                    </value>
                </xsl:variable>
                <xsl:if test="not(contains($GlobalElements,$xVINT))">
                    <xsl:choose>
                        <xsl:when test="$allowedParentVINT=$parentVINT">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:value-of select="$parentVINT"/>
                                    <xsl:text> is not a valid parent element of </xsl:text>
                                    <xsl:value-of select="$xVINT"/>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="x_does_not_repeat_in_parent">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:variable name="NonRepeatingElements">
            <xsl:for-each select="document($schema)//element[@maxOccurs!='unbounded' or not(@maxOccurs)]"><!-- needs a correction is maxOccurs may be something other than 'unbounded' -->
                <xsl:value-of select="@id"/>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="parentVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="../mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="siblingsVINT">
                    <xsl:for-each select="../mt:block[@name!='Header']">
                        <xsl:text>0x</xsl:text>
                        <xsl:call-template name="HexToVINT">
                            <xsl:with-param name="hex">
                                <xsl:call-template name="DecToHex">
                                    <xsl:with-param name="dec">
                                        <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>Non-Repeating Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$xVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="../mt:block[@name='Header']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>Parent Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$parentVINT"/>
                    </value>
                </xsl:variable>
                <xsl:if test="contains($NonRepeatingElements,$xVINT)">
                    <xsl:choose>
                        <xsl:when test="not(contains(substring-after($siblingsVINT,$xVINT),$xVINT))">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:value-of select="$xVINT"/>
                                    <xsl:text> occurs more times than allowed within </xsl:text>
                                    <xsl:value-of select="$parentVINT"/>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="x_contains_mandates">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:variable name="ElementsWithMandatoryChildrenWithoutDefaults">
            <xsl:for-each select="document($schema)//element[element[not(@default)][@minOccurs>0]]">
                <xsl:value-of select="@id"/>
                <xsl:text>:</xsl:text>
                <xsl:for-each select="element[not(@default)][@minOccurs>0]">
                    <xsl:value-of select="@id"/>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
                <xsl:text>;</xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="ElementsThatContainMandates">
            <xsl:for-each select="document($schema)//element[element[not(@default)][@minOccurs>0]]">
                <xsl:value-of select="@id"/>
                <xsl:text> </xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="CurrentElementChildren">
                    <xsl:for-each select="mt:block/mt:block[@name='Header']/mt:data[@name='Name']">
                        <xsl:text>0x</xsl:text>
                        <xsl:call-template name="HexToVINT">
                            <xsl:with-param name="hex">
                                <xsl:call-template name="DecToHex">
                                    <xsl:with-param name="dec">
                                        <xsl:value-of select="."/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="mandatoryChildrenVINT">
                    <xsl:value-of select="substring-before(substring-after($ElementsWithMandatoryChildrenWithoutDefaults,concat($xVINT,':')),';')"/>
                </xsl:variable>
                <xsl:variable name="offset">
                    <xsl:value-of select="@offset"/>
                </xsl:variable>
                <xsl:if test="contains($ElementsThatContainMandates,$xVINT)">
                    <xsl:for-each select="str:tokenize($mandatoryChildrenVINT)">
                        <xsl:variable name="values">
                            <value>
                                <xsl:attribute name="name">
                                    <xsl:text>Mandatory Element with No Default</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </value>
                            <value>
                                <xsl:attribute name="offset">
                                    <xsl:value-of select="$offset"/>
                                </xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:text>Master Element</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="$xVINT"/>
                            </value>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="contains($CurrentElementChildren,.)">
                                <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                    <test>
                                        <xsl:attribute name="outcome">pass</xsl:attribute>
                                        <xsl:copy-of select="$values"/>
                                    </test>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <test>
                                    <xsl:attribute name="outcome">fail</xsl:attribute>
                                    <xsl:attribute name="reason">
                                        <xsl:value-of select="."/>
                                        <xsl:text> MUST be a child element of </xsl:text>
                                        <xsl:value-of select="$xVINT"/>
                                    </xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="x_is_greater_than_y">
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="y"/>
        <xsl:param name="y_name"/>
        <xsl:element name="test">
            <xsl:choose>
                <xsl:when test="$x &gt; $y">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">
                        <xsl:value-of select="$x_name"/>
                        <xsl:text> is not greater than </xsl:text>
                        <xsl:value-of select="$y_name"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$x_name"/>
                </xsl:attribute>
                <xsl:value-of select="$x"/>
            </value>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$y_name"/>
                </xsl:attribute>
                <xsl:value-of select="$y"/>
            </value>
        </xsl:element>
    </xsl:template>
    <xsl:template name="x_is_less_than_or_equal_to_y">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="y"/>
        <xsl:param name="y_name"/>
        <xsl:variable name="values">
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$y_name"/>
                </xsl:attribute>
                <xsl:value-of select="$y"/>
            </value>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$x_name"/>
                </xsl:attribute>
                <xsl:value-of select="$x"/>
            </value>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$x &lt;= $y">
                <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                    <xsl:call-template name="check">
                        <xsl:with-param name="icid" select="$icid"/>
                        <xsl:with-param name="version" select="$version"/>
                        <xsl:with-param name="test">
                            <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="check">
                    <xsl:with-param name="icid" select="$icid"/>
                    <xsl:with-param name="version" select="$version"/>
                    <xsl:with-param name="test">
                        <test>
                            <xsl:attribute name="outcome">fail</xsl:attribute>
                            <xsl:attribute name="reason">
                                <xsl:value-of select="$x_name"/>
                                <xsl:text> is not less than or equal to </xsl:text>
                                <xsl:value-of select="$y_name"/>
                            </xsl:attribute>
                            <xsl:copy-of select="$values"/>
                        </test>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="x_is_greater_than_or_equal_to_y">
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="y"/>
        <xsl:param name="y_name"/>
        <xsl:element name="test">
            <xsl:choose>
                <xsl:when test="$x &gt;= $y">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">
                        <xsl:value-of select="$x_name"/>
                        <xsl:text> is not greater than or equal to </xsl:text>
                        <xsl:value-of select="$y_name"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$x_name"/>
                </xsl:attribute>
                <xsl:value-of select="$x"/>
            </value>
            <value>
                <xsl:attribute name="name">
                    <xsl:value-of select="$y_name"/>
                </xsl:attribute>
                <xsl:value-of select="$y"/>
            </value>
        </xsl:element>
    </xsl:template>

    <xsl:template name="x_equals_y">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="y"/>
        <xsl:param name="y_name"/>
        <xsl:variable name="context">
            <context>
                <xsl:attribute name="field">
                    <xsl:value-of select="$y_name"/>
                </xsl:attribute>
                <xsl:attribute name="value">
                    <xsl:value-of select="$y"/>
                </xsl:attribute>
            </context>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$y = $x">
                <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                    <xsl:call-template name="check">
                        <xsl:with-param name="icid" select="$icid"/>
                        <xsl:with-param name="version" select="$version"/>
                        <xsl:with-param name="context" select="$context"/>
                        <xsl:with-param name="test">
                            <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <value>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="$x_name"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$x"/>
                                </value>
                            </test>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="check">
                    <xsl:with-param name="icid" select="$icid"/>
                    <xsl:with-param name="version" select="$version"/>
                    <xsl:with-param name="context" select="$context"/>
                    <xsl:with-param name="test">
                        <test>
                            <xsl:attribute name="outcome">fail</xsl:attribute>
                            <xsl:attribute name="reason">
                                <xsl:value-of select="$x_name"/>
                                <xsl:text> is incorrect</xsl:text>
                            </xsl:attribute>
                            <value>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="$x_name"/>
                                </xsl:attribute>
                                <xsl:value-of select="$x"/>
                            </value>
                        </test>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="x_is_first_child">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="parentVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="../mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="$x_name"/>
                        </xsl:attribute>
                        <xsl:value-of select="$xVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="../@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Parent Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$parentVINT"/>
                    </value>
                </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="count(preceding-sibling::mt:block[mt:block[@name='Header']]) = '0'">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:value-of select="$xVINT"/>
                                    <xsl:text> is used but not as the first element. It is Child Element number </xsl:text>
                                    <xsl:value-of select="count(preceding-sibling::mt:block[mt:block[@name='Header']]) + 1"/>
                                    <xsl:text> of </xsl:text>
                                    <xsl:value-of select="count(../mt:block[mt:block[@name='Header']])"/>
                                    <xsl:text> Child Elements under </xsl:text>
                                    <xsl:value-of select="$parentVINT"/>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="x_value_is_y_bytes">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:variable name="context">
            <context>
                <xsl:attribute name="field">
                    <xsl:text>Expected Size in Bytes</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="value">
                    <xsl:value-of select="$y"/>
                </xsl:attribute>
            </context>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="xSize">
                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Size']"/>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Element ID</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$xVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="../@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Element Data Size</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$xSize"/>
                    </value>
                </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$y = $xSize">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:text>The Element with id </xsl:text>
                                    <xsl:value-of select="$xVINT"/>
                                    <xsl:text> is an invalid size of </xsl:text>
                                    <xsl:value-of select="$xSize"/>
                                    <xsl:text> bytes.</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="context" select="$context"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="seek_element_resolves">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="seek_element"/>
        <xsl:variable name="FirstSegmentValueOffset">
            <xsl:value-of select="//mt:block[mt:block[@name='Header']/mt:data[@name='Name']='139690087']/@offset + //mt:block[mt:block[@name='Header']/mt:data[@name='Name']='139690087']/mt:block[@name='Header']/@size"/>
        </xsl:variable>
        <xsl:variable name="context">
            <context>
                <xsl:attribute name="field">
                    <xsl:text>Offset of First Segment Element</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="value">
                    <xsl:value-of select="$FirstSegmentValueOffset"/>
                </xsl:attribute>
            </context>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$seek_element">
                <xsl:variable name="SeekID">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[mt:block[@name='Header']/mt:data[@name='Name']='5035']/mt:data[@name='Data']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="SeekPosition">
                    <xsl:value-of select="mt:block[mt:block[@name='Header']/mt:data[@name='Name']='5036']/mt:data[@name='Data']"/>
                </xsl:variable>
                <xsl:variable name="SeekPositionFileOffset">
                    <xsl:value-of select="$FirstSegmentValueOffset + $SeekPosition"/>
                </xsl:variable>
                <xsl:variable name="ElementIDatOffset">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="//mt:block[@offset=$SeekPositionFileOffset]/mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="mt:block[mt:block[@name='Header']/mt:data[@name='Name']='5035']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>SeekID</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$SeekID"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="mt:block[mt:block[@name='Header']/mt:data[@name='Name']='5036']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>SeekPosition</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$SeekPosition"/>
                    </value>
                </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$SeekID = $ElementIDatOffset">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:text>The Seek Element at </xsl:text>
                                    <xsl:value-of select="@offset"/>
                                    <xsl:text> octets references an Element with </xsl:text>
                                    <xsl:value-of select="$SeekID"/>
                                    <xsl:text> as an ID and a Seek Position of </xsl:text>
                                    <xsl:value-of select="$SeekPosition"/>
                                    <xsl:text> but it is not there.</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="context" select="$context"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="child_data_info_is_ok">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="info">
                    <xsl:value-of select="mt:data[@name='Value']/@info"/>
                </xsl:variable>
                <xsl:variable name="CRCValue">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:data[@name='Value']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="parentVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="../mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="mt:data[@name='Value']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>CRC-32 Value</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$CRCValue"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="mt:data[@name='Value']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>CRC-32 Validation Outcome</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$info"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="../mt:block[@name='Header']/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Parent Element</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$parentVINT"/>
                    </value>
                </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$info != 'NOK'">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:text>The CRC-32 Element at </xsl:text>
                                    <xsl:value-of select="@offset"/>
                                    <xsl:text> contains a value </xsl:text>
                                    <xsl:value-of select="$CRCValue"/>
                                    <xsl:text> which results in a status of </xsl:text>
                                    <xsl:value-of select="$info"/>
                                    <xsl:text>.</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="x_is_in_list">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="x"/>
        <xsl:param name="x_name"/>
        <xsl:param name="list"/>
        <xsl:variable name="context">
            <context>
                <xsl:attribute name="field">
                    <xsl:text>Valid Values for </xsl:text>
                    <xsl:value-of select="$x_name"/>
                </xsl:attribute>
                <xsl:attribute name="value">
                    <xsl:value-of select="$list"/>
                </xsl:attribute>
            </context>
        </xsl:variable>
        <xsl:variable name="tests">
            <xsl:for-each select="$x">
                <xsl:variable name="xValue">
                    <xsl:value-of select="mt:data[@name='Data']"/>
                </xsl:variable>
                <xsl:variable name="CRCValue">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:data[@name='Value']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="xVINT">
                    <xsl:text>0x</xsl:text>
                    <xsl:call-template name="HexToVINT">
                        <xsl:with-param name="hex">
                            <xsl:call-template name="DecToHex">
                                <xsl:with-param name="dec">
                                    <xsl:value-of select="mt:block[@name='Header']/mt:data[@name='Name']"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="values">
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:text>EBML Element ID</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="$xVINT"/>
                    </value>
                    <value>
                        <xsl:attribute name="offset">
                            <xsl:value-of select="mt:data/@offset"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="$x_name"/>
                        </xsl:attribute>
                        <xsl:value-of select="$xValue"/>
                    </value>
                </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="contains($list,$xValue)">
                            <xsl:if test="$verbosity > $minimum_verbosity_for_pass">
                                <test>
                                    <xsl:attribute name="outcome">pass</xsl:attribute>
                                    <xsl:copy-of select="$values"/>
                                </test>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <test>
                                <xsl:attribute name="outcome">fail</xsl:attribute>
                                <xsl:attribute name="reason">
                                    <xsl:text>The value of </xsl:text>
                                    <xsl:value-of select="$x_name"/>
                                    <xsl:text> is not a valid value (</xsl:text>
                                    <xsl:value-of select="$list"/>
                                    <xsl:text>).</xsl:text>
                                </xsl:attribute>
                                <xsl:copy-of select="$values"/>
                            </test>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$tests != ''">
            <xsl:call-template name="check">
                <xsl:with-param name="icid" select="$icid"/>
                <xsl:with-param name="version" select="$version"/>
                <xsl:with-param name="context" select="$context"/>
                <xsl:with-param name="test" select="$tests"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="DecToHex">
        <xsl:param name="dec" />
        <xsl:if test="$dec > 0">
            <xsl:call-template name="DecToHex">
                <xsl:with-param name="dec" select="floor($dec div 16)" />
            </xsl:call-template>
            <xsl:choose>
                <xsl:when test="$dec mod 16 &lt; 10">
                    <xsl:value-of select="$dec mod 16" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$dec mod 16 = 10">A</xsl:when>
                        <xsl:when test="$dec mod 16 = 11">B</xsl:when>
                        <xsl:when test="$dec mod 16 = 12">C</xsl:when>
                        <xsl:when test="$dec mod 16 = 13">D</xsl:when>
                        <xsl:when test="$dec mod 16 = 14">E</xsl:when>
                        <xsl:when test="$dec mod 16 = 15">F</xsl:when>
                        <xsl:otherwise>A</xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="HexToVINT">
        <xsl:param name="hex" />
        <xsl:choose>
            <xsl:when test="string-length($hex) = 7">
                <xsl:text>1</xsl:text>
                <xsl:value-of select="$hex" />
            </xsl:when>
            <xsl:when test="string-length($hex) = 6">
                <xsl:choose>
                    <xsl:when test="starts-with($hex, '1')">
                        <xsl:text>3</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>YYYY</xsl:text>
                        <xsl:value-of select="$hex" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($hex) = 5">
                <xsl:text>2</xsl:text>
                <xsl:value-of select="$hex" />
            </xsl:when>
            <xsl:when test="string-length($hex) = 4">
                <xsl:choose>
                    <xsl:when test="starts-with($hex, '1')">
                        <xsl:text>5</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '2')">
                        <xsl:text>6</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '3')">
                        <xsl:text>7</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>YYYY</xsl:text>
                        <xsl:value-of select="$hex" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($hex) = 3">
                <xsl:text>4</xsl:text>
                <xsl:value-of select="$hex" />
            </xsl:when>
            <xsl:when test="string-length($hex) = 2">
                <xsl:choose>
                    <xsl:when test="starts-with($hex, '1')">
                        <xsl:text>9</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '2')">
                        <xsl:text>A</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '3')">
                        <xsl:text>B</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '4')">
                        <xsl:text>C</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '5')">
                        <xsl:text>D</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '6')">
                        <xsl:text>E</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:when test="starts-with($hex, '7')">
                        <xsl:text>F</xsl:text>
                        <xsl:value-of select="substring($hex, 2, string-length($hex)-1)" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>YYYY</xsl:text>
                        <xsl:value-of select="$hex" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($hex) = 1">
                <xsl:text>8</xsl:text>
                <xsl:value-of select="$hex" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$hex" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="exists">
        <xsl:param name="xpath"/>
        <xsl:param name="field"/>
        <context>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
        </context>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="string-length($xpath) != 0">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">does not exist</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="does_not_exist">
        <xsl:param name="xpath"/>
        <xsl:param name="field"/>
        <context>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
        </context>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="string-length($xpath) = '0'">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">exists</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="contains_string">
        <xsl:param name="xpath"/>
        <xsl:param name="value"/>
        <xsl:param name="field"/>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="field">
                <xsl:value-of select="$field"/>
            </xsl:attribute>
            <xsl:attribute name="expected">
                <xsl:value-of select="$value"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="contains($xpath, $value)">
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">pass</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">fail</xsl:attribute>
                        <xsl:attribute name="reason">does not contain</xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <!-- sadly this doesn't work in xslt 1.0
    <xsl:template name="matches_regex">
        <xsl:param name="xpath"/>
        <xsl:param name="value"/>
        <xsl:param name="field"/>
        <xsl:element name="test">
            <xsl:attribute name="field"><xsl:value-of select="$field"/></xsl:attribute>
            <xsl:attribute name="expected"><xsl:value-of select="$value"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="$xpath"/></xsl:attribute>
        <xsl:choose>
            <xsl:when test="matches($xpath, $value)">
                <xsl:element name="result">
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="result">
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">does not match regex</xsl:attribute>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
    </xsl:template>
    -->
    <xsl:template name="is_number">
        <xsl:param name="xpath"/>
        <xsl:element name="test">
            <xsl:if test="../@type">
                <xsl:attribute name="tracktype">
                    <xsl:value-of select="../@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../@tracktypeorder">
                <xsl:attribute name="tracktypeorder">
                    <xsl:value-of select="../@tracktypeorder"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../mi:ID">
                <xsl:attribute name="trackid">
                    <xsl:value-of select="../mi:ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="value">
                <xsl:value-of select="$xpath"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="string-length(translate($xpath,$decimal,'')) = 0">
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">pass</xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="result">
                        <xsl:attribute name="outcome">fail</xsl:attribute>
                        <xsl:attribute name="reason">contains non-numeric values</xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="replace">
        <xsl:param name="text"/>
        <xsl:param name="search"/>
        <xsl:param name="replace"/>
        <xsl:choose>
            <xsl:when test="contains($text, $search)">
                <xsl:variable name="replace-next">
                    <xsl:call-template name="replace">
                        <xsl:with-param name="text" select="substring-after($text, $search)"/>
                        <xsl:with-param name="search" select="$search"/>
                        <xsl:with-param name="replace" select="$replace"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of 
                    select="
                        concat(
                            substring-before($text, $search)
                        ,   $replace
                        ,   $replace-next
                        )
                    "
                />
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="check">
        <xsl:param name="icid"/>
        <xsl:param name="version"/>
        <xsl:param name="context"/>
        <xsl:param name="test"/>
        <check>
            <xsl:attribute name="icid">
                <xsl:value-of select="$icid"/>
            </xsl:attribute>
            <xsl:attribute name="version">
                <xsl:value-of select="$version"/>
            </xsl:attribute>
            <xsl:copy-of select="$context"/>
            <xsl:copy-of select="$test"/>
        </check>
    </xsl:template>
</xsl:stylesheet>
