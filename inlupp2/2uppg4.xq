(:Uppgift 2.4 Vilka böckers översättningar har publicerats av varje förlag?:)

element Resultat{
    for $pub in //Publisher
    let $pname := $pub/@Name
    order by $pname
    return(
        element Förlag{
            attribute Namn{$pname},
            attribute Land{$pub//Country},

            for $bok in //Book
            where $bok//Translation/@Publisher = $pname
            return(
                element Bok{
                    attribute Titel{$bok/@Title},
                    $bok/@Genre
                }
            )
        }
    )
}

(:
Output
<Resultat>
    <Förlag Namn="ABC International" Land="Germany">
        <Bok Titel="Music Now and Before" Genre="Educational"/>
        <Bok Titel="Musical Instruments" Genre="Educational"/>
        <Bok Titel="Oceans on Earth" Genre="Educational"/>
        <Bok Titel="Oceanography for Dummies" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="Addison" Land="France">
        <Bok Titel="Misty Nights" Genre="Thriller"/>
    </Förlag>
    <Förlag Namn="Aurora Publ." Land="Italy">
        <Bok Titel="Le chateau de mon pere" Genre=""/>
    </Förlag>
    <Förlag Namn="Benton Inc" Land="England">
        <Bok Titel="Le chateau de mon pere" Genre=""/>
    </Förlag>
    <Förlag Namn="Bästa Bok" Land="Sweden">
        <Bok Titel="The Fourth Star" Genre="Science Fiction"/>
        <Bok Titel="The Fifth Star" Genre="Novel"/>
    </Förlag>
    <Förlag Namn="Deutche Ferlage" Land="Germany"/>
    <Förlag Namn="EU Publishing" Land="Belgium">
        <Bok Titel="European History" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="KLC" Land="Sweden">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
        <Bok Titel="Music Now and Before" Genre="Educational"/>
        <Bok Titel="Encore une fois" Genre=""/>
    </Förlag>
    <Förlag Namn="Kingsly" Land="Austria">
        <Bok Titel="Misty Nights" Genre="Thriller"/>
    </Förlag>
    <Förlag Namn="McManus Publishing" Land="England"/>
    <Förlag Namn="Pels And Jafs" Land="Scotland">
        <Bok Titel="Encore une fois" Genre=""/>
    </Förlag>
    <Förlag Namn="RP" Land="Russia">
        <Bok Titel="Contact" Genre="Science Fiction"/>
    </Förlag>
    <Förlag Namn="SCB" Land="Sweden">
        <Bok Titel="Contact" Genre="Science Fiction"/>
    </Förlag>
    <Förlag Namn="Shou-Ling" Land="China">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
    </Förlag>
    <Förlag Namn="Suomi Bookkii" Land="Finland">
        <Bok Titel="Midsommar i Lund" Genre="Novel"/>
    </Förlag>
    <Förlag Namn="Turk And Turk" Land="Turkey">
        <Bok Titel="Archeology in Egypt" Genre="Educational"/>
    </Förlag>
</Resultat>
:)
