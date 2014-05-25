getdata-ucihar
==============

The measurements selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm.

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain signals.

These signals were used to estimate variables of the feature vector for each pattern:
'_xyz' is used to denote 3-axial signals in the X, Y and Z directions.

* time_bodyacc_xyz
* time_gravityacc_xyz
* time_bodyaccjerk_xyz
* time_bodygyro_xyz
* time_bodygyrojerk_xyz
* time_bodyaccmag
* time_gravityaccmag
* time_bodyaccjerkmag
* time_bodygyromag
* time_bodygyrojerkmag
* freq_bodyacc_xyz
* freq_bodyaccjerk_xyz
* freq_bodygyro_xyz
* freq_bodyaccmag
* freq_bodyaccjerkmag
* freq_bodygyromag
* freq_bodygyrojerkmag

The set of variables that were estimated from these signals are:

* mean -  Mean value
* std - Standard deviation

Additional data include:

* subject - numeric identifer for grouping data
* activity - the action being performed when measurements were taken
