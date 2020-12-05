%specify filepath of input files
filepath = '/users/marianne/downloads/data4hayden';
for n=2010:2016 %years to clip
    clipswe(filepath, n)
end
%output will be .mat and .tiff files clipped to Providence watershed
%each layer is a day of the water year (WY starts Oct 1)