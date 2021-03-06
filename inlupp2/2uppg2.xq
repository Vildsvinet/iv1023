(: Inlupp 2.2 Ta fram författare per genre :)

element Resultat{
    for $g in distinct-values(//Book/@Genre)
    order by $g
    return(
        <Genre Namn="{$g}">{
            for $a in //Author[../@Genre=$g][not(@Name=preceding::Author/@Name and ../@Genre=preceding::Author/../@Genre)]
            let $n := $a/@Name
            order by $n
            return <Författare>{$n}</Författare>
        }
        </Genre>
    )
}

(:Output
<Resultat>
    <Genre Namn="Educational">
        <Författare Name="Alan Griff"/>
        <Författare Name="Alicia Bing"/>
        <Författare Name="Andreas Shultz"/>
        <Författare Name="Antje Liedderman"/>
        <Författare Name="Arnie Bastoft"/>
        <Författare Name="Auna Gonzales Perre"/>
        <Författare Name="Carl George"/>
        <Författare Name="Celine Biceau"/>
        <Författare Name="Chris Ryan"/>
        <Författare Name="Christina Ohlsen"/>
        <Författare Name="Chuck Morrisson"/>
        <Författare Name="Kay Morrisson"/>
        <Författare Name="Kostas Andrianos"/>
        <Författare Name="Lilian Carrera"/>
        <Författare Name="Linda Evans"/>
        <Författare Name="Marty Faust"/>
        <Författare Name="Meg Gilmand"/>
        <Författare Name="Mimi Pappas"/>
        <Författare Name="Peter Feldon"/>
        <Författare Name="Samuel Davies"/>
    </Genre>
    <Genre Namn="Novel">
        <Författare Name="James Patterson"/>
        <Författare Name="Leslie Brenner"/>
        <Författare Name="Marie Franksson"/>
        <Författare Name="Peter de Jonge"/>
    </Genre>
    <Genre Namn="Science Fiction">
        <Författare Name="Carl Sagan"/>
        <Författare Name="Leslie Brenner"/>
    </Genre>
    <Genre Namn="Thriller">
        <Författare Name="Jakob Hanson"/>
        <Författare Name="John Craft"/>
    </Genre>
</Resultat>
:)
