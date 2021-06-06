open Common

@react.component
let make = () => {
  <>
    <H1> <Em> {React.string("Consuming Confusion")} </Em> </H1>
    <P>
      {React.string("This website is a dissemination from the eponymous research consuming confusion, the complex story on sustainable consumption.
Consuming Confusion is a research that centralises the concept confusion within fashion communication regarding sustainable consumption. 
")}
    </P>
    <P>
      {React.string("The Consuming Confusion website questions the indiscriminate implementation of sustainability in a regular webshop format. The website acts as a publication with the aim to activate the visitor, to let them think through questions, participation and visualizations of my research.
")}
    </P>
    <P>
      {React.string("A more in depth story is available for free. You can request my master thesis that offers a more in depth story on confusion within sustainable fashion communication regarding consumption. Which provides more insight into confusion regarding ethical consumption, the role of politics, the internalised guilt, the multiple realities and the definition of sustainability. At last the fashion industry and the use of confusion as a tool, including a more in depth explanation of the tooling. 
")}
    </P>
    <P>
      <a href="#"> {React.string("Request free online essay")} </a>
      <br />
      <a href="#"> {React.string("Request printed version €15 (printed on demand)")} </a>
      <br />
    </P>
    <P>
      {React.string("Consuming Confusion")}
      <br />
      {React.string("The Complexity of Sustainable Consumption.")}
      <br />
      {React.string("Written by Julia Berg")}
    </P>
  </>
}
