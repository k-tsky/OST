#let glossary_state = state("glossary", ())
#let project_lang_state = state("project-lang", "en")

#let accent_color = rgb("#b43b72")
#let border_color = rgb("#ead0dc")
#let soft_fill = rgb("#fff7fb")

#let language_labels(lang) = if lang == "de" {
  (
    subtitle: "Zusammenfassung",
    authors: "Autorinnen und Autoren",
    date: "Datum",
    page: "Seite",
    toc: "Inhaltsverzeichnis",
    glossary: (
      title: "Glossar",
      term: "Begriff",
      location: "Fundstelle",
      page: "Seite",
    ),
  )
} else {
  (
    subtitle: "Summary",
    authors: "Authors",
    date: "Date",
    page: "Page",
    toc: "Table of Contents",
    glossary: (
      title: "Glossary",
      term: "Term",
      location: "Location",
      page: "page",
    ),
  )
}

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

  let labels = language_labels(lang)
  let shown-subtitle = if subtitle == none {
    labels.subtitle
  } else {
    subtitle
  }

  // Base text settings
  set text(font: "Calibri", size: 11pt, lang: lang, region: region)
  project_lang_state.update(lang)

  // Numbered headings
  set heading(numbering: "1.")

  // Table styling
  set table(
    inset: 7pt,
    stroke: border_color,
    fill: (_, y) => if y == 0 { accent_color },
  )
  show table.cell.where(y: 0): it => {
    set text(fill: white, weight: 700)
    it
  }

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
          align(right, [#labels.page #counter(page).display()])
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

      #text(size: 12pt, weight: 600, labels.authors)
      #v(0.5em)
      #for author in author-list [
        #author \
      ]

      #v(2cm)

      #text(size: 12pt, weight: 600, labels.date)
      #v(0.5em)
      #date
    ]

    pagebreak()
  }

  // ----------------
  // Table of contents
  // ----------------
  heading(level: 1, numbering: none, outlined: false)[#labels.toc]
  outline(title: none)

  pagebreak()

  // ----------------
  // Body
  // ----------------
  set par(justify: true)
  body
}

// Optional glossary
#let glossary-term(term) = {
  context {
    let location = here()
    glossary_state.update(entries => entries + ((term: term, location: location),))
    text(weight: 700, term)
  }
}

#let glossary(lang: none, title: none) = {
  context {
    let glossary_lang = if lang == none { project_lang_state.final() } else { lang }
    let all_labels = language_labels(glossary_lang)
    let labels = all_labels.glossary
    let shown-title = if title == none { labels.title } else { title }
    let entries = glossary_state.final()

    heading(level: 1, numbering: none)[#shown-title]
    table(
      columns: (1.2fr, 2fr),
      align: (left, left),
      inset: 7pt,
      stroke: border_color,
      fill: (_, y) => if y == 0 { accent_color } else { soft_fill },
      table.header(
        [#text(fill: white, weight: 700, labels.term)],
        [#text(fill: white, weight: 700, labels.location)],
      ),
      ..entries.map(entry => (
        [#text(weight: 700, entry.term)],
        [#link(entry.location)[#labels.page #counter(page).at(entry.location).first()]],
      )).flatten(),
    )
  }
}
