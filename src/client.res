module Hello = {
  @react.component
  let make = () => {
    <div> {React.string("Hello world")} </div>
  }
}

switch(ReactDOM.querySelector("#root")) {
| Some(root) => ReactDOM.render(<Hello/>, root)
| None => ()
}
