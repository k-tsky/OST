# Typst Copy-Paste Snippets

Use this on top to get started with a new typst file:
```typst
#import "../template.typ": *
#show: project.with(
  title: "title",
  authors: ("Katharina Tschirky"),
  lang: "de", //optional, default is en
  region: "CH", //optional, default is us
)
```

The template adds title pages, headers/footers, table styling, localized labels,
and an automatic glossary. Mark terms in the text with:

```typst
#glossary-term("Begriff")
```

Then print the glossary at the end:

```typst
#glossary()
```

This line is an example for adding a centered image:

```typst
#align(center, image("img/wrstat_07.png", width: 50%))
```

The final `\` inserts a line break in Typst and can be used as a quick spacing
helper after the template setup.

The following grid can be used to place contents next to each other:
```typst
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    asdf
  ],
  [
    blabla
  ],
)

```

## Callout Blocks

Use callout blocks for important notes, definitions, examples, warnings, and
formulas.

```typst
#tip[
  Merke: This is an important takeaway.
]

#definition[
  A short definition or key concept.
]

#example[
  A short example or sample case.
]

#warning[
  Achtung: Something that is easy to miss.
]

#formula[
  Important formula or calculation rule.
]
```

For a custom block title or accent, use `#callout`:

```typst
#callout(title: "Exam Tip")[
  Read the question carefully before choosing the legal basis.
]
```