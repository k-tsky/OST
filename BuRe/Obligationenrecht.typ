#import "../template.typ": *
= Obligationenrecht - Erklärungen
== Entstehung einer Obligation
- Vertrag (Art. 1 - 40 ff. OR)
- unerlaubte Handlungen (Art. 41-61 OR
- ungerechtfertigte Bereicherung (Art. 62-67 OR)

andere Rechtsgründe:
- Geschäftsführung ohne Auftrag (Art. 419 ff. OR)
- Culpa in contrahendo
- Eigentumsfreiheitsklage (Art. 641 ZGB)
- Besitzesrechtsklage (Art. 934 ff. ZGB)
- Persönlichkeitsverletzung (Art. 28 ff. ZGB)
- Verwandtenunterstützungspflicht (Art. 328 f. ZGB)

== Rechtssubjekte (Personen)
#glossary-term("Natürliche Personen"): Menschen \
#glossary-term("Juristische Personen"):
- AG (Art. 620 ff. OR)
- GmbH (Art. 772 ff. OR)
- Genossenschaft (Art. 828 ff. OR)
- Verein (Art. 60 ff. ZGB)
- Stiftung (Art. 80 ff. ZGB)

#tip[
*Merke: *
Die Kollektiv- und Kommanditgesellschaften sind keine juristischen Personen, sondern Rechtsgemeinschaften. Im Rechtsverkehr treten diese Gesellschaften trotzdem unter eigener Firma auf. Die Kollektiv- und Kommanditgesellschaften sind unter ihrer Firma parteifähig und damit prozess- und betreibungsfähig (vgl. Art. 562 OR).
]

== Culpa in contrahendo
#definition[
#glossary-term("Culpa in contrahendo"): Schuldhafte Verletzung vorvertraglicher Pflichten, wobei eine allfällige Schadenersatzpflicht unabhängig davon eintreten kann, ob der Vertrag in der Folge gültig zustande kommt oder nicht. Grundlage ist Art. 2 Abs. 1 ZGB.
]

== Verträge
// TODO: Markieren im OR
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *AT = Allgemeinter Teil*, Art. 1 bis 183 OR \
    - Allg. regeln im OR (Vertragsschluss, Willensmangel etc.)
    *BT = Besonderer Teil*, ab Art. 184 OR
    - Vertragsarten (Kaufvertrag, Mietvertrag etc.)
  ],
  [
    #align(center, image("img/OR/AT-BT.png", width: 100%))
  ],
)

=== Grundsatz der Vertragsfreiheit (Art. 19 OR)
Parteien können den Vertragsinhalt grundsätzlich frei bestimmen. Grenzen sind zwingendes Recht, öffentliche Ordnung, gute Sitten und Persönlichkeitsrechte.

Verschiedene Aspekte:
- Abschlussfreiheit
- Partnerwahlfreiheit
- Inhaltsfreiheit
- Aufhebungsfreiheit
- Formfreiheit

#glossary-term("Vertragsfreiheit"): Tatsächliche Gültigkeit eines Vertrages hängt von verschiedenen Voraussetzungen ab.

=== Voraussetzungen für Verträge
- (beschränkte) Handlungsfähigkeit der Parteien
- Konsens beim Vertragsabschluss
- Formgültigkeit
- Kein Inhaltsmangel: nicht unmöglich, nicht rechtswidrig (z.B Verstoss der AGB gegen UWG 8), nicht unsittlich
- Kein Willensmangel 
- Gültige Stellvertretung

=== Gesetzliche Bestimmungen
#glossary-term("Dispositive Gesetzesbestimmungen"): Sofern der Vertrag Aspekte nicht regelt, kommen die dispositiven Gesetzesbestimmungen zum Zuge. Die meisten Bestimmungen im OR AT und im OR BT sind dispositiv und finden bloss Anwendung, wenn die Parteien nichts anderes vereinbart haben.

#glossary-term("Zwingende Gesetzesbestimmungen"): Die zwingenden Gesetzesnormen gehen den vertraglichen Bestimmungen immer vor. Beispiele: OR 100 I, OR 199, OR 210 IV, OR 404, UWG 8 – sodann zahlreiche Normen des Miet- und Arbeitsrechts.

=== Vertragstypen
#align(center, image("img/OR/vertragstypen.png", width: 100%))

=== Formvorschriften
Gründe:
+ Beweissicherung
+ Schutz vor übereiltem Vertragsschluss
+ Rechtssicherheit
+ Schutz der schwächeren Partei

