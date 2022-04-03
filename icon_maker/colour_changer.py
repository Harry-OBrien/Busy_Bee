import cv2
import numpy as np

# Thresholding value
t_val = 60

# Import the image
input_icon = cv2.imread("./bee_black.jpg", cv2.IMREAD_UNCHANGED)
input_icon = cv2.cvtColor(input_icon, cv2.COLOR_RGB2GRAY)

# Colours and output images
# format is BGR (NOT RGB!!!)
colours = {
    "red":np.array([64, 80, 217, 255]),
    "amber":np.array([66, 189, 242, 255]),
    "green":np.array([92, 165, 88, 255]),
    "black":np.array([0, 0, 0, 255]),
}

output_images = {
    "red": np.full((*input_icon.shape, 4), 0, dtype=np.uint8),
    "amber": np.full((*input_icon.shape, 4), 0, dtype=np.uint8),
    "green": np.full((*input_icon.shape, 4), 0, dtype=np.uint8),
    "black": np.full((*input_icon.shape, 4), 0, dtype=np.uint8)
}
# print(output_images)
                
# Swap the thresheld values for the input colours
for i, row in enumerate(input_icon):
    for j, pix in enumerate(row):
            if pix < t_val:
                for key in colours.keys():
                    output_images[key][i,j] = colours[key]
            
# Write out the images
for key, img_out in output_images.items():
    cv2.imwrite('bee_' + key +'.png', img_out)
