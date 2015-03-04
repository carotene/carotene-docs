#lang pollen

body {
    color: black;
}

h1, h2, h3, h4 {
    color: black;
}

a, a:hover, a:visited {
    color: #0067A5;
}

a, a:visited {
    color: #0067A5;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

p {
    margin-bottom: 1.5em;
}


.code {
    overflow: auto;
}

.author {
    display: block;
    text-align: center;
    font-family: "Gentium Basic",Gentium,Palatino,Georgia,serif;
    letter-spacing: 1px;
    font-size: 80%;
    margin-bottom: 2em;
}
.chapter {
    display: block;
    text-align: center;
    font-family: "Gentium Basic",Gentium,Palatino,Georgia,serif;
    letter-spacing: 1px;
    margin-bottom: 0.1em;
    padding-bottom: 0.3em;
    border-bottom: 4px double #ccc;
    margin-left: 25%;
    margin-right: 25%;
}

.title {
    border-top: 0.05em solid gray;
    font-size: 180%;
}

html {
    height: 100%;
}

div.content {
    display: block;
    padding: 3rem 0 10rem 0;
}

body > * {
    margin-left: 14.5rem;
    margin-right: 2.5rem;
}


body {
    padding: 0rem 0em 0rem 0em;
    margin-left:auto;
    margin-right:auto;
    width:100%;
    max-width:1200px;
    min-width:520px;
    min-height: 100%;
    text-rendering: optimizeLegibility;
    border-top: 0px solid black;
    border-bottom: 0px solid black;
    position: relative; 
}

aside {
    font-size: 0.80rem;
    line-height: 1.40;
    color: black;
    display: block;
    float: left;
    margin-left: -14rem;
    left: 0rem;
    width: 13rem;
    text-align: right;
    list-style-type: none;
    clear:both;
}

.separator {
    clear: both;
    height: 1rem;
}

par {
    display: block;
}

.linenodiv {
    visibility: hidden;
}

code {
    background-color: #f8f8f8;
    color: #E55B3C;
}

ul br {
    display: none;
}
