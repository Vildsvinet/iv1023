--Vilka böckers översättningar har publicerats av varje förlag?
-- TODO remove duplicates

SELECT XMLELEMENT(NAME "Resultat", XMLAGG(förlag))
FROM (
     SELECT XMLELEMENT(
        NAME "Förlag",
        XMLATTRIBUTES(tt.Förlag AS "Namn", publisher.country as "Land"),
        XMLAGG(XMLELEMENT(
                NAME "Bok",
                XMLATTRIBUTES(book.title AS "Titel", book.genre AS "Genre")
            ))
     ) AS förlag
     FROM publisher, edition, book,
          XMLTABLE('$t//Translation'
            PASSING translations AS "t"
            COLUMNS Förlag VARCHAR(30) PATH '@Publisher'
            ) AS tt
     WHERE book.id = edition.book
       AND publisher.name = tt.förlag
     GROUP BY tt.Förlag, publisher.country
 )