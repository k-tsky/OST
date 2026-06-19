#let glossary_state = state("glossary", ())
#let project_lang_state = state("project-lang", "en")

#let mist_lavender = rgb("#E6E6FA")
#let dusty_lilac = rgb("#D8BFD8")
#let orchid_mist = rgb("#DDA0DD")
#let violet_haze = rgb("#9370DB")
#let electric_violet = rgb("#8A2BE2")
#let deep_plum = rgb("#3F1F5F")

#let text_color = black
#let accent_color = text_color
#let decorative_color = violet_haze
#let border_color = violet_haze
#let soft_fill = mist_lavender
#let muted_color = text_color
#let heading_color = text_color
#let quiet_line_color = violet_haze
#let header_footer_color = text_color.transparentize(35%)

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
  show link: set text(fill: text_color)
  project_lang_state.update(lang)

  // Numbered headings
  set heading(numbering: "1.")
  show heading: set text(fill: heading_color)
  show heading.where(level: 1): set text(size: 17pt, weight: 700, fill: heading_color)
  show heading.where(level: 2): set text(size: 13.5pt, weight: 700, fill: heading_color)
  show heading.where(level: 3): set text(size: 11.5pt, weight: 700, fill: accent_color)

  // Table styling
  set table(
    inset: 6.5pt,
    stroke: 0.45pt + border_color,
    fill: (_, y) => if y == 0 { soft_fill },
  )
  show table.cell.where(y: 0): it => {
    set text(fill: heading_color, weight: 700)
    it
  }

  // Global page settings
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(9pt, header_footer_color)
        #grid(
          columns: (1fr, 1fr),
          align(left, title),
          align(right, author-list.join(", "))
        )
        #v(-0.5em)
        #line(length: 100%, stroke: 0.45pt + header_footer_color)
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
        #set text(8pt, header_footer_color)
        #line(length: 100%, stroke: 0.45pt + header_footer_color)
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
        #text(size: 14pt, shown-subtitle)
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
  block[
    #text(size: 17pt, weight: 700, fill: heading_color, labels.toc)
    #v(0.6em)

    #set text(size: 11.4pt)
    #set par(leading: 0.38em)
    #columns(2, gutter: 1.1cm)[
      #show outline.entry.where(level: 1): strong
      #outline(title: none, indent: 0pt)
    ]
  ]

  pagebreak()

  // ----------------
  // Body
  // ----------------
  set par(justify: false, leading: 0.58em)
  body
}

#let note(title: none, body) = {
  grid(
    columns: (1fr,),
    block(
      width: 100%,
      inset: 8pt,
      radius: 2pt,
      stroke: (left: 2pt + decorative_color, rest: 0.45pt + border_color),
      fill: soft_fill,
    )[
      #if title != none [
        #text(weight: 700, fill: heading_color, title)
        #v(0.25em)
      ]
      #body
    ]
  )
}

#let callout(title: none, accent: decorative_color, fill: soft_fill, width: 100%, body) = {
  grid(
    columns: (width,),
    block(
      width: 100%,
      inset: 8pt,
      radius: 2pt,
      stroke: (left: 2pt + accent, rest: 0.45pt + border_color),
      fill: fill,
      above: 0.75em,
      below: 0.75em,
    )[
      #if title != none [
        #text(weight: 700, title)
        #v(0.25em)
      ]
      #body
    ]
  )
}

#let definition(body) = callout(accent: violet_haze, width: 100%, body)
#let tip(body) = callout(accent: electric_violet, width: 100%, body)
#let warning(body) = callout(accent: deep_plum, width: 100%, body)
#let formula(body) = callout(accent: violet_haze, fill: mist_lavender, width: 100%, body)
#let example(body) = callout(accent: orchid_mist, width: 100%, body)

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
      inset: 6.5pt,
      stroke: 0.45pt + border_color,
      fill: (_, y) => if y == 0 { soft_fill },
      table.header(
        [#text(fill: heading_color, weight: 700, labels.term)],
        [#text(fill: heading_color, weight: 700, labels.location)],
      ),
      ..entries.map(entry => (
        [#text(weight: 700, entry.term)],
        [#link(entry.location)[#labels.page #counter(page).at(entry.location).first()]],
      )).flatten(),
    )
  }
}
