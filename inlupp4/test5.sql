SELECT title, originallanguage, genre, nvl(antalSpråk, 0)+1 as "Antal Språk", ca as "Antal författare", ce as "Antal upplagor", min(year) as "Året den tidigaste upplagen kom"
FROM
    (SELECT edition.book as språkboktrack, count(distinct(SPRÅK)) as antalSpråk, MIN(year) as years
     FROM edition,
          XMLTABLE('$t//Translation'
                   PASSING translations AS "t"
                   COLUMNS Språk VARCHAR(30) PATH '@Language') AS tt
     GROUP BY edition.book) right join edition on språkboktrack = edition.book,

    (SELECT count(author) as ca, book.id as språkboktrack2, title, genre, book.originallanguage, count(book.id) as ce
     FROM authorship, book
     WHERE authorship.book = book.id
     GROUP BY book.id, title, genre, originallanguage)
WHERE edition.book = språkboktrack2
GROUP BY edition.book, antalSpråk, title, genre, ca, originallanguage, ce
