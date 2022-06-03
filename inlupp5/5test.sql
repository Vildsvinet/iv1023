SELECT XMLELEMENT(NAME "Resultat", XMLAGG(Hold))
from (Select XMLELEMENT(NAME "Förlag", XMLATTRIBUTES(name AS "namn", country as "land"),
                        XMLAGG(xmlelement(NAME "Språk", språk))) as hold
      from publisher,
           (Select distinct Språk, Förlag
            from edition,
                 XMLTABLE('$t//Translation'
                          PASSING translations AS "t"
                          COLUMNS Språk VARCHAR(30) PATH '@Language'
                     , Förlag VARCHAR(30) PATH '@Publisher') AS tt)
      where förlag = publisher.Name
      group by förlag, country, name)



-- Select XMLELEMENT(NAME "Alla", XMLAGG(hold))
-- From (SELECT XMLELEMENT(Name "Författare",
--                         XMLATTRIBUTES(Author.name as "Namn", land as "Land"),
--                         XMLAGG(XMLELEMENT(Name "Bok",
--                                           XMLATTRIBUTES(Book.title as "Title", book.originallanguage as "OrginalSpråk",
--                                                         book.genre as "Genre")))) as Hold
--       FROM (SELECT Land, rownum, id as control
--             FROM Author, XMLTABLE('$t//Country'
--                                   PASSING Info AS "t"
--                                   Columns Land VARCHAR(30) PATH '.')),
--            Author,
--            authorship,
--            book
--       Where Author.Id = authorship.author
--         and book.id = authorship.book
--         and control = author.id
--       Group by author.name, land)
--
--
-- SELECT XMLELEMENT(NAME "Alla", XMLAGG(hold))
-- FROM (SELECT XMLELEMENT(
--                      NAME "Författare",
--                      XMLATTRIBUTES(Author.name as "Namn", tt.Land as "Land"),
--                      XMLAGG(
--                              XMLELEMENT(
--                                      NAME "Bok",
--                                      XMLATTRIBUTES(Book.title as "Titel", Book.originallanguage as "OrginalSpråk",
--                                                    Book.genre as "Genre")
--                                  )
--                          )
--                  ) AS hold
--       FROM Author,
--            Authorship,
--            Book,
--            XMLTABLE('$t//Country'
--                     PASSING Info AS "t"
--                     COLUMNS Land VARCHAR(30) PATH '.') AS tt
--       WHERE book.id = authorship.book
--         AND author.id = authorship.author
--       GROUP BY Author.name, tt.Land)