=== Vertragsform
#table(
  columns: (0.8fr, 1.4fr, 1fr),
  inset: 8pt,

  [*Vertragsform*], [*Merkmale*], [*Beispiele*],

  [#glossary-term("Formfreiheit") (Art. 11 OR)],
  [Das Obligationenrecht geht von dem Grundsatz der Formfreiheit aus. Darunter versteht man die Freiheit, Verträge in freier Form abzuschliessen, abzuändern oder aufzuheben. Eine besondere Form ist nur notwendig, wenn es das Gesetz oder die Abrede eine solche vorschreibt.],
  [
    - Einzelarbeitsvertrag
    - Mietvertrag
    - Kaufvertrag
    - Darlehen
  ],

  [Einfache Schriftlichkeit (Art. 13–15 OR)],
  [Ist die einfache Schriftlichkeit vorgesehen, muss der Vertrag die eigenhändige Unterschrift oder eine qualifizierte elektronische Signatur aller beteiligten Personen aufweisen.],
  [
    - Schenkungsversprechen
    - Lehrvertrag
    - Versicherungsvertrag
    - Konkurrenzverbot im Arbeitsvertrag
  ],

  [Qualifizierte Schriftlichkeit],
  [Die qualifizierte Schriftlichkeit verlangt nicht nur die Unterschrift der Verpflichteten, sondern die handschriftliche Angabe gewisser Elemente in der Urkunde.],
  [
    - Bürgschaft
    - Testament
  ],

  [Öffentliche Beurkundung],
  [Bei der öffentlichen Beurkundung erfolgt der Vertragsschluss unter Mitwirkung einer Urkundsperson, z. B. Notar. Die Urkundsperson bestätigt die Richtigkeit des Inhaltes der Urkunde.],
  [
    - Grundstückkaufvertrag
    - Vorvertrag über ein Grundstück mit Kaufpreis
    - Bürgschaft natürlicher Personen, wenn die Haftungssumme über Fr. 2'000.– liegt
    - Ehe- und Erbvertrag
  ],
)

=== Stellvertretung
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *Mit Ermächtigung*
    #align(center, image("img/OR/stellvertretung-m.png", width: 100%))
    *Merke:* Die Erklärung des Vertreters, in fremdem Namen zu handeln kann entweder ausdrücklich oder stillschweigend erfolgen, gemäss Art. 32 Abs. 2 OR genügt es, dass der Dritte aus den Umständen auf das Vertretungsverhältnis schliessen muss (Z. Bsp. Angestellter in einem Einkaufsgeschäft)
  ],
  [
    *Ohne Ermächtigung*
    #align(center, image("img/OR/stellvertretung-o.png", width: 100%))
    → vgl. Art. 38-39 OR oder auch 419 ff. OR

    *Arten von Vollmachten:* Spezialvollmacht, Generalvollmacht und Gattungsvollmacht, Einzel- und Kollektivvollmacht 
    
    *Sog. Unechte Stellvertretung:* Handeln für fremde Rechnung, aber in eigenem Namen, siehe Art. 32 Abs. 3 OR

  ],
)

=== Vertragsschluss (Art. 1 OR)
Ein Vertrag entsteht durch übereinstimmende gegenseitige Willensäusserung. Diese kann ausdrücklich oder stillschweigend erfolgen.

#glossary-term("Willensäusserung"): Angebot und Annahme.

#glossary-term("Antrag"): Der Antrag ist ein einseitiges Rechtsgeschäft, der auf den Abschluss eines Vertrages gerichtet ist. 
Begrifflichkeiten:
- Empfangsbedürftigkeit
- Unterscheidung verbindlicher - und unverbindlicher Antrag (vgl. Art. 7 OR)
- Widerruf (Art. 9 OR)

#glossary-term("Annahme"): Die Annahme ist ein einseitiges Rechtsgeschäft.
Begrifflichkeiten:
- Einverständnis in den wesentlichen Punkten ("essentialia negotii")
- Art. 2 OR: Einigung über alle wesentlichen Punkte genügt, offene Nebenpunkte hindern die Verbindlichkeit grundsätzlich nicht
- Empfangsbedürftigkeit
- Stillschweigende Annahme (Art. 6 OR)
- Widerruf (Art. 9 OR)
- Widerruf beim Haustürgeschäft (Art. 40a ff. OR)

==== Ausdrückliche Willensäusserung
Beispiele:
- mündlich
- schriftlich per Brief, E-Mail, SMS
- durch Gesten

