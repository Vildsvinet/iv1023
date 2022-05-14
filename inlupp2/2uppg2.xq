(: Inlupp 2.2 Ta fram författare per genre :)

element Resultat{
    for $g in distinct-values(//Book/@Genre)
    order by $g
    return( 
      <Genre Namn="{$g}">{
        for $a in //Author
        let $n := $a/@Name
        where $a/../@Genre = $g
        order by $n
        return <Författare>{$a/@Name}</Författare>
        }
      </Genre>
    )
}

(:Output:)
(:
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
    <Författare Name="Linda Evans"/>
    <Författare Name="Marty Faust"/>
    <Författare Name="Meg Gilmand"/>
    <Författare Name="Mimi Pappas"/>
    <Författare Name="Peter Feldon"/>
    <Författare Name="Samuel Davies"/>
    <Författare Name="Samuel Davies"/>
  </Genre>
  <Genre Namn="Novel">
    <Författare Name="James Patterson"/>
    <Författare Name="Leslie Brenner"/>
    <Författare Name="Marie Franksson"/>
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
