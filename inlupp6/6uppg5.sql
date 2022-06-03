/*Inlupp 6.5
  Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
  kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen
  //TODO Använd inte FROM (check) och förenkla villkoret så att varje tabell används en gång.
*/

--Utan FROM men förmodligen fortfarande för "krångligt" villkor
UPDATE edition
SET translations.modify
        ('
        	insert <Translation Language = "Swedish" Publisher = "Bonniers" Price = "200"/> as last into (/Translations)[1]
        ')
WHERE edition.book = (SELECT id FROM book WHERE title = 'Encore une fois')
  AND edition.year = (SELECT max(year)
                      FROM edition
                      WHERE edition.book = (SELECT id
                                            FROM book
                                            WHERE title = 'Encore une fois'))

-- Old discarded
-- UPDATE edition
-- SET translations.modify
--         ('
--         	insert <Translation Language = "Norwegian" Publisher = "KLC" Price = "200"/> as last into (/Translations)[1]
--         ')
-- FROM book, edition
-- WHERE edition.book = book.id
--   AND book.title = 'Encore une fois'
--   AND edition.year = (SELECT MAX(edition.year)
--                       FROM edition, book
--                       WHERE edition.book = book.id
--                         AND book.title = 'Encore une fois')

/*OUTPUT
<Translations>
  <Translation Language="English" Publisher="Pels And Jafs" Price="180" />
  <Translation Language="Russian" Price="140" />
  <Translation Language="Norwegian" Publisher="KLC" Price="200" />
</Translations>
*/