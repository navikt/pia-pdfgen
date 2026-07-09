// pdfgenrs tilbyr JSON fra POST på denne pathen
// bruker path relative to the project root
// Se: https://typst.app/docs/reference/syntax/#paths

#let data = json("/data/pia/behovsvurdering.json")

#let virksomhet = data.virksomhet
#let sak = data.sak
#let samarbeid = data.samarbeid
#let innhold = data.innhold
#let spørsmål-med-svar-per-tema = innhold.spørsmålMedSvarPerTema
#let dokument-tittel = "Behovsvurdering" + "-" + samarbeid.navn + "-" + str(samarbeid.id)
#let første-side-tittel = "Gjennomført behovsvurdering"


// -- Hjelpemetoder
#let iso-til-nor-datetime(iso-tidsstempel) = {
    iso-tidsstempel.slice(8, 10) + "." // DD
    iso-tidsstempel.slice(5, 7) + "." // MM
    iso-tidsstempel.slice(0, 4) + " " // YYYY
    iso-tidsstempel.slice(11, 13) + ":" // HH:
    iso-tidsstempel.slice(14, 16) // mm
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
        ..generell-info-rader.flatten(),
    )
}

#let svar-tabell(svar-liste) = {
    table(
        columns: (1fr, 1fr),
        stroke: 1.5pt + rgb("#8c8c8c"),
        inset: (x: 6pt, y: 8pt),
        align: (left + horizon, left + horizon),
        table.header(
            [#text(weight: "bold")[Svaralternativ]],
            [#text(weight: "bold")[Antall svar]],
        ),

        ..svar-liste
            .map(svar => (
                [#svar.tekst],
                [#str(svar.antallSvar)]
            ))
            .flatten(),
    )
}

#let spørsmål-med-svar-tabell(spørsmål) = {
    block(
        breakable: false,
    )[
        === #spørsmål.tekst

        #v(10pt)

        Antall deltakere som har svart: #spørsmål.antallDeltakereSomHarSvart

        #v(10pt)

        #svar-tabell(spørsmål.svarListe)
    ]
}

#let spørsmål-med-svar-per-tema-tabell(tema) = [
    #pagebreak()

   == #tema.navn

    #v(16pt)

    #for spørsmål in tema.spørsmålMedSvar [
        #spørsmål-med-svar-tabell(spørsmål)

        #v(28pt)
    ]
]

// -- Metadata om selve pdf-dokumentet
#set document(
    title: dokument-tittel,
    author: "pia-pdf",
    description: første-side-tittel,
)

// -- Global konfig for page properties, sideoppsett, skriftstørrelse etc.
#set text(lang: "no")

#set text(
    font: ("Source Sans 3", "Noto Color Emoji"),
    size: 12pt,
    fill: rgb("#3a3832")
)

#set heading(numbering: none)

#show heading.where(level: 1): set text(size: 26pt, weight: "bold") // Gjennomført behovsvurdering
#show heading.where(level: 2): set text(size: 18pt, weight: "bold") // Temanavn tittel
#show heading.where(level: 3): set text(size: 14pt, weight: "bold") // Spørsmålstekst

#set par(
    leading: 0.62em,
    linebreaks: "optimized",
)

#set page(
    paper: "a4",
    flipped: false, // portrait

    margin: (
        top: 10mm,
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

#v(12mm)

#grid(
    columns: (auto, 1fr),
    column-gutter: 10pt,
    align: (left, left),

    [#text(weight: "bold")[Enhet:]],
    [#sak.navenhet.enhetsnavn],
)

#v(18mm)

#generell-info-tabell

#v(12mm)

= #første-side-tittel

#v(8mm)

Gjennomført: #iso-til-nor-datetime(innhold.fullførtTidspunkt)

#v(4mm)

Resultatene fra behovsvurderingen er sortert på tema og spørsmål.

#v(6mm)

For å ivareta anonymitet må det være minst tre svar per spørsmål. Ved mindre enn tre svar skjules \ 
antall deltakere og resultatene settes til null.

// -- Resultatsider 
#set page(
    margin: (top: 20mm, left: 10mm, right: 10mm, bottom: 18mm)
)
#for tema in spørsmål-med-svar-per-tema [
    #spørsmål-med-svar-per-tema-tabell(tema)
]