SELECT XMLELEMENT(NAME "Resultat", XMLAGG(tst))
FROM (SELECT XMLELEMENT(NAME "Genre", XMLATTRIBUTES(genre AS "namn", (select COUNT(title)
                                                                      from book
                                                                      where book.genre = t2.genre
                                                                      group by genre) AS "antalböcker"),
                        XMLAGG(XMLELEMENT(NAME "Språk", language))) AS tst
      FROM (SELECT genre, language
            FROM book,
                 (SELECT id AS bookid, originallanguage AS language
                  FROM book
                  UNION
                  (SELECT book AS bookid, language
                   FROM edition, XMLTABLE('$t//Translation'
                                          PASSING translations as "t"
                                          COLUMNS language VARCHAR(20) PATH '@Language'
                       ))) t1
            WHERE book.id = t1.bookid
              AND genre IS NOT NULL
            GROUP BY genre, language) t2
      GROUP BY genre)


/*
<Resultat>
    <Genre namn="Educational" antalböcker="7">
        <Språk>Bulgarian</Språk>
        <Språk>Chinese</Språk>
        <Språk>Danish</Språk>
        <Språk>Dutch</Språk>
        <Språk>English</Språk>
        <Språk>Finnish</Språk>
        <Språk>French</Språk>
        <Språk>German</Språk>
        <Språk>Greek</Språk>
        <Språk>Italian</Språk>
        <Språk>Norwegian</Språk>
        <Språk>Portuguese</Språk>
        <Språk>Russian</Språk>
        <Språk>Spanish</Språk>
        <Språk>Swedish</Språk>
        <Språk>Turkish</Språk>
    </Genre>
    <Genre namn="Novel" antalböcker="4">
        <Språk>English</Språk>
        <Språk>Finnish</Språk>
        <Språk>Swedish</Språk>
    </Genre>
    <Genre namn="Science Fiction" antalböcker="2">
        <Språk>English</Språk>
        <Språk>German</Språk>
        <Språk>Russian</Språk>
        <Språk>Swedish</Språk>
    </Genre>
    <Genre namn="Thriller" antalböcker="2">
        <Språk>English</Språk>
        <Språk>French</Språk>
        <Språk>German</Språk>
        <Språk>Russian</Språk>
        <Språk>Swedish</Språk>
    </Genre>
</Resultat>

*/