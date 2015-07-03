# Chameleon Classification

Measure distinguishability between visual patterns of chameleons based on statistical classification, by using both color and grayscale images.

Installation
============
1.  Download the code.
2.  Download feature extraction code (Single-Opponent (SO) and Double-Opponent (DO)
    descriptors) from https://github.com/serre-lab/color_hmax. Place the code in the folder [root]/serre-lab-color_hmax-c2a60c1.
    Paper: https://github.com/serre-lab/color_hmax/blob/master/proof-eccv2012-color.pdf.
3.  Download Support Vector Machine (SVM) implementation code from
    https://github.com/cjlin1/liblinear (we use linlinear-1.7). Place the code in the folder [root]//liblinear-1.7.
4.  Create mex files: From matlab, run [root]/liblinear-1.7/matlab/make.m.
    Paper: http://www.csie.ntu.edu.tw/~cjlin/papers/liblinear.pdf.

Usage
=====
In matlab, run [root]/run_all.m.
The implementation is composed of four parts that repeat for both grayscale and color descriptors:
1.	Choose feature templates.
2.	Calculate the descriptors of the chameleon images.
3.	Learn a classification model for each pair of classes and measure accuracy in a
	leave-one-out manner.
4.	Show the results of six chosen classes (accuracy + p-values).

The run of parts (1)-(3) is controlled by the flags in lines 5-10. When a flag is set to 'false', the existing mat files are loaded. When the flag is set to 'true', the code generates and saves new mat files.

Note: In (1), the selection of templates is random. Hence, re-running this part can slightly change the models.
