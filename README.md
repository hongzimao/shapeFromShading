HKUST COMP 5421 Spring 2014 Computer Vision Project 4
Shape from Shading
================

The main approach and algorithm are summerized and descibed in **Note.pdf** inside *Note* folder. 

The sample output results are in wiki page. 

Main algorithm is from Tai-Pang Wu and Chi-Keung Tang, **Dense Photometric Stereo Using a Mirror Sphere and Graph Cut**, *IEEE Computer Society Conference on Computer Vision and Pattern Recognition* (2005) pp 140-147.

Graph Cut Fold-Fulkerson maxflow algorithm toolbox downloaded from *http://vision.ucla.edu/~brian/gcmex.html*

Shape from shapelet reconstruction is from Peter Kovesi, **Shapelets Correlated with Surface Normals Produce Surfaces**. *IEEE International Conference on Computer Vision*. (2005) pp 994-1001. Toolbox downloaded from *http://www.csse.uwa.edu.au/~pk/Research/MatlabFns/*

================

Get started: Inside **preProcessData.m**, change the directory of input data, set the image size appropriately, and copy the light source direction file into code folder.

Compile the mex file.

Load *lightvec.txt*

<code>surfaceNormal = initialNormal(VarName1, VarName2, VarName3);</code> This will take around 1-2 minutes.

<code>refineNormal = graphCutSurfaceNormal(surfaceNormal);</code> This will take quite a long time. 

Use <code>lightImg = diffuseLight(surfaceNormal);</code> or <code>lightImg = diffuseLight(refineNormal);</code> to check N-L image result.

Use <code>recsurf = shapeFromShapelets(surfaceNormal);</code> or <code>recsurf = shapeFromShapelets(refineNormal);</code> to check 3D reconstruction result.
