#convert pnm (pmm) format to tif/tiff and set actual ppi
#requires imagemagick
#convert -units PixelsPerInch <image.file> -density <resolution ppi> <output.file>
for f in *.pnm; do
convert -units PixelsPerInch "$f" -density 600 "$f".tif;
done
