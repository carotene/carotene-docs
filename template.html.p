<html>
    <head>
        <meta charset="UTF-8"/>
        <title>◊select['h1 doc] - Erlang by immersion</title>
        <link href='http://fonts.googleapis.com/css?family=Gentium+Basic:400,700,400italic|Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Old+Standard+TT' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" type="text/css" media="all" href="styles/typography.css" />
        <link rel="stylesheet" type="text/css" media="all" href="styles/stylesheet.css" />
    </head>
    <body>
        <div class="content">
            ◊->html{◊doc}
◊(define prev-page (previous here))
◊when/block[prev-page]{
<div id="prev">← <a href="◊|prev-page|">◊(select 'h1 prev-page)</a></div>}
◊(define next-page (next here))
◊when/block[next-page]{
<div id="next"><a href="◊|next-page|">◊(select 'h1 next-page)</a> →</div>}
            <div class="bottom"> </div>
        </div>
    </body>
</html>
