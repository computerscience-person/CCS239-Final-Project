#let accent = color.mix(aqua, navy, maroon).saturate(75%).lighten(20%)
#let accent_alt = accent.rotate(100deg)
#let institution = "West Visayas State University"

#set text(font:"DejaVu Sans", size: 12pt, weight:"medium")
#show math.equation: set text(font:"DejaVu Math TeX Gyre", size: 1em, weight: "medium")
#show link: it => underline(offset: 1pt, stroke: 1pt + accent, text(fill: accent, it))
#set document(
  author: ("Ladores, Oliver P.", "Galvez, Khee Jay", "Billena, Dhominick John"),
  date: datetime(year: 2025, month: 12, day: 15),
  title: [NEWT'S AND RAPH'S],
)
#set page(
  header: context {
    if counter(page).get().first() > 1 {
      grid(
        align: (left, center),
        columns: (2fr, 3fr),
        text(font: "Old English Text MT", institution), document.title
      )
      stack(
        spacing: 3pt,
        line(length: 100%, stroke: (2.5pt + aqua)),
        line(length: 100%, stroke: (2.5pt + blue))
      )
    } else {
      align(center, text(font: "Old English Text MT")[#institution])
      stack(
        spacing: 3pt,
        line(length: 100%, stroke: (2.5pt + aqua)),
        line(length: 100%, stroke: (2.5pt + blue))
      )
    }
  },
  footer: context{
    stack(
      spacing: 3pt,
      line(length: 100%, stroke: (2pt + aqua)),
      line(length: 100%, stroke: (2pt + aqua))
    )
    grid(
      align: (left, left, right),
      columns: (1fr, 2fr, 1fr),
    )[CCS 239][Optimization Theory and Application][#counter(page).display("1 of 1", both: true)]
  }
)

#page(align(horizon, block(height: 40%, align(top)[
#title()

Submitted by:

#context document.author.join("\n")

Submitted on:

#context document.date.display("[month repr:long] [day], [year]")
])))

#page(outline())

= Project Overview

This project aims to implement the Newton-Raphson Method for Optimization @noauthor_newtons_2025
polynomial function $f(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + ...$, in matrix form:

$
  P_f(x) = mat(
    delim: "[",
    a_0;
    a_1;
    a_2;
    a_3;
    dots.v
  )
$

It does so by multiplying it with a matrix constructed from the size of the polynomial in matrix form, the matrix for
the derivative operation constructed being:

#figure(caption: [
  The derivative operation for polynomials, represented as a derivative.
])[$
  D_"matrix" = mat(
    delim: "[",
    0, 1, 0, 0, ...;
    , 0, 2, 0, ...;
    , , 0, 3, ...;
    , , , 0, dots.down
  )
$]

By multiplying them both, we get $f'(x)$ @lozano-robledo_derivatives_2025:

$
  P_(f'(x)) = D_"matrix" times P_f(x)
$

Evaluating the polynomial at a given point is simple, by raising $x$ elementwise to the index of the polynomial in
matrix form (the degree of each of the terms), then multiplying it to the coefficient defined in the polynomial matrix
form.

$
  f(x) = sum_(i=0)^n x^(mat(
    delim: "[",
    0; 1; 2; 3; dots.v; n
  )) compose mat(
    delim: "[",
    a_0; a_1; a_2; a_3; dots.v; a_n
  ) \

  "where " 
  
  x^(mat(
    delim: "[",
    0; 1; 2; 3; dots.v; n
  )) \

  "is the elementwise operation of raising " x " to every element from " 1 " to " n
$

#pagebreak()

= Objectives

- Develop a library that can calculate the Newton-Raphson method and other prerequisites operations (differentiation
  and polynomial evaluation).

- Provide a simple user interface that can expose the functionality of the library to a non-command line user.

- Check if the library correctly calculates the optimal values of a given function, up to tolerance.

#pagebreak()

= Showcase

#figure(image("ui1.png"), caption: [The title bar, plus the inputs for each of the terms of the polynomial.]) <ui1>

#figure(image("ui2-1.png"), caption: [Show the input function, typeset with LaTeX.]) <ui2>

#figure(image("ui3.png"), caption: [Enter initial guess and tolerance.]) <ui3>

#figure(image("ui4.png"), caption: [Display results of Newton-Raphson method for optimization]) <ui4>

#figure(image("ui5.png"), caption: [Display graph and table.]) <ui5>

#pagebreak()

= Assets

- #link("https://github.com/computerscience-person/CCS239-Final-Project")[GitHub Link]

  To run, it needs the Julia programming language, and the Pluto Julia library.

- #link("https://computerscience-person.github.io/CCS239-Final-Project/final.jl")[UI only (code will *not* run)]

#pagebreak()

= Recommendations

- Extend the solver to be able to calculate derivatives for trigonometric and exponential functions.

- Implement an os-native user interface.

#pagebreak()

#bibliography("citations.bib", style: "institute-of-electrical-and-electronics-engineers", title: [Citations])
