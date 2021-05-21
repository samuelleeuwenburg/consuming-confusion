open Emotion

let px = n => `${n->Belt.Int.toString}px`

module Colors = {
  let colorLight = "#f0ece8"
  let colorCreme = "#d6cfc2"
  let colorDark = "#070a0c"

  let bgColorLight = colorLight
  let bgColorDark = colorDark
  let textColorDark = colorDark
  let textColorLight = colorLight
}

module Spacing = {
  let tiny = Js.Math.pow_float(~base=2., ~exp=3.)->Belt.Float.toInt
  let small = Js.Math.pow_float(~base=2., ~exp=4.)->Belt.Float.toInt
  let medium = Js.Math.pow_float(~base=2., ~exp=5.)->Belt.Float.toInt
  let large = Js.Math.pow_float(~base=2., ~exp=6.)->Belt.Float.toInt
  let huge = Js.Math.pow_float(~base=2., ~exp=7.)->Belt.Float.toInt
}

module Media = {
  let small = styles => css({"@media screen and (min-width: 720px)": styles})
  let medium = styles => css({"@media screen and (min-width: 1040px)": styles})
  let large = styles => css({"@media screen and (min-width: 1420px)": styles})
}

injectGlobal(
  `
  html {
    box-sizing: border-box;
  }

  *, *:before, *:after {
    box-sizing: inherit;
  }

  body {
    background: ${Colors.bgColorLight};
    color: ${Colors.textColorDark};
    font-size: 24px;
    line-height: 28px;
  }

  html, body, h1, h2, h3, h4, h5, h6, p, ul, ol, li, p, input, textarea {
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    font-weight: 700;
  }

  h1, h2, h3, h4, h5, h6 {
    font-family: 'Playfair Display', serif;
  }

  a {
    text-decoration: none;
    color: inherit;
  }
`,
)
