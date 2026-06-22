#let data = json("/data/pia/samarbeidsplan.json")

#let virksomhet = data.virksomhet
#let sak = data.sak
#let samarbeid = data.samarbeid
#let innhold = data.innhold
#let temaer = innhold.temaer
#let dokument-tittel = "Samarbeidsplan" + "-" + samarbeid.navn + "-" + str(samarbeid.id)
#let første-side-tittel = "Gjennomført evaluering"


// -- Hjelpemetoder
#let iso-til-nor-datetime(iso-tidsstempel) = {
    iso-tidsstempel.slice(8, 10) + "." // DD
    iso-tidsstempel.slice(5, 7) + "." // MM
    iso-tidsstempel.slice(0, 4) + " " // YYYY
    iso-tidsstempel.slice(11, 13) + ":" // HH:
    iso-tidsstempel.slice(14, 16) // mm
}

#let iso-til-nor-date(iso-tidsstempel) = {
    iso-tidsstempel.slice(8, 10) + "." // DD
    iso-tidsstempel.slice(5, 7) + "." // MM
    iso-tidsstempel.slice(0, 4) + " " // YYYY
}

#let periode(undertema) = {
  if undertema.startDato == none and undertema.sluttDato == none {
    " - "
  } else if undertema.startDato != none and undertema.sluttDato != none {
    iso-til-nor-date(undertema.startDato) + " - " + iso-til-nor-date(undertema.sluttDato)
  } else if undertema.startDato != none {
    iso-til-nor-date(undertema.startDato) + " - "
  } else {
    " - "
  }
}

#let generell-info-tabell = {

    let info-rad(key, value) = (
        table.cell(
            inset: (left: 0pt, right: 10pt, top: 1.5pt, bottom: 1.5pt),
            )[
                #text(weight: "bold")[#key]
            ],
        
        table.cell(
            inset: (left: 0pt, right: 0pt, top: 1.5pt, bottom: 1.5pt),
        )[ 
            #value
        ],
    )

    let generell-info-rader = (
        info-rad("Virksomhet:", virksomhet.navn,),
        info-rad("Organisasjonsnummer:", virksomhet.orgnummer),
        info-rad("Saksnummer:", sak.saksnummer),
        info-rad("Samarbeidsnavn:", samarbeid.navn),
        info-rad("Samarbeid-Id:", samarbeid.id),
        info-rad("Referanse-id:", data.referanseId),
        info-rad("Publisert:", iso-til-nor-datetime(data.publiseringsdato)),
    )

    table(
        columns: (auto, 1fr),
        stroke: none,
        row-gutter: 0.75em,
        align: (left, left),
        //gutter: 3pt,
        ..generell-info-rader.flatten(),
    )
}

#let undertema-tabell(undertema) = {
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: rgb("8c8c8c"),
    inset: (x: 10pt, y: 6pt),
    align: (left, left),

    table.header(
      [#text(weight: "bold")[Innhold]],
      [#text(weight: "bold")[Varighet]],
      [#text(weight: "bold")[Status]],
    ),

    [#undertema.navn],
    [#periode(undertema)],
    [#undertema.status],

    table.cell(colspan: 3)[
      #text(weight: "bold")[Mål:] #undertema.målsetning
    ],
  )
}

#let tema-blokk(tema) = [
  #if tema.inkludert [
    #pagebreak()

    = #tema.navn

    #v(15pt)

    #for undertema in tema.undertemaer [
      #if undertema.status != none [
        #block(
          breakable: false,
        )[
          #undertema-tabell(undertema)
        ]
        #v(30pt)
      ]
    ]
  ]
]



// -- METADATA OM SELVE PDF-DOKUMENTET 
#set document(
    title: dokument-tittel,
    author: "pia-pdf",
    description: første-side-tittel,
)

// -- GLOBAL KONFIG FOR PAGE PROPERTIES, SIDEOPPSETT, SKRIFTSTØRRELSE etc.
#set text(lang:"no")

#set text(
    font: ("Source Sans 3", "Noto Color Emoji"),
    size: 10pt,
    fill: rgb("3a3832")
)

#set par(
    leading: 0.62em,
)

#set page(
    paper: "a4",
    flipped: false, // portrait

    margin: (
        top: 20mm,
        left: 10mm,
        right: 10mm,
        bottom: 18mm
    ),

    footer: context [
        #set text(size: 9pt)
        #virksomhet.navn (#virksomhet.orgnummer)
        #h(1fr)
        #counter(page).display(
            (side, total) => [side #side av #total], 
            both: true,
        )
    ]   
)

// -- Første side

#pdf.artifact(
  image("/resources/navlogo.png", alt: none, width: 40mm)
)

#v(20mm)

#grid(
  columns: (auto, 1fr),
  column-gutter: 10pt,
  align: (left, left),

  [#text(weight: "bold")[Enhet:]],
  [#sak.navenhet.enhetsnavn],
)

#v(29mm)

#generell-info-tabell

#v(24mm)

#text(size: 26pt, weight: "bold")[Samarbeidsplan]

#v(12mm)

Sist endret: #iso-til-nor-datetime(innhold.sistEndret)

#v(8mm)

Samarbeidsplanen mellom Nav og virksomheten viser prioriterte temaer og hvor lenge man skal jobbe
med de ulike undertemaene. Hvert undertema har et definert mål, varighet og status. Planen kan
endres helt frem til samarbeidet med virksomheten avsluttes.

// Temaer og undertemaer

#for tema in temaer [
  #tema-blokk(tema)
]