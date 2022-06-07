/*Inlupp 4.1  Vilka böcker har flera utgåvor?*/
/*Förslag på ny lösning. Ingen tabell används mer än en gång.
  Syftet med GROUP BY är att kunna räkna hur många utgåvor som finns för varje boktitel*/
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(books))
FROM (
         SELECT XMLELEMENT(
                        NAME "Bok",
                        XMLATTRIBUTES(book.title AS "Titel")
                    ) AS books
         FROM book, edition
         WHERE book.id = edition.book
         GROUP BY book.title
         HAVING COUNT(edition.book) > 1
     )

/*Output
<Resultat>
    <Bok Titel="Archeology in Egypt"/>
    <Bok Titel="Database Systems in Practice"/>
    <Bok Titel="Encore une fois"/>
    <Bok Titel="Music Now and Before"/>
    <Bok Titel="Musical Instruments"/>
    <Bok Titel="Oceanography for Dummies"/>
    <Bok Titel="Oceans on Earth"/>
    <Bok Titel="Våren vid sjön"/>
</Resultat>
*/

/*************************************************************************************/

/*Inlupp 4.4
  Ta fram namn och land på författare till böcker som har översatts till ryska! Resultatet skall ha två kolumner

  Feedback
  -Tabellen Book verkar onödig.
    Svar: Vi behövde joina tabellerna edition och authorship och på den grafiska representationen
    av relationsdatabasen så ligger tabellen Book "mitt emellan" och vi ville använda nycklar.
  -Varför använder ni GROUP BY? ta bort dubbletterna kan ni göra med DISTINCT
    Svar: ok, ändrat!
  -Eventuellt hade en lösning med XMLEXISTS varit kompaktare.
    Svar: ok, ändrat!
  -Språket är endast relevant som en del av villkoret. Just nu verkar ni jämföra att 'Russian' är 'Russian'
    Svar: Hoppsan!
*/

SELECT DISTINCT Author.name, it.land
FROM Author, Authorship,
    (SELECT book
    FROM edition
    WHERE XMLEXISTS('$t//Translation[@Language="Russian"]' PASSING Translations AS "t")
    ) AS ed,
    XMLTABLE(
    '$a//Info'
    PASSING Info AS "a"
    COLUMNS Land VARCHAR(30) PATH 'Country'
    ) AS it
WHERE ed.book = authorship.book AND author.id = authorship.author
ORDER BY Author.name

/*OUTPUT:
 NAME                LAND
 ------------------- --------
 Alicia Bing         Belgium
 Andreas Shultz      Austria
 Antje Liedderman    Germany
 Auna Gonzales Perre Portugal
 Carl George         France
 Carl Sagan          USA
 Christina Ohlsen    Norway
 John Craft          England
 Kostas Andrianos    Greece
 Lilian Carrera      Spain
 Linda Evans         USA
 Mimi Pappas         USA
 Peter Feldon        England
 Pierre Zargone      Belgium
 Sam Davis           Mexiko
*/

/*************************************************************************************/

/*Inlupp 4.5
  Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
  kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen
*/

UPDATE Edition
SET translations =
    XMLQUERY('
        transform
        copy $res := $t
        modify do insert element
            Translation {attribute Language {"Norwegian"}, attribute Publisher {"KLC"}, attribute Price {200}}
        as last into $res/Translations
        return $res'
                 PASSING translations AS "t"
    )
WHERE edition.id =
    (
    SELECT id FROM
        (
            SELECT edition.id, edition.year
            FROM book, edition
            WHERE title = 'Encore une fois'
            AND book.id = edition.book
            ORDER BY edition.year DESC
        )
        FETCH FIRST 1 ROWS ONLY
    )


/*OUTPUT
  TITLE           	TRANSLATIONS
  --------------- 	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Encore une fois	<Translations><Translation Language="English" Publisher="Pels And Jafs" Price="180"/><Translation Language="Russian" Price="140"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/><Translation Language="Norwegian" Publisher="KLC" Price="200"/></Translations>
*/

/*************************************************************************************/
/*Inlupp 4.6
  Ta fram följande information om samtliga böcker: titel, originalspråk, genre, antal
  upplagor, antal olika språk boken finns tillgänglig på, antal författare och året då den
  tidigaste upplagan kom.
*/

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

/*OUTPUT
 TITLE                        	ORIGINALLANGUAGE 	GENRE           	Antal Språk 	Antal författare 	Antal upplagor 	Året den tidigaste upplagen kom
 ---------------------------- 	---------------- 	--------------- 	----------- 	---------------- 	-------------- 	-------------------------------
 Misty Nights                	English         	Thriller       	          4	               1	             1	                           1987
 Archeology in Egypt         	English         	Educational    	          7	               3	             3	                           1992
 Database Systems in Practice	English         	Educational    	          1	               3	             3	                           2000
 Contact                     	English         	Science Fiction	          4	               1	             1	                           1988
 The Fourth Star             	English         	Science Fiction	          2	               1	             1	                           2001
 Våren vid sjön              	Swedish         	Novel          	          1	               1	             1	                           1982
 Dödliga Data                	Swedish         	Thriller       	          1	               1	             1	                           1993
 Music Now and Before        	English         	Educational    	          4	               2	             2	                           1997
 Midsommar i Lund            	Swedish         	Novel          	          2	               1	             1	                           1988
 Encore une fois             	French          	NULL           	          5	               1	             1	                           1997
 European History            	English         	Educational    	         13	               8	             8	                           1998
 Musical Instruments         	English         	Educational    	          8	               2	             2	                           1991
 Oceans on Earth             	English         	Educational    	          7	               3	             3	                           1996
 The Beach House             	English         	Novel          	          1	               2	             2	                           2002
 Le chateau de mon pere      	French          	NULL           	          6	               1	             1	                           1964
 Oceanography for Dummies    	English         	Educational    	          2	               1	             1	                           2004
 The Fifth Star              	English         	Novel          	          2	               1	             1	                           2003
*/

