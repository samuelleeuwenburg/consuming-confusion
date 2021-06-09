open Common

@react.component
let make = () => {
  <>
    <H1> {React.string("Starting ")} <Em> {React.string("Consuming Confusion")} </Em> </H1>
    <P>
      {React.string(
        "My name is Julia Berg. I'm a (graphic) designer and researcher. The website is the result of my research on communication regarding sustainable fashion consumption.",
      )}
    </P>
    <P>
      {React.string(
        "This research started with my search for value. As a graphic designer, I sold prints and services that were always criticized for their price. I saw the same thing happening with consumer goods, no one really seemed to appreciate things. People buy products and throw them away. At the time nothing seemed to be valued. I wondered; what is value and how do I create value? As a graphic designer you are involved in communication, simplifying and visualizing complex matter. I wondered what my role was regarding the creation of value? I decided to enroll at MA Fashion Strategy to change the consumer gaze. The start of my research started off with questions such as; How can I create value? How can I change the gaze of the consumer? Why are we as consumers confused and cannot we make the right choice? Instead of finding answers I came across another story. A story of confusion; Are we confused? Or are we being confused? Who benefits from this confusion? Who is involved in sharing this confusion? Why do I feel responsible? Why are we made responsible? I ended up in a complex story of confusion, where many factors play into each other. And the role of communication was used to create consumption. I felt intrinsically compelled to share this story. As I believe that the importance of confusion addresses needs to be in relation to sustainable development. ",
      )}
    </P>
    <P>
      {React.string(
        "I graduated with a research and few dissemination; A written essay, a website, but also a toolkit. This toolkit is a collection of design principles from my research into confusion and the techniques fashion uses to create consumption. From these confusing techniques I have created new tools for reconnection. Which I would use in the future of practice to help truefull practitioners. Constructing new projects with the aim of reducing confusion and increasing value creation. ",
      )}
    </P>
    <P>
      {React.string("For questions or collaborations - ")}
      <a href="mailto:info@juliaberg.nl"> {React.string("info@juliaberg.nl")} </a>
      <br />
      {React.string("For other work - ")}
      <a href="https://juliaberg.nl/" target="_blank"> {React.string("www.juliaberg.nl")} </a>
      <br />
    </P>
    <P>
      {React.string("The entire website is open source ")}
      <a href="https://github.com/samuelleeuwenburg/consuming-confusion/" target="_blank">
        {React.string("(view source code)")}
      </a>
    </P>
    <P>
      {React.string("Colophon")}
      <br />
      {React.string("This website is part of a broader research into Consuming Confusion.")}
      <br />
      {React.string("Where I have enjoyed working with: ")}
      <br />
      {React.string("Samuel Leeuwenburg : Webdevelopment ")}
      <br />
      {React.string("Aliki van der kruijs: Advice ")}
      <br />
      {React.string("Charlotte Verdegaal : Advice ")}
      <br />
      {React.string("Femke de Vries: Advice ")}
      <br />
      {React.string("Lindy Boerman : Advice ")}
      <br />
      {React.string("Tim Giesen : Text editor ")}
      <br />
    </P>
  </>
}
