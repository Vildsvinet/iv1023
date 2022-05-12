(: Inlupp 2.2 Ta fram författare per genre :)

element Resultat{
    for $g in distinct-values(//Book/@Genre)
    return <Genre Namn="{$g}">{
        for $a in //Author
        let $n := $a/@Name
        where $a/../@Genre = $g
        return <Författare>{distinct-values($a/@Name)}</Författare>
    }
    </Genre>
}

(:Output:)
(:
<Resultat>
    <Genre Namn="Thriller">
        <Författare>John Craft</Författare>
        <Författare>Jakob Hanson</Författare>
    </Genre>
    <Genre Namn="Educational">
        <Författare>Arnie Bastoft</Författare>
        <Författare>Meg Gilmand</Författare>
        <Författare>Chris Ryan</Författare>
        <Författare>Alan Griff</Författare>
        <Författare>Marty Faust</Författare>
        <Författare>Celine Biceau</Författare>
        <Författare>Sam Davis</Författare>
        <Författare>Mimi Pappas</Författare>
        <Författare>Carl George</Författare>
        <Författare>Peter Feldon</Författare>
        <Författare>Lilian Carrera</Författare>
        <Författare>Auna Gonzales Perre</Författare>
        <Författare>Kostas Andrianos</Författare>
        <Författare>Andreas Shultz</Författare>
        <Författare>Antje Liedderman</Författare>
        <Författare>Christina Ohlsen</Författare>
        <Författare>Alicia Bing</Författare>
        <Författare>Linda Evans</Författare>
        <Författare>Chuck Morrisson</Författare>
        <Författare>Kay Morrisson</Författare>
    </Genre>
    <Genre Namn="Science Fiction">
        <Författare>Carl Sagan</Författare>
        <Författare>Leslie Brenner</Författare>
    </Genre>
    <Genre Namn="Novel">
        <Författare>Leslie Brenner</Författare>
        <Författare>Marie Franksson</Författare>
        <Författare>James Patterson</Författare>
        <Författare>Peter de Jonge</Författare>
    </Genre>
</Resultat>:)
