import React, { useState, useEffect } from "react";
import { Buffer } from "buffer";

export default function Base64Image({ base64 }) {
  const [imageSrc, setImageSrc] = useState(null);
  useEffect(() => {
    const data = base64;
    if (data) {
      const binaryData = Buffer.from(data, "base64");

      const arrayBuffer = new ArrayBuffer(binaryData.length);
      const uint8Array = new Uint8Array(arrayBuffer);
      for (let i = 0; i < binaryData.length; i++) {
        uint8Array[i] = binaryData[i];
      }
      const blob = new Blob([uint8Array], { type: "image/jpeg" });
      setImageSrc(URL.createObjectURL(blob));
    }
  }, [base64]);

  return <img src={imageSrc} alt="Base64 Image" />;
}