_Rechtsgrundlage:_ Art. 1 Abs. 2 OR

==== Konkludente Willensäusserungen
*Stillschweigen*

Grundsatz: *keine* Willensäusserung. \
Ausnahmen (Stillschweigen = Willensäusserung) betreffen unter anderem Art. 6 OR.

Beispiele:
- Wer noch nicht verfallene Mietzinse stillschweigend entgegennimmt, stimmt implizit einer Verlängerung der Miete zu.
- Beauftragung eines Anwalts (Art. 395 OR)

*Beipsiele weiteres schlüssiges Verhalten*
- wortloses Hinlegen von Waren auf das Beförderungsband an der Kasse
- wortloses Hinlegen des Kaufpreises am Kiosk
- Einwurf von Münzen am Getränkeautomaten zum Kauf eines Süssgetränks

_Rechtsgrundlage:_ Art. 1 Abs. 2 OR

#pagebreak()
=== Allgemeine Geschäftsbedingungen (AGB's)

#grid(
  columns: (1.3fr, 2.2fr),
  gutter: 2em,
  row-gutter: 1em,

  [*Begriff*],
  [
    - generell vorformulierte Bestimmungen, die Inhalt des Vertrages werden
    - gelten für eine Vielzahl von Verträgen
    - Abweichungen vom dispositiven Recht
  ],

  [*Geltung*],
  [nur verbindlich, wenn von den Parteien übernommen, d. h. keine allgemeine Verbindlichkeit],

  [*Keine Geltung, trotz Übernahme*],
  [
    - Verstoss gegen zwingendes Recht
    - abweichende individuelle Regelung
    - keine Möglichkeit, sich vom Inhalt Kenntnis zu verschaffen
    - ungewöhnliche Klausel
    - missbräuchlicher Inhalt (Art. 8 UWG)
  ],

  [*Auslegung*],
  [bei Unklarheiten gegen den Verfasser],
)

=== Erfüllung der Obligation
Eine Obligation erfüllen heisst, die geschuldete Leistung richtig, mängelfrei und rechtzeitig zu erbringen.

*Wichtige Einzelpunkte der Erfüllung:*
- Person des Erfüllenden (vgl. OR 68, 321, 364 II, 398 III)
- Gegenstand (vgl. OR 2 I)
- Ort der Erfüllung (vgl. OR 74, 189 I)
- Zeit der Erfüllung (vgl. OR 75, 213 I, 257c, 318, 323 I, 372 I)

Die meisten Erfüllungsregeln des Allgemeinen Teils des OR gelten nur:
- wenn die Parteien keine abweichenden Vereinbarungen getroffen haben
- wenn die Vorschriften des Besonderen Teils des OR keine abweichenden Regelungen enthalten

Grundsatz: spezielles Recht geht allgemeinem Recht vor.

==== Ort der Erfüllung
#align(center, image("img/OR/ort.png", width: 90%))

==== Erfüllungsstörungen

#table(
  columns: (1fr, 1fr),
  inset: 8pt,

  [*Auf Seiten des Schuldners*],
  [*Auf Seiten des Gläubigers*],

  [#glossary-term("Nichterfüllung") (Art. 97 ff. OR)],
  [#glossary-term("Gläubigerverzug") (Art. 91 ff. OR) \
  → Unterlassung von Mitwirkungshandlungen],

  [#glossary-term("Positive Vertragsverletzung") (Art. 97 ff. OR) \
  → Verletzung von Nebenpflichten oder Schlechterfüllung],
  [],

  [#glossary-term("Schuldnerverzug") (Art. 102 ff. OR)],
  [],
)

#tip[
*Merke:* Für den Schuldner besteht Erfüllungszwang. Art. 98 OR gibt dem Gläubiger die Möglichkeit, sich vom Richter zur ersatzweisen Vornahme der ausgebliebenen Leistung ermächtigen zu lassen. Der Gläubiger kann natürlich auch auf Erfüllung klagen.
]

#align(center, image("img/OR/schlechterfüllung.png", width: 90%))

#align(center, image("img/OR/schlechterfüllung-2.png", width: 72%))

==== Schuldnerverzug anhand des Kaufvertrages
 Der Schuldner gerät in Verzug, wenn eine fällige Forderung trotz Mahnung oder Verfalltag nicht erfüllt wird und keine verzugshindernden Gründe vorliegen.

