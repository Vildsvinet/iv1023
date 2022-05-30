/*Inlupp 6.4
  Ta fram namn och land på författare till böcker som har översatts till ryska! Resultatet skall ha två kolumner
*/

SELECT DISTINCT author.name AS Namn, author.info.value('(//Country)[1]', 'VARCHAR(20)') AS Land
FROM authorship, author, edition
WHERE authorship.author = author.id AND authorship.book = edition.book
  AND translations.exist('//*[@Language="Russian"]') = 1

/*OUTPUT
  Namn                 Land
-------------------- --------------------
Alicia Bing          Belgium
Andreas Shultz       Austria
Antje Liedderman     Germany
Auna Gonzales Perre  Portugal
Carl George          France
Carl Sagan           USA
Christina Ohlsen     Norway
John Craft           England
Kostas Andrianos     Greece
Lilian Carrera       Spain
Linda Evans          USA
Mimi Pappas          USA
Peter Feldon         England
Pierre Zargone       Belgium
Sam Davis            Mexiko
*/