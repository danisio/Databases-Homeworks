<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/students">
    <html>
      <head>
        <style>
          dl {
          border: 3px double #ccc;
          padding: 0.5em;
          }
          dt {
          float: left;
          clear: left;
          width: 100px;
          text-align: right;
          font-weight: bold;
          color: green;
          }
          dt:after {
          content: ":";
          }
          dd {
          margin: 0 0 0 110px;
          padding: 0 0 0.5em 0;
          }
        </style>
      </head>
      <body>
        <h1>List of all students</h1>
        <xsl:for-each select="student">
          <xsl:number format="1. "/>Student number: <strong>
            <xsl:value-of select="facultyNumber"/>
          </strong>
          <dl style="position:center">
            <dt>Name</dt>
            <dd>
              <strong>
                <xsl:value-of select="name"/>
              </strong>
            </dd>
            <dt>Birth date</dt>
            <dd>
              <xsl:value-of select="birthDate"/>
            </dd>
            <dt>Phone</dt>
            <dd>
              <xsl:value-of select="phone"/>
            </dd>
            <dt>Email</dt>
            <dd>
              <xsl:value-of select="email"/>
            </dd>
            <dt>Course</dt>
            <dd>
              <xsl:value-of select="course"/>
            </dd>
            <dt>Specialty</dt>
            <dd>
              <xsl:value-of select="specialty"/>
            </dd>
            <dt>Phone</dt>
            <dd>
              <xsl:value-of select="phone"/>
            </dd>
            <dt>Exams</dt>
            <xsl:for-each select="exams/exam">
              <dd>
                <xsl:value-of select="name"/>/Score:
                <strong>
                  <xsl:value-of select="score"/>
                </strong>/Tutor: <xsl:value-of select="tutor"/>
              </dd>
            </xsl:for-each>
          </dl>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>