==== Ablauf
+ Forderung wird fällig
  - Normalfall: Mahnung
  - Ausnahme: Nach OR 102 II tritt Verzug ohne Mahnung ein, z. B. bei einem bestimmten Verfalltag.
+ Verzug
+ Verzugsfolgen

==== Voraussetzungen
- Nichtleistung trotz Fälligkeit
- Fälligkeit der Forderung
- Mahnung oder Verfalltag
- keine verzugshindernden Gründe

==== Verzugsfolgen
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    *verschuldensunabhängig*
    - Geldschulden: Verzugszins
    - Bei zweiseitigen Verträgen: Rücktritt und Rückforderung bereits erbrachter Leistungen
  ],
  [
    *verschuldensabhängig*\
    Schadenersatzpflichten:
    - Verzugsschaden und Zufallshaftung (Art. 103 OR)
    - bei Verzicht auf Leistung (Art. 107 Abs. 2 OR)
    - bei Rücktritt (Art. 109 Abs. 2 OR)
  ],
)

==== Zusammenfassung Verzug
#align(center, image("img/OR/verzug.png", width: 100%))

==== Erfüllungszeit
Eine Obligation entsteht mit dem Vertragsschluss. Ab diesem Zeitpunkt gibt es die Forderung grundsätzlich bereits.

Nach Art. 75 OR gilt ohne andere Vereinbarung:
- Der Gläubiger darf die Leistung sofort fordern. Das ist die #glossary-term("Fälligkeit").
- Der Schuldner darf grundsätzlich sofort leisten. Das ist die #glossary-term("Erfüllbarkeit").

Wird ein bestimmter Termin vereinbart, kommt es auf die Formulierung an:

- „Wir liefern Ihnen am 12. Juni 2019“
  - Die Leistung ist genau an diesem Tag zu erbringen. Der Schuldner muss an diesem Zeitpunkt leisten.
- „Wir liefern Ihnen bis zum 21. August 2019“
  - Der Schuldner darf vorher leisten, muss aber spätestens bis zu diesem Datum leisten. Der Gläubiger darf die Leistung ab diesem Zeitpunkt verlangen.
- Ohne Termin: „Wir liefern Ihnen 5000 l Heizöl“
  - Fälligkeit und Erfüllbarkeit beginnen grundsätzlich sofort nach Vertragsschluss.

Kurz gesagt:
*Erfüllbarkeit* bedeutet, ab wann der Schuldner leisten darf oder muss.
*Fälligkeit* bedeutet, ab wann der Gläubiger die Leistung verlangen darf.

=== Übersicht Inhalts-/Willensmangel

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    #glossary-term("Inhaltsmangel"): Der Vertragsinhalt verstösst gegen gesetzliche Schranken oder ist objektiv unmöglich.

    Rechtsfolge:
    - grundsätzlich Nichtigkeit des Vertrags (Art. 20 OR)
    - betrifft der Mangel nur einzelne Teile: Teilnichtigkeit möglich (Art. 20 Abs. 2 OR)

    Typische Fälle:
    - widerrechtlicher Vertragsinhalt
      - ewige Verträge ohne Kündigungsmöglichkeiten
      - Kaufvertrag über 5g Kokain
    - sittenwidriger Vertragsinhalt
      - Prostitutionsvertrag
      - Bezahlte Unterstützung der Erbschleicherei
    - anfänglich objektiv unmöglicher Vertragsinhalt
  ],
  [
    #glossary-term("Willensmangel"): Der Vertrag kommt zwar zustande, der Wille einer Partei ist aber mangelhaft gebildet oder beeinflusst.

    Rechtsfolge:
    - Vertrag ist anfechtbar
    - Anfechtbarkeit nach Art. 21 und Art. 23 ff. OR

    Typische Fälle:
    - Übervorteilung (Art. 21 OR)
    - wesentlicher Irrtum (Art. 23 f. OR)
    - absichtliche Täuschung (Art. 28 OR)
    - Drohung oder Furchterregung (Art. 29 f. OR)
  ],
)

#tip[
*Merke:* Inhaltsmängel betreffen den Inhalt des Vertrags und führen grundsätzlich zur Nichtigkeit. Willensmängel betreffen die Willensbildung einer Partei und führen grundsätzlich zur Anfechtbarkeit.
]

=== Wesentlicher Irrtum 
*Grundlagenirrtum:* (Willensbildung)
- Wirklicher Wille = Erklärter Wille
- Jedoch fehlerhafte Willensbildung
- (Irrtum über eine notwendige Vertragsgrundlade)
- Art. 24 Abs. 1 Ziff 4 OR

