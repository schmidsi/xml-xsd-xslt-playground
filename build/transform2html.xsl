<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>XML/XSD/XSL with jade, gulp and node.js example</title>
        <link href="http://fonts.googleapis.com/css?family=Lato:100,300,400" rel="stylesheet" type="text/css"></link>
        <style>html {
  font-family: 'Lato', sans-serif;
  font-weight: 300;
}
h1 {
  font-weight: 300;
}
.person {
  transition: background-color 0.5s;
  margin-bottom: 2em;
}
.person.highlight {
  background-color: #ff0;
}
.portrait {
  height: 50px;
  width: 50px;
  display: inline-block;
  background-size: cover;
  border-radius: 50px;
  float: left;
  margin-right: 1em;
}
.name {
  font-weight: 400;
}
a {
  color: #000;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}
#map {
  height: 400px;
  width: 100%;
  margin-bottom: 2em;
}

        </style>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script src="js/map.js"></script>
      </head>
      <body>
        <h1>Persons</h1>
        <div id="map"></div>
        <xsl:for-each select="persons/person">
          <div data-location="{location}" class="person">
            <div style="background-image: url({picture})" class="portrait"></div>
            <div class="name">
              <xsl:value-of select="name"></xsl:value-of> (<a href="http://www.twitter.com/{twitter}" target="_blank">
                <xsl:value-of select="twitter"></xsl:value-of></a>)
            </div>
            <div class="email"><a href="mailto:{email}">
                <xsl:value-of select="email"></xsl:value-of></a></div>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>