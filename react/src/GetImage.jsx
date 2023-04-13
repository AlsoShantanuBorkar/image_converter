import React, { useState } from "react";

export default function GetImage() {
  const [image, setImage] = useState(null);

  const [base64Image, setBase64Image] = useState("");

  async function handleImageUpload(event) {
    onImageChange(event);

    const file = event.target.files[0];

    const reader = new FileReader();
    reader.readAsDataURL(file);

    reader.onload = () => {
      const prefix = "data:image/jpeg;base64,";
      var str = reader.result;
      if (str.startsWith(prefix)) {
          str = str.substring(prefix.length);
          setBase64Image(str);
          console.log(str);
      }
    };
  }

  const onImageChange = (event) => {
    if (event.target.files && event.target.files[0]) {
      setImage(URL.createObjectURL(event.target.files[0]));
    }
  };

  return (
    <div>
      <input type="file" onChange={handleImageUpload} className="filetype" />
      <img alt="preview image" src={image} />
    </div>
  );
}
