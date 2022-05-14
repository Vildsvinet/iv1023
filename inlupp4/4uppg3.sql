--Vilka böcker har varje författare skrivit?

SELECT XMLELEMENT(NAME "Alla", XMLAGG(hold))
FROM(
    SELECT XMLELEMENT(
        NAME "Författare",
        XMLATTRIBUTES(Author.name as "Namn", tt.Land as "Land"),
        XMLAGG(
            XMLELEMENT(
               NAME "Bok",
               XMLATTRIBUTES(Book.title as "Titel", Book.originallanguage as "OrginalSpråk", Book.genre as "Genre")
            )
        )
    ) AS hold
    FROM Author, Authorship, Book, XMLTABLE('$t//Country'
        PASSING Info AS "t"
        COLUMNS Land VARCHAR(30) PATH '.') AS tt
    WHERE  book.id = authorship.book AND author.id = authorship.author
    GROUP BY Author.name, tt.Land
)


/*OUTPUT
<Alla>
    <Författare Namn="Alan Griff" Land="USA">
        <Bok Titel="Database Systems in Practice" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Alicia Bing" Land="Belgium">
        <Bok Titel="Musical Instruments" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Andreas Shultz" Land="Austria">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Antje Liedderman" Land="Germany">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Arnie Bastoft" Land="Austria">
        <Bok Titel="Archeology in Egypt" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Auna Gonzales Perre" Land="Portugal">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Carl George" Land="France">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Carl Sagan" Land="USA">
        <Bok Titel="Contact" OrginalSpråk="English" Genre="Science Fiction"/>
    </Författare>
    <Författare Namn="Celine Biceau" Land="Canada">
        <Bok Titel="Database Systems in Practice" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Chris Ryan" Land="France">
        <Bok Titel="Archeology in Egypt" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Christina Ohlsen" Land="Norway">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Chuck Morrisson" Land="England">
        <Bok Titel="Oceans on Earth" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Franc Desteille" Land="France">
        <Bok Titel="Le chateau de mon pere" OrginalSpråk="French"/>
    </Författare>
    <Författare Namn="Jakob Hanson" Land="Sweden">
        <Bok Titel="Dödliga Data" OrginalSpråk="Swedish" Genre="Thriller"/>
    </Författare>
    <Författare Namn="James Patterson" Land="USA">
        <Bok Titel="The Beach House" OrginalSpråk="English" Genre="Novel"/>
    </Författare>
    <Författare Namn="John Craft" Land="England">
        <Bok Titel="Misty Nights" OrginalSpråk="English" Genre="Thriller"/>
    </Författare>
    <Författare Namn="Kay Morrisson" Land="England">
        <Bok Titel="Oceans on Earth" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Kostas Andrianos" Land="Greece">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Leslie Brenner" Land="USA">
        <Bok Titel="The Fourth Star" OrginalSpråk="English" Genre="Science Fiction"/>
    </Författare>
    <Författare Namn="Lilian Carrera" Land="Spain">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Linda Evans" Land="USA">
        <Bok Titel="Oceans on Earth" OrginalSpråk="English" Genre="Educational"/>
        <Bok Titel="Oceanography for Dummies" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Marie Franksson" Land="Sweden">
        <Bok Titel="Våren vid sjön" OrginalSpråk="Swedish" Genre="Novel"/>
        <Bok Titel="Midsommar i Lund" OrginalSpråk="Swedish" Genre="Novel"/>
    </Författare>
    <Författare Namn="Marty Faust" Land="USA">
        <Bok Titel="Database Systems in Practice" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Meg Gilmand" Land="Australia">
        <Bok Titel="Archeology in Egypt" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Mimi Pappas" Land="USA">
        <Bok Titel="Music Now and Before" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Peter de Jonge" Land="USA">
        <Bok Titel="The Beach House" OrginalSpråk="English" Genre="Novel"/>
    </Författare>
    <Författare Namn="Peter Feldon" Land="England">
        <Bok Titel="European History" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
    <Författare Namn="Pierre Zargone" Land="Belgium">
        <Bok Titel="Encore une fois" OrginalSpråk="French"/>
    </Författare>
    <Författare Namn="Sam Davis" Land="Mexiko">
        <Bok Titel="Music Now and Before" OrginalSpråk="English" Genre="Educational"/>
        <Bok Titel="Musical Instruments" OrginalSpråk="English" Genre="Educational"/>
    </Författare>
</Alla>


  */