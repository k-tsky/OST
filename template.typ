#let project(
  title: "",
  subtitle: none,
  authors: (),
  date: datetime.today().display("[day] [month repr:long] [year]"),
  lang: "en",
  region: "US",
  body,
) = {
  let author-list = if type(authors) == str {
    (authors,)
  } else {
    authors
  }

  let labels = if lang == "de" {
    (
      subtitle: "Zusammenfassung",
      authors: "Autorinnen und Autoren",
      date: "Datum",
      page: "Seite",
      toc: "Inhaltsverzeichnis",
    )
  } else {
    (
      subtitle: "Summary",
      authors: "Authors",
      date: "Date",
      page: "Page",
      toc: "Table of Contents",
    )
  }
  let shown-subtitle = if subtitle == none {
    labels.subtitle
  } else {
    subtitle
  }
  let authors-label = labels.authors
  let date-label = labels.date
  let page-label = labels.page
  let toc-label = labels.toc

  // Base text settings
  set text(font: "Calibri", size: 11pt, lang: lang, region: region)

  // Numbered headings
  set heading(numbering: "1.")

  // Global page settings
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(9pt, gray)
        #grid(
          columns: (1fr, 1fr),
          align(left, title),
          align(right, author-list.join(", "))
        )
        #v(-0.5em)
        #line(length: 100%, stroke: 0.5pt + gray)
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
        #set text(8pt, gray)
        #line(length: 100%, stroke: 0.5pt + gray)
        #v(-0.5em)
        #grid(
          columns: (1fr, 1fr),
          align(left, date),
          align(right, [#page-label #counter(page).display()])
        )
      ]
    }
  )

  // ----------------
  // Title page
  // ----------------
  if title != "" {
    align(center + horizon)[
      #v(6cm)
      #text(size: 22pt, weight: 700, title)

      #if shown-subtitle != "" [
        #v(1em)
        #text(size: 14pt, fill: gray, shown-subtitle)
      ]

      #v(3cm)

      #text(size: 12pt, weight: 600, authors-label)
      #v(0.5em)
      #for author in author-list [
        #author \
      ]

      #v(2cm)

      #text(size: 12pt, weight: 600, date-label)
      #v(0.5em)
      #date
    ]

    pagebreak()
  }

  // ----------------
  // Table of contents
  // ----------------
  heading(level: 1, numbering: none, outlined: false)[#toc-label]
  outline(title: none)

  pagebreak()

  // ----------------
  // Body
  // ----------------
  set par(justify: true)
  body
}
