(: Uppgift 2.6 Det har visat sig att den franska översättningen av 1999-års upplaga av "Archeology in Egypt"
är utgiven av förlaget "ABC International" och inte av "KLC". Gör ändringen i databasen!:)

for $tr in //Book[@Title="Archeology in Egypt"]/Edition[@Year="1999"]/Translation[@Language="French"]
return
    replace value of node $tr/@Publisher with "ABC International"


(:Output extract
  <Book Title="Archeology in Egypt" OriginalLanguage="English" Genre="Educational">
    <Author Name="Arnie Bastoft" Email="bastoft@frei.at" YearOfBirth="1971" Country="Austria"/>
    <Author Name="Meg Gilmand" Email="megil@archeo.org" YearOfBirth="1968" Country="Australia"/>
    <Author Name="Chris Ryan" Email="chris@egypt.eg" YearOfBirth="1944" Country="France"/>
    <Edition Year="1992" Price="250">
      <Translation Language="Swedish" Price="340"/>
      <Translation Language="French" Price="320"/>
    </Edition>
    <Edition Year="1994" Price="280">
      <Translation Language="Swedish" Publisher="KLC" Price="390"/>
      <Translation Language="French" Publisher="KLC" Price="330"/>
      <Translation Language="Chinese" Publisher="Shou-Ling" Price="280"/>
    </Edition>
    <Edition Year="1999" Price="280">
      <Translation Language="French" Publisher="ABC International" Price="320"/>
      <Translation Language="Italian" Publisher="KLC" Price="320"/>
      <Translation Language="Turkish" Publisher="Turk And Turk" Price="300"/>
      <Translation Language="Spanish" Price="300"/>
    </Edition>
  </Book>

:)