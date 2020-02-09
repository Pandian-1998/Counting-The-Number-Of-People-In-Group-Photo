CODE:
I=imread(’15.jpg’);
imshow(I),title(’Image:1’);
cform = makecform(’srgb2lab’);
J=applycform(I,cform);
figure;imshow(J),title(’Image:2’);
K=J(:,:,2);
figure;imshow(K),title(’Image:3’);
L=graythresh(J(:,:,2));
BW1=im2bw(J(:,:,2),L);
figure;imshow(BW1),title(’Image:4’);
bw2=imfill(BW1,’holes’);
figure;imshow(bw2)
bw3 = bwareaopen(bw2,1890);
cc=bwconncomp(bw3)
density=cc.NumObjects / (size(bw3,1) * size(bw3,2))
27
figure;imshow(bw3)
labeledImage = bwlabel(bw3, 8);
figure;imshow(labeledImage)
blobMeasurements = regionprops(labeledImage,’all’)
numberOfPeople = size(blobMeasurements, 1)
imagesc(I);
hold on;
title(’Original with bounding boxes’);
for k = 1 : numberOfPeople
thisBlobsBox = blobMeasurements(k).BoundingBox;
x1 = thisBlobsBox(1);
y1 = thisBlobsBox(2);
x2 = x1 + thisBlobsBox(3);
y2 = y1 + thisBlobsBox(4);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
plot(x, y, ’LineWidth’, 2);
end
