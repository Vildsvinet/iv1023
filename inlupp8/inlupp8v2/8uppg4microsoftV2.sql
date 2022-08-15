SELECT Land.country AS namn,
       Stad.city AS namn,
       Stad.antalforlag AS antalförlag
FROM (
         SELECT DISTINCT city, country
         FROM publisher
     ) Land,
     (
         SELECT city, country, COUNT(*) as antalforlag
         FROM publisher
         GROUP BY city, country
     ) Stad
WHERE Land.city = Stad.city AND Land.country=Stad.country
ORDER BY Land.country
    FOR XML AUTO, ROOT('Resultat')


/*
<Resultat>
  <Land namn="Austria">
    <Stad namn="Vienna" antalförlag="1" />
  </Land>
  <Land namn="Belgium">
    <Stad namn="Brussels" antalförlag="1" />
  </Land>
  <Land namn="China">
    <Stad namn="Shanghai" antalförlag="1" />
  </Land>
  <Land namn="England">
    <Stad namn="London" antalförlag="1" />
  </Land>
  <Land namn="Finland">
    <Stad namn="Helsinki" antalförlag="1" />
  </Land>
  <Land namn="France">
    <Stad namn="Toulouse" antalförlag="1" />
  </Land>
  <Land namn="Germany">
    <Stad namn="Berlin" antalförlag="1" />
  </Land>
  <Land namn="Italy">
    <Stad namn="Florence" antalförlag="1" />
  </Land>
  <Land namn="Kanada">
    <Stad namn="London" antalförlag="1" />
  </Land>
  <Land namn="Russia">
    <Stad namn="Saint Petersburg" antalförlag="1" />
  </Land>
  <Land namn="Scotland">
    <Stad namn="Edinburg" antalförlag="1" />
  </Land>
  <Land namn="Sweden">
    <Stad namn="Stockholm" antalförlag="2" />
    <Stad namn="Uppsala" antalförlag="1" />
  </Land>
  <Land namn="Turkey">
    <Stad namn="Ankara" antalförlag="1" />
  </Land>
</Resultat>
*/