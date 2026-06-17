// LTeX: language=de-CH
#import "../template.typ": *
#show: project.with(
  title: "Business und Recht 2",
  authors: ("Katharina Tschirky"),
  lang: "de",
  region: "CH",
)

#include "Gesetzestexte.typ"
#pagebreak()
#include "Obligationenrecht.typ"
#pagebreak()
#include "ZGB.typ"
#pagebreak()

#include "Fallbeispiele.typ"
#glossary()
