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