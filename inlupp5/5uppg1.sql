select title,
       originallanguage,
       genre,
       nvl(antalSpråk, 0) + 1 as "Antal Språk",
       ca                     as "Antal författare",
       ce                     as "Antal upplagor",
       min(year)              as "Året den tidigaste upplagen kom"
from (select edition.book as språkboktrack, count(distinct (SPRÅK)) as antalSpråk, min(year) as years
      from edition,
           XMLTABLE('$t//Translation'
               PASSING translations AS "t"
            COLUMNS Språk VARCHAR(30) PATH '@Language') AS tt
      group by edition.book)
         right join edition on språkboktrack = edition.book,

     (select count(author) as ca, book.id as språkboktrack2, title, genre, book.originallanguage, count(book.id) as ce
      from authorship,
           book
      where authorship.book = book.id
      group by book.id, title, genre, originallanguage)
where edition.book = språkboktrack2
group by edition.book, antalSpråk, title, genre, ca, originallanguage, ce
