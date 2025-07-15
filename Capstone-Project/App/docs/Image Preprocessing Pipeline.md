# Image Preprocessing Pipeline

Before feeding images into the plant disease classification model, several preprocessing steps are applied. The following table summarizes how each key term is handled in our application:

| **Term**      | **How it is handled in our app**                                      |
|---------------|-----------------------------------------------------------------------|
| **Range**     | Pixel values are normalized to the range [-1, 1].                     |
| **Resolution**| All images are resized to 224×224 pixels to match model input size.   |
| **Conversion**| Images are decoded, resized, and normalized before inference.         |
| **Segmentation** | Not performed; the model classifies the entire image as a whole.   |

## Explanation
- **Range:** The original pixel values (0–255) are normalized to [-1, 1] to match the model’s training requirements.
- **Resolution:** Regardless of the original image size, all images are resized to 224×224 pixels, which is the expected input size for the DenseNet121 model.
- **Conversion:** The image undergoes decoding (from file to pixel array), resizing, and normalization. No color space conversion is performed; the model expects RGB input.
- **Segmentation:** No segmentation or mask generation is performed. The model predicts a class label for the entire image. 