(: Uppgift 2.6 Författaren Sam Davis heter egentligen Samuel Davies. Gör ändringen i databasen :)

for $au in //Author[@Name="Sam Davis"]
return
    replace value of node $au/@Name with "Samuel Davies"

(:Output extract
<Books>
  <Book Title="Music Now and Before" OriginalLanguage="English" Genre="Educational">
    <Author Name="Samuel Davies" Email="sd@music.com" YearOfBirth="1939" Country="Mexico"/>
    <Author Name="Mimi Pappas" Email="mimi@music.com" YearOfBirth="1972" Country="USA"/>
    <Edition Year="1997" Price="300">
      <Translation Language="German" Publisher="ABC International" Price="310"/>
      <Translation Language="French" Price="310"/>
      <Translation Language="Russian" Price="300"/>
      <Translation Language="Italian" Publisher="KLC" Price="300"/>
    </Edition>
    <Edition Year="1999" Price="315">
      <Translation Language="German" Publisher="ABC International" Price="320"/>
      <Translation Language="French" Publisher="ABC International" Price="330"/>
    </Edition>
    <Edition Year="2001" Price="335">
      <Translation Language="German" Publisher="ABC International" Price="350"/>
    </Edition>
  </Book>
  <Book Title="Musical Instruments" OriginalLanguage="English" Genre="Educational">
    <Author Name="Samuel Davies" Email="sd@music.com" YearOfBirth="1939" Country="Mexico"/>
    <Author Name="Alicia Bing" Email="bing@bing.be" YearOfBirth="1952" Country="Belgium"/>
    <Edition Year="1991" Price="300">
      <Translation Language="Portuguese" Publisher="ABC International" Price="300"/>
      <Translation Language="Chinese" Publisher="ABC International" Price="350"/>
      <Translation Language="Russian" Publisher="ABC International" Price="355"/>
      <Translation Language="Italian" Publisher="ABC International" Price="345"/>
      <Translation Language="Spanish" Publisher="ABC International" Price="335"/>
    </Edition>
    <Edition Year="2001" Price="500">
      <Translation Language="Dutch" Publisher="ABC International" Price="510"/>
      <Translation Language="German" Publisher="ABC International" Price="510"/>
      <Translation Language="Spanish" Publisher="ABC International" Price="505"/>
    </Edition>
  </Book>
</Books>
:)
