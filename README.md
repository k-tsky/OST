# OST Notes

This repository contains summaries, cheat sheets, and notes for OST courses.
It is meant as a personal knowledge base for collecting useful explanations,
quick references, and reusable Typst snippets while studying.

## Contents

- Course summaries
- Cheat sheets
- Study notes
- Copy-paste templates and snippets

## Credits

Special thanks to [@melaurias](https://github.com/melaurias) for contributing and writing these summaries, cheat sheets, and notes.

## Typst Copy-Paste Snippets

Use this on top to get started with a new typst file:
```typst
#import "../template.typ": *
#show: project.with(
  title: "title",
  authors: ("Katharina Tschirky"),
)
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

## Quizlet Resources

- [Bsys1](https://quizlet.com/de/karteikarten/bsys1-1083031410?i=5ecu67&x=1jqt)
- [OOP1 Uebungen](https://quizlet.com/de/karteikarten/oop1-theoriefragen-aus-den-ubungen-1100301929)
- [OOP1 Theory](https://quizlet.com/de/karteikarten/oop1-theoriefragen-vorlesungprufungen-1125193189)
- [OOP2](https://quizlet.com/user/katharina_tschirky/folders/oop2?funnelUUID=2688cafc-75ec-4cea-bbf0-117b83a15fcb)
- [Dbs1 Vorlesungen (Fragen und Uebungen)](https://quizlet.com/de/karteikarten/dbs1-vorlesungen-ubungen-und-fragen-960725970)
- [CN2 - Practical Things](https://quizlet.com/user/katharina_tschirky/folders/cn2-practical-things?funnelUUID=1101dd4d-2760-4702-889c-4c8afe04cca4)
- [CN2 - The theory stuff](https://quizlet.com/user/katharina_tschirky/folders/cn2-the-theory-stuff?funnelUUID=a331f767-0206-4d46-bef1-0cd68b5c44bc)
- [CN1 - Knowledge Checks](https://quizlet.com/ch/964499592/lab-knowledge-checks-cn1-flash-cards/)
- [FP Summary](https://quizlet.com/ch/922812290/fp-summary-flash-cards/)
- [CySec](https://quizlet.com/user/katharina_tschirky/folders/cysec24?funnelUUID=78950d19-b67d-4edc-a59e-42190066f323)
- [English WoS](https://quizlet.com/user/katharina_tschirky/folders/english-the-world-of-science?funnelUUID=d8972387-b748-40e7-b3ef-06a1b7a43259)
- [SEP2](https://quizlet.com/ch/1144325670/sep2-theoriefragen-flash-cards/)
