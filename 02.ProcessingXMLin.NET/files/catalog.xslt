<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/catalog">
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
        <h1>List of all albums in the catalog</h1>
        <xsl:for-each select="album">
          <dl style="position:center">
            <dt>Name</dt>
            <dd>
              <strong>
                <xsl:value-of select="name"/>
              </strong>
            </dd>
            <dt>Author</dt>
            <dd>
              <strong>
                <xsl:value-of select="artist"/>
              </strong>
            </dd>
            <dt>Year</dt>
            <dd>
              <strong>
                <xsl:value-of select="year"/>
              </strong>
            </dd>
            <dt>Producer</dt>
            <dd>
              <strong>
                <xsl:value-of select="producer"/>
              </strong>
            </dd>
            <dt>Price</dt>
            <dd>
              <strong>
                <xsl:value-of select="price"/>
              </strong>
            </dd>
            <dt>Songs</dt>
            <xsl:for-each select="songs/song">
              <dd>
                <em>
                  <xsl:value-of select="title"/>
                </em> (<xsl:value-of select="duration"/>)
              </dd>
            </xsl:for-each>
          </dl>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
