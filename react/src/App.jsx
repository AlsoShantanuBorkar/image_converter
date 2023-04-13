import "./App.css";
import str from "./Base64String";
import Base64Image from "./Base64Image";
import GetImage from "./GetImage";
function App() {
  const base64String = str;
  return (
    <>
      <Base64Image base64={base64String} />
      
      {/* <GetImage /> */}
    </>
  );
}

export default App;