/*************************************************************************************/
/*Inlupp 4.7
  Ta fram information om på vilka språk varje förlag har böcker!
  Feedback
  - Varför använder ni tabellen Publisher två gånger?
*/
SELECT XMLELEMENT(NAME "Resultat", XMLAGG(Hold))
FROM (SELECT XMLELEMENT(NAME "Förlag", XMLATTRIBUTES(name AS "namn", country AS "land"),
                        XMLAGG(xmlelement(NAME "Språk", språk))) AS hold
      FROM publisher,
           (SELECT DISTINCT Språk, Förlag
            FROM edition,
                 XMLTABLE('$t//Translation'
                    PASSING translations AS "t"
                    COLUMNS Språk VARCHAR(30) PATH '@Language',
                            Förlag VARCHAR(30) PATH '@Publisher') AS tt)
      WHERE förlag = publisher.Name
      GROUP BY förlag, country, name)

/* OUTPUT:
<Resultat>
    <Förlag namn="ABC International" land="Germany">
        <Språk>Chinese</Språk>
        <Språk>Danish</Språk>
        <Språk>Dutch</Språk>
        <Språk>French</Språk>
        <Språk>German</Språk>
        <Språk>Italian</Språk>
        <Språk>Portuguese</Språk>
        <Språk>Russian</Språk>
        <Språk>Spanish</Språk>
    </Förlag>
    <Förlag namn="Addison" land="France">
        <Språk>French</Språk>
        <Språk>Russian</Språk>
    </Förlag>
    <Förlag namn="Aurora Publ." land="Italy">
        <Språk>Italian</Språk>
    </Förlag>
    <Förlag namn="Bästa Bok" land="Sweden">
        <Språk>Swedish</Språk>
    </Förlag>
    <Förlag namn="Benton Inc" land="England">
        <Språk>English</Språk>
    </Förlag>
    <Förlag namn="EU Publishing" land="Belgium">
        <Språk>Bulgarian</Språk>
        <Språk>Danish</Språk>
        <Språk>Dutch</Språk>
        <Språk>Finnish</Språk>
        <Språk>French</Språk>
        <Språk>Greek</Språk>
        <Språk>Italian</Språk>
        <Språk>Norwegian</Språk>
        <Språk>Portuguese</Språk>
        <Språk>Russian</Språk>
        <Språk>Spanish</Språk>
        <Språk>Swedish</Språk>
    </Förlag>
    <Förlag namn="Kingsly" land="Austria">
        <Språk>German</Språk>
    </Förlag>
    <Förlag namn="KLC" land="Sweden">
        <Språk>French</Språk>
        <Språk>Italian</Språk>
        <Språk>Norwegian</Språk>
        <Språk>Swedish</Språk>
    </Förlag>
    <Förlag namn="Pels And Jafs" land="Scotland">
        <Språk>English</Språk>
    </Förlag>
    <Förlag namn="RP" land="Russia">
        <Språk>Russian</Språk>
    </Förlag>
    <Förlag namn="SCB" land="Sweden">
        <Språk>Swedish</Språk>
    </Förlag>
    <Förlag namn="Shou-Ling" land="China">
        <Språk>Chinese</Språk>
    </Förlag>
    <Förlag namn="Suomi Bookkii" land="Finland">
        <Språk>Finnish</Språk>
    </Förlag>
    <Förlag namn="Turk And Turk" land="Turkey">
        <Språk>Turkish</Språk>
    </Förlag>
</Resultat>
*/

/*************************************************************************************/
/*Inlupp 4.8
  Det har visat sig att den franska översättningen av 1999-års upplaga av "Archeology in
  Egypt" är utgiven av förlaget "ABC International" och inte av "KLC". Gör ändringen i databasen!

  FEEDBACK
  - Villkoret kan förenklas.
    Svar: Villkoret ska vara förenklat så tillvida att vi inte använder/läser in edition flera gånger.
    Kanske finns ytterligare förenkling?
*/

--NEW SOLUTION
UPDATE Edition
SET Translations =
        XMLQUERY('
		transform
		copy $res := $t
		modify do replace value of
			$res//Translation[@Language="French"]/@Publisher with "ABC International"
		return $res'
                 PASSING Translations as "t"
            )
WHERE edition.book =
      (SELECT Book.id
       FROM book
       WHERE title = 'Archeology in Egypt')
  AND edition.year = 1999

/*OUTPUT
 TITLE                        	YEAR 	TRANSLATIONS
 ---------------------------- 	---- 	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Archeology in Egypt         	1999	<Translations><Translation Language="French" Publisher="ABC International" Price="320"/><Translation Language="Italian" Publisher="KLC" Price="320"/><Translation Language="Turkish" Publisher="Turk And Turk" Price="300"/><Translation Language="Spanish" Price="300"/></Translations>
*/