Voraussetzungen Grundlagenirrtum:
- subjektive Wesentlichkeit
- objektive Wesentlichkeit
- Erkennbarkeit des Irrtums für Gegenpartei

*Erklärungsirrtum:* (Willenserklärung)
- Wirklicher Wille != Erklärter Wille
- (Irrtümliche Erklärung über Vertragsart, Vertragsgegenstand/Person, Umfang der Leistung)
- Kommunikationsfehler (Verschreiber, Versprecher etc.)
- Art. 24 Abs. 1 Ziff 1-3 OR

=== Verjährung
*Begriff: *Untergang der Durchsetzbarkeit einer Obligation durch Zeitablauf\
*Fristen:* Grundsatz: OR 127\
*Ausnahmen:* OR 128, OR 128a, OR 60, OR 67 etc.\

#tip[
*Merke:* Gesetzliche Verjährungsfristen können vertraglich nicht abgeändert werden, aber es besteht die Möglichkeit, auf die Verjährungseinrede zu verzichten.
]

- Beginn mit Fälligkeit der Forderung (vgl. OR 130, OR 60/67)
- Unterbrechung = Neubeginn der Verjährung
  - durch Schuldner: Anerkennung
  - durch Gläubiger: Betreibung, Klage, EIngabe im Konkurs

#tip[
*Merke:* Verjährung wird nicht von Amtes wegen berücksichtigt, sondern nur auf Einrede
]

==== Beispiele
*Wesentliche vertragliche Verjährungsfristen:*

- *Art. 127 OR:* 10 Jahre (generell)
- *Art. 128 OR:* 5 Jahre (Miet-, Pacht-, und Kapitalzinse, Liferung von Lebensmittel, Handwerksarbeit etc)
- *Art. 210 OR:* 2 und 5 Jahre bei Kaufgewährleistung
- *Art. 371 OR:* 2 und 5 Jahre bei Werkgewährleistung
- Die kurzen Gewährleistungsfristen gelten nicht bei absichtlicher Täuschung.

=== Beispiele

#table(
  columns: (1.4fr, 1.8fr),
  inset: 6pt,
  stroke: 0.5pt,
  align: (left, left),

  [*Fall*], [*Lösung*],

  [Vertraglicher Schadenersatzanspruch aus OR 97],
  [10 Jahre nach Art. 127 OR, da keine kürzere Spezialfrist gilt.],

  [Ausstehende Kaufpreisforderung für Kauf von Kleinwaren],
  [5 Jahre nach Art. 128 Ziff. 3 OR.],

  [Ausstehende Mietzinszahlungen],
  [5 Jahre nach Art. 128 Ziff. 1 OR.],

  [Susis Gewährleistungsrechte für das gekaufte Elektrogerät],
  [2 Jahre nach Art. 210 Abs. 1 OR.],

  [Susis Gewährleistungsrechte für das erworbene Ferienhaus],
  [5 Jahre, da es sich um ein Grundstück bzw. eine Immobilie handelt.],

  [Pablos Rechnung von CHF 3'000 für den Bau der Veranda],
  [5 Jahre nach Art. 128 Ziff. 3 OR, da es sich um Handwerksarbeit handelt.],

  [Anitas Gewährleistungsrechte wegen der Veranda],
  [5 Jahre nach Art. 371 OR, da es sich um ein unbewegliches Werk handelt.],
)

== Erlöschen der Obligation
Eine Obligation erlischt, wenn der Schuldner die Leistung erbracht hat oder nicht mehr erfüllen muss. Der Gläubiger kann die Leistung dann nicht mehr verlangen oder durchsetzen.

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    #table(
      columns: (1.2fr, 1fr),
      inset: 7pt,

      [*Art des Erlöschens*],
      [*Rechtsgrundlage*],

      [Erfüllung],
      [Normalfall],

      [Verrechnung],
      [OR 120-126],

      [Verjährung],
      [OR 127-142],

      [Aufhebung],
      [OR 115],

      [Neuerung],
      [OR 116-117],

      [Vereinigung],
      [OR 118],

      [Nachträgliche Unmöglichkeit],
      [OR 119],
    )
  ],
  [
    *Erlöschen heisst:*
    - Schuldner hat Leistung erbracht oder muss nicht mehr erfüllen
    - Gläubiger kann Leistung nicht mehr verlangen oder durchsetzen
  ],
)

