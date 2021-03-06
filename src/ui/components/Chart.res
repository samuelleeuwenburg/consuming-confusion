module Styles = {
  open Emotion
  open Style
  open Style.Spacing

  let wrapper = Media.medium(
    css({
      "position": "relative",
      "maxWidth": "70%",
      "margin": "auto",
      "textAlign": "center",
    }),
  )

  let svg = cx([
    css({
      "width": "100%",
      "transform": "rotate(-90deg)",
    }),
    Media.medium(
      css({
        "width": "80%",
        "maxWidth": "600px",
      }),
    ),
  ])

  let legends = cx([
    css({
      "textAlign": "left",
      "margin": `${px(small)} 0`,
    }),
    Media.medium(
      css({
        "margin": "0",
        "position": "absolute",
        "bottom": "0",
        "left": "92%",
        "width": "320px",
      }),
    ),
  ])

  let legend = color =>
    css({
      "background": color,
      "height": "20px",
      "width": "20px",
      "marginRight": px(small),
      "display": "inline-block",
      "position": "relative",
      "top": "6px",
      "border": `1px solid ${Colors.colorLight}`,
    })
}

type slice = {
  value: float,
  name: string,
}

let colors = [
  "#FBFFFE",
  "#F0ECE8",
  "#C7B7A9",
  "#4A3D30",
  "#251F18",
  "#EFEFEF",
  "#BFBFBF",
  "#535353",
  "#373737",
]

let getCoordinates = percent => {
  let x = Js.Math.cos(2. *. Js.Math._PI *. percent)
  let y = Js.Math.sin(2. *. Js.Math._PI *. percent)
  (x, y)
}

@react.component
let make = (~data: array<slice>) => {
  let total = data->Belt.Array.reduce(0., (t, s) => t +. s.value)

  let (_, paths) = data->Belt.Array.reduceWithIndex((0.0, []), ((pos, elements), slice, index) => {
    let percentage = slice.value /. total
    let nextPos = pos +. percentage
    let (x1, y1) = getCoordinates(pos)
    let (x2, y2) = getCoordinates(nextPos)

    let largeArcFlag = if percentage > 0.5 {
      "1"
    } else {
      "0"
    }

    let d = `M ${x1->Belt.Float.toString} ${y1->Belt.Float.toString} A 1 1 0 ${largeArcFlag} 1 ${x2->Belt.Float.toString} ${y2->Belt.Float.toString} L 0 0`
    let fill = colors->Belt.Array.get(index)->Belt.Option.getWithDefault("#000000")
    let element = <path key={slice.name} d={d} fill={fill} />

    (nextPos, elements->Belt.Array.concat([element]))
  })

  let legends = data->Belt.Array.mapWithIndex((index, slice) => {
    let color = colors->Belt.Array.get(index)->Belt.Option.getWithDefault("#000000")

    <div key={slice.name}>
      <div className={Styles.legend(color)} /> {React.string(slice.name)}
    </div>
  })

  <div className={Styles.wrapper}>
    <svg className={Styles.svg} viewBox="-1 -1 2 2"> {React.array(paths)} </svg>
    <div className={Styles.legends}> {React.array(legends)} </div>
  </div>
}
