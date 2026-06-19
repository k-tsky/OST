= Gesetzessammlung

#let soft-hyphen = sym.zws

#let gesetz-table(..items) = {
  set text(hyphenate: true)
  set par(leading: 0.34em)
  table(
  columns: (0.95fr, 1.4fr, 1fr, 2.85fr),
  inset: (x: 4.2pt, y: 3.2pt),
  align: (left, left, left, left),

  [*Artikel*],
  [*Stichwort*],
  [*Themen*],
  [*Kurzinhalt*],

  ..items,
  )
}

== Obligationenrecht
#gesetz-table(
  [*Art. 1 OR*],
  [Vertragsschluss],
  [OR AT, Verträge],
  [Vertrag entsteht durch übereinstimmende gegenseitige Willensäusserung.],

  [*Art. 6 OR*],
  [Stillschweigende #(soft-hyphen)Annahme],
  [Vertragsschluss],
  [Schweigen kann ausnahmsweise als Annahme gelten, wenn keine ausdrückliche Annahme zu erwarten ist.],

  [*Art. 7 OR*],
  [Verbindlicher Antrag],
  [Vertragsschluss],
  [Regelt, wann ein Antrag verbindlich ist und wie lange der Antragsteller gebunden bleibt.],

  [*Art. 9 OR*],
  [Widerruf],
  [Vertragsschluss],
  [Widerruf ist wirksam, wenn er vor oder gleichzeitig mit dem Antrag bzw. der Annahme eintrifft.],

  [*Art. 11 OR*],
  [Formfreiheit],
  [Form, Verträge],
  [Verträge sind grundsätzlich formfrei, sofern das Gesetz keine besondere Form verlangt.],

  [*Art. 13-15 OR*],
  [Schriftlichkeit],
  [Form],
  [Regeln zur einfachen Schriftlichkeit, Unterschrift und Ersatzformen.],

  [*Art. 20 OR*],
  [Nichtigkeit],
  [Inhaltsmängel],
  [Unmögliche, widerrechtliche oder unsittliche Verträge sind nichtig.],

  [*Art. 21 OR*],
  [Übervorteilung],
  [Inhaltsmängel],
  [Missverhältnis zwischen Leistung und Gegenleistung bei Ausbeutung einer Schwächesituation.],

  [*Art. 23-24 OR*],
  [Irrtum],
  [Willensmängel],
  [Wesentlicher Irrtum kann zur Anfechtung des Vertrags berechtigen.],

  [*Art. 28 OR*],
  [Täuschung],
  [Willensmängel],
  [Absichtliche Täuschung kann zur Anfechtung des Vertrags führen.],

  [*Art. 29-30 OR*],
  [Drohung / Furcht],
  [Willensmängel],
  [Vertrag kann angefochten werden, wenn er unter begründeter Furcht abgeschlossen wurde.],

  [*Art. 32 OR*],
  [Stellvertretung],
  [Form, Vertretung],
  [Vertreter handelt in fremdem Namen; Wirkungen treten beim Vertretenen ein.],

  [*Art. 38-39 OR*],
  [Vertretung ohne #(soft-hyphen)Ermächtigung],
  [Vertretung],
  [Regeln zur Genehmigung und Haftung bei Handeln ohne Ermächtigung.],

  [*Art. 41 OR*],
  [Verschuldens#(soft-hyphen)haftung],
  [Haftpflicht, IT-Verträge],
  [Schadenersatz bei widerrechtlicher, absichtlicher oder fahrlässiger Schädigung.],

  [*Art. 55 OR*],
  [Geschäftsherren#(soft-hyphen)haftung],
  [Haftpflicht, IT-Verträge],
  [Haftung für Hilfspersonen oder Angestellte unter bestimmten Voraussetzungen.],

  [*Art. 68 OR*],
  [Persönliche Erfüllung],
  [Erfüllung],
  [Schuldner muss nur persönlich erfüllen, wenn es auf seine Person ankommt.],

  [*Art. 74-75 OR*],
  [Ort und Zeit der Erfüllung],
  [Erfüllung],
  [Regeln zu Erfüllungsort und Fälligkeit, wenn nichts anderes vereinbart ist.],

  [*Art. 91 OR*],
  [Gläubigerverzug],
  [Erfüllungs#(soft-hyphen)störungen],
  [Gläubiger nimmt ordnungsgemäss angebotene Leistung nicht an.],

  [*Art. 97 ff. OR*],
  [Vertrags#(soft-hyphen)verletzung],
  [Erfüllungs#(soft-hyphen)störungen, IT-Verträge],
  [Allgemeine Haftung bei Nichterfüllung, Schlechterfüllung oder verspäteter Erfüllung.],

  [*Art. 102 ff. OR*],
  [Schuldnerverzug],
  [Erfüllungs#(soft-hyphen)störungen],
  [Schuldner gerät mit fälliger Leistung in Verzug, meist nach Mahnung.],

  [*Art. 107-109 OR*],
  [Verzugsfolgen],
  [Erfüllungs#(soft-hyphen)störungen],
  [Nachfrist, Rücktritt, Verzicht auf Leistung und Schadenersatz.],

  [*Art. 115-126 OR*],
  [Erlöschen der Obligation],
  [OR AT],
  [Aufhebung, Neuerung, Vereinigung, nachträgliche Unmöglichkeit und Verrechnung.],

  [*Art. 127-128 OR*],
  [Verjährungs#(soft-hyphen)fristen],
  [Verjährung, IT-Verträge],
  [Allgemeine zehnjährige und besondere fünfjährige Verjährungsfristen.],

  [*Art. 130 OR*],
  [Beginn der Verjährung],
  [Verjährung],
  [Verjährung beginnt grundsätzlich mit Fälligkeit der Forderung.],

  [*Art. 160 ff. OR*],
  [Konventional#(soft-hyphen)strafe],
  [IT-Verträge, SLA],
  [Vertraglich vereinbarte Strafe, häufig bei Verletzung von Service Levels.],
)

== Kaufrecht
#gesetz-table(
  [*Art. 197 ff. OR*],
  [Sach#(soft-hyphen)gewährleistung],
  [Kauf, IT-Verträge],
  [Verkäufer haftet für zugesicherte Eigenschaften und erhebliche körperliche oder rechtliche Mängel.],

  [*Art. 201 OR*],
  [Prüf- und Rügepflicht],
  [Kauf],
  [Käufer muss Kaufsache prüfen und Mängel rechtzeitig rügen.],

  [*Art. 205 OR*],
  [Wandelung / Minderung],
  [Kauf],
  [Käufer kann bei Mängeln Rückabwicklung oder Preisreduktion verlangen.],

  [*Art. 206 OR*],
  [Ersatzlieferung],
  [Kauf],
  [Beim Gattungskauf kann Ersatzlieferung verlangt werden.],

  [*Art. 208 OR*],
  [Schadenersatz bei Wandelung],
  [Kauf],
  [Regelt Schadenersatzfolgen bei Rückabwicklung wegen Sachmängeln.],

  [*Art. 210 OR*],
  [Verjährung Kaufmängel],
  [Kauf, Verjährung],
  [Mängelrechte verjähren grundsätzlich zwei Jahre nach Ablieferung.],
)

== Arbeitsrecht
#gesetz-table(
  [*Art. 319 ff. OR*],
  [Einzelarbeitsvertrag],
  [Arbeitsrecht],
  [Arbeitsleistung gegen Lohn im Unterordnungsverhältnis.],

  [*Art. 320 OR*],
  [Formfreier Abschluss],
  [Arbeitsrecht],
  [Arbeitsvertrag kann schriftlich, mündlich oder konkludent entstehen.],

  [*Art. 321 OR*],
  [Persönliche Arbeitspflicht],
  [Arbeitsrecht],
  [Arbeitnehmer muss Arbeit grundsätzlich persönlich leisten.],

  [*Art. 321a OR*],
  [Sorgfalts- und Treue#(soft-hyphen)pflicht],
  [Arbeitsrecht],
  [Sorgfältige Arbeitsleistung, Wahrung der Arbeitgeberinteressen und Geheimhaltung.],

  [*Art. 321c OR*],
  [Überstunden],
  [Arbeitsrecht],
  [Überstundenarbeit und deren Kompensation bzw. Entschädigung.],

  [*Art. 321d OR*],
  [Weisungsrecht],
  [Arbeitsrecht],
  [Arbeitnehmer muss berechtigte Anordnungen und Weisungen befolgen.],

  [*Art. 321e OR*],
  [Arbeitnehmer#(soft-hyphen)haftung],
  [Arbeitsrecht, IT-Kontext],
  [Haftung nach Verschulden, Berufsrisiko, Ausbildung, Stellung und Fähigkeiten.],

  [*Art. 322 ff. OR*],
  [Lohnpflicht],
  [Arbeitsrecht],
  [Pflicht des Arbeitgebers zur Lohnzahlung.],

  [*Art. 323 OR*],
  [Lohnfälligkeit],
  [Arbeitsrecht],
  [Regelt Fälligkeit und Auszahlung des Lohns.],

  [*Art. 324 ff. OR*],
  [Annahmeverzug Arbeitgeber],
  [Arbeitsrecht],
  [Lohn bei Verhinderung der Arbeitsleistung durch Gründe beim Arbeitgeber.],

  [*Art. 324a OR*],
  [Lohnfortzahlung],
  [Arbeitsrecht],
  [Lohnfortzahlung bei unverschuldeter Verhinderung des Arbeitnehmers.],

  [*Art. 328 OR*],
  [Persönlichkeits#(soft-hyphen)schutz],
  [Arbeitsrecht, ZGB-Bezug],
  [Schutz von Persönlichkeit, Gesundheit und Integrität des Arbeitnehmers.],

  [*Art. 330a OR*],
  [Arbeitszeugnis],
  [Arbeitsrecht],
  [Anspruch auf Arbeitszeugnis oder Arbeitsbestätigung.],

  [*Art. 332 OR*],
  [Erfindungen und Designs],
  [Arbeitsrecht],
  [Rechte an Erfindungen und Designs im Arbeitsverhältnis.],

  [*Art. 334 OR*],
  [Befristeter Vertrag],
  [Arbeitsrecht],
  [Befristeter Arbeitsvertrag endet durch Zeitablauf.],

  [*Art. 335 ff. OR*],
  [Ordentliche Kündigung],
  [Arbeitsrecht],
  [Regeln zur ordentlichen Kündigung.],

  [*Art. 335b OR*],
  [Probezeit],
  [Arbeitsrecht],
  [Kündigung während der Probezeit.],

  [*Art. 335c OR*],
  [Kündigungs#(soft-hyphen)fristen],
  [Arbeitsrecht],
  [Gesetzliche Kündigungsfristen nach Dienstjahr.],

  [*Art. 336 ff. OR*],
  [Missbräuchliche Kündigung],
  [Arbeitsrecht],
  [Missbräuchliche Kündigungsgründe und Folgen.],

  [*Art. 336c OR*],
  [Sperrfristen],
  [Arbeitsrecht],
  [Kündigung zur Unzeit durch den Arbeitgeber.],

  [*Art. 337 ff. OR*],
  [Fristlose Kündigung],
  [Arbeitsrecht],
  [Fristlose Kündigung aus wichtigem Grund.],

  [*Art. 337a OR*],
  [Insolvenz Arbeitgeber],
  [Arbeitsrecht],
  [Fristlose Kündigung bei Zahlungsunfähigkeit des Arbeitgebers.],

  [*Art. 337c OR*],
  [Ungerechtfertigte fristlose #(soft-hyphen)Kündigung],
  [Arbeitsrecht],
  [Folgen einer ungerechtfertigten fristlosen Kündigung.],

  [*Art. 338 OR*],
  [Tod des Arbeitnehmers],
  [Arbeitsrecht],
  [Folgen des Todes des Arbeitnehmers.],

  [*Art. 340 ff. OR*],
  [Konkurrenz#(soft-hyphen)verbot],
  [Arbeitsrecht],
  [Voraussetzungen und Grenzen des Konkurrenzverbots.],

  [*Art. 344a OR*],
  [Lehrvertrag],
  [Arbeitsrecht, Berufsbildung],
  [Besondere Regeln zum Lehrvertrag.],

  [*Art. 347a OR*],
  [Handelsreisenden#(soft-hyphen)vertrag],
  [Arbeitsrecht],
  [Besondere Regeln für Handelsreisende.],

  [*Art. 351a OR*],
  [Heimarbeits#(soft-hyphen)vertrag],
  [Arbeitsrecht],
  [Besondere Regeln zur Heimarbeit.],

  [*Art. 356c OR*],
  [Gesamtarbeits#(soft-hyphen)vertrag],
  [Arbeitsrecht],
  [Schriftform des Gesamtarbeitsvertrags.],

  [*Art. 361 OR*],
  [Absolut zwingende Bestimmungen],
  [Arbeitsrecht],
  [Von diesen Bestimmungen darf nicht abgewichen werden.],

  [*Art. 362 OR*],
  [Relativ zwingende Bestimmungen],
  [Arbeitsrecht],
  [Abweichung nur zugunsten des Arbeitnehmers zulässig.],
)

== Werkvertrag
#gesetz-table(
  [*Art. 363 OR*],
  [Werkvertrag],
  [Werkvertrag, IT-Verträge],
  [Unternehmer erstellt oder verändert ein Werk gegen Vergütung.],

  [*Art. 365 OR*],
  [Stoff / Anzeigepflicht],
  [Werkvertrag],
  [Unternehmer muss auf untauglichen Stoff oder Baugrund hinweisen.],

  [*Art. 366 OR*],
  [Verzug vor Ablieferung],
  [Werkvertrag],
  [Besteller kann bei Verzögerung oder mangelhafter Ausführung zurücktreten oder Ersatzvornahme androhen.],

  [*Art. 367 und 370 OR*],
  [Prüf- und Rügeobliegenheit],
  [Werkvertrag],
  [Bei verspäteter Prüfung oder Rüge gilt das Werk als genehmigt.],

  [*Art. 368 OR*],
  [Mängelrechte],
  [Werkvertrag],
  [Wandelung, Minderung, Nachbesserung und ggf. Schadenersatz.],

  [*Art. 371 OR*],
  [Verjährung Werkmängel],
  [Werkvertrag, Verjährung],
  [Grundsätzlich 2 Jahre, bei unbeweglichen Werken bzw. Einbau in solche 5 Jahre.],

  [*Art. 373 OR*],
  [Fixpreis],
  [Werkvertrag],
  [Vereinbarter Werklohn bleibt grundsätzlich verbindlich.],

  [*Art. 374 OR*],
  [Unklarer Preis],
  [Werkvertrag],
  [Werklohn nach Wert der Arbeit und Aufwand.],

  [*Art. 375 OR*],
  [Kosten#(soft-hyphen)überschreitung],
  [Werkvertrag],
  [Bei unverhältnismässiger Überschreitung eines ungefähren Kostenansatzes bestehen Rücktritts- oder Herabsetzungsrechte.],

  [*Art. 377 OR*],
  [Rücktritt vor Vollendung],
  [Werkvertrag],
  [Besteller kann zurücktreten, muss aber Arbeit und Schaden ersetzen.],
)

== Auftrag
#gesetz-table(
  [*Art. 394 OR*],
  [Einfacher Auftrag],
  [Auftrag, IT-Verträge],
  [Tätigwerden im fremden Interesse; Erfolg ist nicht geschuldet.],

  [*Art. 398 OR*],
  [Sorgfalts- und Treue#(soft-hyphen)pflicht],
  [Auftrag],
  [Getreue und sorgfältige Ausführung; Haftung bei Verschulden.],

  [*Art. 400 OR*],
  [Rechenschaft / Heraus#(soft-hyphen)gabe],
  [Auftrag],
  [Beauftragter muss Auskunft geben und Erlangtes herausgeben.],

  [*Art. 404 OR*],
  [Jederzeitige Be#(soft-hyphen)endigung],
  [Auftrag],
  [Widerruf oder Kündigung jederzeit möglich; bei Unzeit Schadenersatz.],

  [*Art. 406a OR*],
  [Partnerschafts#(soft-hyphen)vermittlung],
  [Auftrag],
  [Ehe- oder Partnerschafts#(soft-hyphen)vermittlung gegen Vergütung.],

  [*Art. 412 OR*],
  [Mäklervertrag],
  [Auftrag],
  [Nachweis oder Vermittlung einer Vertrags#(soft-hyphen)gelegenheit gegen Vergütung.],

  [*Art. 418a OR*],
  [Agenturvertrag],
  [Auftrag],
  [Dauernde Vermittlung oder Abschluss von Geschäften ohne Arbeitsverhältnis.],
)

== ZGB
#gesetz-table(
  [*Art. 1 ZGB*],
  [Anwendung des Rechts],
  [ZGB],
  [Gesetz, Gewohnheitsrecht und richterliche Regelbildung.],

  [*Art. 2 ZGB*],
  [Treu und Glauben],
  [ZGB, OR AT],
  [Handeln nach Treu und Glauben; Verbot des Rechtsmissbrauchs.],

  [*Art. 3 ZGB*],
  [Guter Glaube],
  [ZGB],
  [Guter Glaube wird vermutet, solange Bösgläubigkeit nicht bewiesen ist.],

  [*Art. 4 ZGB*],
  [Gerichtliches Ermessen],
  [ZGB],
  [Entscheidung nach Recht und Billigkeit, wo das Gesetz Ermessen einräumt.],

  [*Art. 8 ZGB*],
  [Beweislast],
  [ZGB],
  [Wer Rechte aus einer Tatsache ableitet, muss diese Tatsache beweisen.],

  [*Art. 28 ZGB*],
  [Persönlichkeits#(soft-hyphen)schutz],
  [ZGB],
  [Schutz vor widerrechtlicher Persönlichkeitsverletzung.],

  [*Art. 641 ZGB*],
  [Eigentum],
  [ZGB],
  [Eigentümer kann über Sache verfügen und Einwirkungen abwehren.],

  [*Art. 934 ZGB*],
  [Besitzesschutz],
  [ZGB],
  [Regeln zum Schutz des Besitzes.],
)

== Weitere Gesetze
#gesetz-table(
  [*Art. 3 lit. d ArG*],
  [Leitende Arbeitnehmer],
  [Arbeitsrecht],
  [Leitende Arbeitnehmer sind dem Arbeitsgesetz nicht unterstellt.],

  [*Art. 9 ArG*],
  [Überzeit],
  [Arbeitsrecht],
  [Beginn der Überzeit bei Überschreitung der gesetzlichen Höchstarbeitszeit.],

  [*ArGV 1*],
  [Definitionen],
  [Arbeitsrecht],
  [Präzisierungen zu Arbeitszeit, Pausen, Ruhezeiten, Nacht- und Sonntagsarbeit sowie Behördenorganisation.],

  [*ArGV 2*],
  [Sonder#(soft-hyphen)bestimmungen],
  [Arbeitsrecht],
  [Abweichungen für bestimmte Betriebe oder Arbeitnehmergruppen.],

  [*ArGV 3*],
  [Gesundheits#(soft-hyphen)schutz],
  [Arbeitsrecht],
  [Anforderungen an Räume, Gebäude, Arbeitsplätze und Schutzausrüstung.],

  [*ArGV 4*],
  [Industrielle Betriebe],
  [Arbeitsrecht],
  [Vorschriften und Plangenehmigungsverfahren für industrielle Betriebe.],

  [*ArGV 5*],
  [Jugendarbeits#(soft-hyphen)schutz],
  [Arbeitsrecht],
  [Schutz von Jugendlichen bis zum 18. Altersjahr.],

  [*Art. 8 UWG*],
  [Missbräuchliche AGB],
  [OR AT, Verträge],
  [Schutz vor missbräuchlichen allgemeinen Geschäftsbedingungen.],

  [*Art. 162 StGB*],
  [Geschäfts#(soft-hyphen)geheimnisse],
  [Arbeitsrecht],
  [Strafbarkeit der Verletzung von Fabrikations- oder Geschäftsgeheimnissen.],

  [*Art. 1 PrHG*],
  [Produkte#(soft-hyphen)haftpflicht],
  [Haftpflicht, IT-Verträge],
  [Hersteller haftet für Schäden durch fehlerhafte Produkte.],

  [*Art. 2 PrHG*],
  [Haftpflichtige Personen],
  [Haftpflicht],
  [Hersteller, Importeur und unter Umständen Händler.],

  [*Art. 4 PrHG*],
  [Fehler#(soft-hyphen)haftigkeit],
  [Haftpflicht],
  [Produkt ist fehlerhaft, wenn es nicht die berechtigte Sicherheit bietet.],

  [*Art. 6 PrHG*],
  [Selbstbehalt],
  [Haftpflicht],
  [Sachschäden werden nur ersetzt, soweit sie CHF 900 übersteigen.],

  [*Art. 8 PrHG*],
  [Haftungs#(soft-hyphen)beschränkung],
  [Haftpflicht],
  [Haftungsbeschränkung gegenüber Geschädigten ist nichtig.],

  [*Art. 9 PrHG*],
  [Verjährung],
  [Haftpflicht],
  [Ansprüche verjähren drei Jahre ab Kenntnis von Schaden, Fehler und haftpflichtiger Person.],

  [*Art. 10 PrHG*],
  [Verwirkung],
  [Haftpflicht],
  [Anspruch erlischt spätestens zehn Jahre nach Inverkehrbringen des Produkts.],
)

Erklärungen:
- *Arbeitsgesetz (ArG):* Regelt den öffentlich-rechtlichen Arbeitnehmerschutz in Industrie, Gewerbe und Handel. Dazu gehören insbesondere Arbeitszeit, Pausen, Ruhezeiten, Nacht- und Sonntagsarbeit sowie Schutzbestimmungen.
- *Obligationenrecht (OR):* Enthält die privatrechtlichen Regeln zum Arbeitsvertrag, insbesondere Rechte und Pflichten von Arbeitgeber und Arbeitnehmer.
- *Berufsbildungsgesetz (BBG):* Regelt die Berufsbildung und ist besonders für Lehrverhältnisse relevant.
- *Öffentlich-rechtliche Personalgesetze:* Gelten für Arbeitsverhältnisse im öffentlichen Dienst, z.B. kantonale Personalgesetze.
- *Arbeitsvermittlungsgesetz (AVG):* Regelt Arbeitsvermittlung und Personalverleih.
- *Datenschutzgesetz (DSG):* Schützt Personendaten, auch im Arbeitsverhältnis.
- *Gleichstellungsgesetz (GlG):* Fördert die tatsächliche Gleichstellung von Frau und Mann.
- *Mutterschutzverordnung:* Regelt den Schutz bei gefährlichen oder beschwerlichen Arbeiten während Schwangerschaft und Mutterschaft.
- *Mitwirkungsgesetz (MWG):* Regelt die Information und Anhörung der Arbeitnehmer in Betrieben.