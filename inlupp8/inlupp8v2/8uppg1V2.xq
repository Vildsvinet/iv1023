element Länder{
    for $l in distinct-values(//Publisher//Country union //Book/Author/@Country)
    order by $l
    return(
        <Land namn = "{$l}">
            {
                for $p in //Publisher[.//Country=$l]
                return <Förlag namn="{$p/@Name}"/>
            }
            {
                for $a in //Author[@Country=$l and not(@Name=preceding::Author/@Name)]
                return <Författare namn="{$a/@Name}"/>
            }
        </Land>
    )
}

(:<Länder>
  <Land namn="Australia">
    <Författare namn="Meg Gilmand"/>
  </Land>
  <Land namn="Austria">
    <Förlag namn="Kingsly"/>
    <Författare namn="Arnie Bastoft"/>
    <Författare namn="Andreas Shultz"/>
  </Land>
  <Land namn="Belgium">
    <Förlag namn="EU Publishing"/>
    <Författare namn="Pierre Zargone"/>
    <Författare namn="Alicia Bing"/>
  </Land>
  <Land namn="Canada">
    <Författare namn="Celine Biceau"/>
  </Land>
  <Land namn="China">
    <Förlag namn="Shou-Ling"/>
  </Land>
  <Land namn="England">
    <Förlag namn="Benton Inc"/>
    <Förlag namn="McManus Publishing"/>
    <Författare namn="John Craft"/>
    <Författare namn="Peter Feldon"/>
    <Författare namn="Chuck Morrisson"/>
    <Författare namn="Kay Morrisson"/>
  </Land>
  <Land namn="Finland">
    <Förlag namn="Suomi Bookkii"/>
  </Land>
  <Land namn="France">
    <Förlag namn="Addison"/>
    <Författare namn="Chris Ryan"/>
    <Författare namn="Carl George"/>
    <Författare namn="Franc Desteille"/>
  </Land>
  <Land namn="Germany">
    <Förlag namn="ABC International"/>
    <Förlag namn="Deutche Ferlage"/>
    <Författare namn="Antje Liedderman"/>
  </Land>
  <Land namn="Greece">
    <Författare namn="Kostas Andrianos"/>
  </Land>
  <Land namn="Italy">
    <Förlag namn="Aurora Publ."/>
  </Land>
  <Land namn="Mexico">
    <Författare namn="Samuel Davies"/>
  </Land>
  <Land namn="Norway">
    <Författare namn="Christina Ohlsen"/>
  </Land>
  <Land namn="Portugal">
    <Författare namn="Auna Gonzales Perre"/>
  </Land>
  <Land namn="Russia">
    <Förlag namn="RP"/>
  </Land>
  <Land namn="Scotland">
    <Förlag namn="Pels And Jafs"/>
  </Land>
  <Land namn="Spain">
    <Författare namn="Lilian Carrera"/>
  </Land>
  <Land namn="Sweden">
    <Förlag namn="Bästa Bok"/>
    <Förlag namn="KLC"/>
    <Förlag namn="SCB"/>
    <Författare namn="Marie Franksson"/>
    <Författare namn="Jakob Hanson"/>
  </Land>
  <Land namn="Turkey">
    <Förlag namn="Turk And Turk"/>
  </Land>
  <Land namn="USA">
    <Författare namn="Alan Griff"/>
    <Författare namn="Marty Faust"/>
    <Författare namn="Carl Sagan"/>
    <Författare namn="Leslie Brenner"/>
    <Författare namn="Mimi Pappas"/>
    <Författare namn="Linda Evans"/>
    <Författare namn="James Patterson"/>
    <Författare namn="Peter de Jonge"/>
  </Land>
</Länder>:)