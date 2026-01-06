# PE-detection-code

Our approach includes the data-preprocessing and classification parts. L1-L5 denotes lobe 1 to lobe 5 as labeled in the top-right lung figure, and case 14 was used as an example. We extracted the pulmonary perfusion data from the 4DCT images by converting the CT numbers into density and further calculating the mass change in each lobe using the density. To classify the cases into positive and negative, we found the threshold for pulmonary perfusion in each lobenand used the thresholds to convert mass change data into a 1 × 5 binary matrix for each case. By summing up the binary matrix, we get the diagnostic score. Finally, we classified cases with a score > 2 as positive, < 2 as negative, and = 2 as inconclusive.

This repo includes the code for perfusion threshold optimization. Lobe segmentation can be done manually or using existing softwares. Mass change values are computed by summing HU-density values between corresponding inhale/exhale lobes. 

<img width="844" height="819" alt="overview" src="https://github.com/user-attachments/assets/3de3c2ec-6529-4eb2-9ba9-a010ac10817d" />
