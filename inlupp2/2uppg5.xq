(: Uppg 2.5 Den senaste upplagan (edition) av boken "Encore une fois" har översatts till norska och
kostar 200 kronor. Den är utgiven av förlaget KLC. Gör ändringen i databasen! :)

for $ed in //Book[@Title = "Encore une fois"]/Edition
where $ed/@Year = max(//Book[@Title = "Encore une fois"]/Edition/@Year)
return
    insert node
    <Translation Language="Norwegian" Publisher="KLC" Price="200"/>
    as last into $ed

(:Output extract:)
(:
<Book Title="Encore une fois" OriginalLanguage="French">
    <Author Name="Pierre Zargone" Email="zargone@fans.be" YearOfBirth="1968" Country="Belgium"/>
    <Edition Year="1997" Price="120">
        <Translation Language="English" Price="120"/>
        <Translation Language="Russian" Price="110"/>
    </Edition>
    <Edition Year="2001" Price="150">
        <Translation Language="English" Publisher="Pels And Jafs" Price="180"/>
        <Translation Language="Russian" Price="140"/>
        <Translation Language="Norwegian" Publisher="KLC" Price="200"/>
    </Edition>
</Book>:)
