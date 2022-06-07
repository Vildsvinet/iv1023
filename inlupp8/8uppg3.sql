--SELECT COUNT(t1.bks)
--FROM  (SELECT book.id AS bks FROM book WHERE book.genre = 'Novel') t1

--select genre, count(book.id) as antal from book group by genre

SELECT XMLELEMENT(NAME "Resultat", XMLELEMENT(NAME "Genre", XMLATTRIBUTES(genre as "namn"), XMLAGG(XMLELEMENT(NAME "Språk", språk))))
FROM(
        select distinct genre, t1.språk as språk
        from book,
             (select book, language as språk
              from edition, xmltable('$t//Translation'
                                     PASSING translations as "t"
                                     COLUMNS language VARCHAR(20) PATH '@Language'
                  )
             ) t1
        WHERE book.id = t1.book
        ORDER BY genre
    )


        --SELECT COUNT(t1.bks)
--FROM  (SELECT book.id AS bks FROM book WHERE book.genre = 'Novel') t1

--select genre, count(book.id) as antal from book group by genre

        SELECT genre, XMLAGG(XMLELEMENT(NAME "Språk", språk))
FROM(
    select distinct genre, t1.språk as språk
    from book,
    (select book, language as språk
    from edition, xmltable('$t//Translation'
    PASSING translations as "t"
    COLUMNS language VARCHAR(20) PATH '@Language'
    )
    ) t1
    WHERE book.id = t1.book
    GROUP BY genre, språk
    ORDER BY genre
    )
group by genre

--XMLELEMENT(NAME "Genre", XMLAGG(XMLELEMENT(NAME "Språk", språk)))
--SELECT COUNT(t1.bks)
--FROM  (SELECT book.id AS bks FROM book WHERE book.genre = 'Novel') t1

--select genre, count(book.id) as antal from book group by genre

SELECT genre, XMLAGG(XMLELEMENT(NAME "Språk", språk))
FROM(
        select distinct genre, t1.språk as språk
        from book,
             (select book, language as språk
              from edition, xmltable('$t//Translation'
                                     PASSING translations as "t"
                                     COLUMNS language VARCHAR(20) PATH '@Language'
                  )
             ) t1
        WHERE book.id = t1.book
        ORDER BY genre
    )
group by genre


_
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(tst))
FROM
    (
        SELECT XMLELEMENT(NAME "Genre", XMLATTRIBUTES(genre as "namn"), spraaak) AS tst
        FROM (
                 SELECT genre, XMLAGG(XMLELEMENT(NAME "Språk", språk)) as spraaak
                 FROM (
                          select distinct genre, t1.språk as språk
                          from book,
                               (select book, language as språk
                                from edition, xmltable('$t//Translation'
                                                       PASSING translations as "t"
                                                       COLUMNS language VARCHAR(20) PATH '@Language'
                                    )
                               ) t1
                          WHERE book.id = t1.book
                          ORDER BY genre
                      )
                 group by genre
             )
    )



        --SELECT COUNT(t1.bks)
--FROM  (SELECT book.id AS bks FROM book WHERE book.genre = 'Novel') t1

--select genre, count(book.id) as antal from book group by genre

        SELECT XMLELEMENT(NAME "Resultat", XMLAGG(tst))
FROM
    (
    SELECT XMLELEMENT(NAME "Genre", XMLATTRIBUTES(genre as "namn", antal as "antalböcker"), spraaak) AS tst
    FROM (
    SELECT antal, genre, XMLAGG(XMLELEMENT(NAME "Språk", språk)) as spraaak
    FROM (
    select distinct genre, t1.språk as språk, count(book.id) as antal
    from book,
    (select book, language as språk
    from edition, xmltable('$t//Translation'
    PASSING translations as "t"
    COLUMNS language VARCHAR(20) PATH '@Language'
    )
    ) t1
    WHERE book.id = t1.book
    GROUP BY genre, språk
    --ORDER BY genre
    ) t2
    GROUP BY genre, antal
    )
    )
--XMLELEMENT(NAME "Genre", XMLAGG(XMLELEMENT(NAME "Språk", språk)))