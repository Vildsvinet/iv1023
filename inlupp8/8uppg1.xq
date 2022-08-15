(:OBSOBS OBSOLET DÅLIG SE v2:)

element Länder{
    for $l in distinct-values(//Country)

    return(
        <Land namn = "{$l}">
            {
                for $p in //Publisher[.//Country=$l]
                return <Förlag namn="{$p/@Name}"/>
            }
            {
                for $a in //Author[@Country=$l]
                return <Författare namn="{$a/@Name}"/>
            }
        </Land>
    )
}

(:OUTPUT:
<Länder>
  <Land namn="Germany">
    <Förlag namn="ABC International"/>
    <Förlag namn="Deutche Ferlage"/>
    <Författare namn="Antje Liedderman"/>
  </Land>
  <Land namn="France">
    <Förlag namn="Addison"/>
    <Författare namn="Chris Ryan"/>
    <Författare namn="Carl George"/>
    <Författare namn="Franc Desteille"/>
  </Land>
  <Land namn="Italy">
    <Förlag namn="Aurora Publ."/>
  </Land>
  <Land namn="England">
    <Förlag namn="Benton Inc"/>
    <Förlag namn="McManus Publishing"/>
    <Författare namn="John Craft"/>
    <Författare namn="Peter Feldon"/>
    <Författare namn="Chuck Morrisson"/>
    <Författare namn="Kay Morrisson"/>
  </Land>
  <Land namn="Sweden">
    <Förlag namn="Bästa Bok"/>
    <Förlag namn="KLC"/>
    <Förlag namn="SCB"/>
    <Författare namn="Marie Franksson"/>
    <Författare namn="Jakob Hanson"/>
    <Författare namn="Marie Franksson"/>
  </Land>
  <Land namn="Belgium">
    <Förlag namn="EU Publishing"/>
    <Författare namn="Pierre Zargone"/>
    <Författare namn="Alicia Bing"/>
  </Land>
  <Land namn="Austria">
    <Förlag namn="Kingsly"/>
    <Författare namn="Arnie Bastoft"/>
    <Författare namn="Andreas Shultz"/>
  </Land>
  <Land namn="Scotland">
    <Förlag namn="Pels And Jafs"/>
  </Land>
  <Land namn="Russia">
    <Förlag namn="RP"/>
  </Land>
  <Land namn="China">
    <Förlag namn="Shou-Ling"/>
  </Land>
  <Land namn="Finland">
    <Förlag namn="Suomi Bookkii"/>
  </Land>
  <Land namn="Turkey">
    <Förlag namn="Turk And Turk"/>
  </Land>
</Länder>

:)