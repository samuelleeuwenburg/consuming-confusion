open Emotion

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
  let px = n => `${n->Belt.Float.toString}px`

  let tiny = Js.Math.pow_float(~base=2., ~exp=3.)
  let small = Js.Math.pow_float(~base=2., ~exp=4.)
  let medium = Js.Math.pow_float(~base=2., ~exp=5.)
  let large = Js.Math.pow_float(~base=2., ~exp=6.)
  let huge = Js.Math.pow_float(~base=2., ~exp=7.)
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
    font-size: 16px;
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
