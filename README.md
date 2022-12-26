# Bioengineering Case Study

## Step 1: Problem Identification and Statement
The aim is to design a software that processes Electrocardiography (ECG) signals from standardized
medical datasets and uses them to derive relevant diagnostic information to estimate when an apnea is
occurring.

## Step 2: Gathering of Information and Input/output Description
### Relevant information:
Sleep apnea (SA) is a ubiquitous sleep-related respiratory disease. It can occur hundreds of times
at night, and its long-term occurrences can lead to some serious cardiovascular and neurological
diseases. Polysomnography (PSG) is a commonly used diagnostic device for SA. But it requires
suspected patients to sleep in the lab for one to two nights and records about 16 signals through
expert monitoring. The complex processes hinder the widespread implementation of PSG in
public health applications. Recently, some researchers have proposed using a single-lead ECG
signal for SA detection. The diagnosis of sleep apnea is difficult, and it often involves a trained
medical staff to watch overnight the sleep cycle of a patient. Developing systems that can allow
the diagnosis of sleep apnea in a cost effective is therefore crucial. The direct measurement of
chest movement tends to carry high noise given the similar frequency of other body movements,
making this technique ineffective. However, the potential to use heart arrythmia to detect apnea
events is a promising approach. ECG signals are one of the most feature rich and non-intrusive
ways to detect various cardiac disorders. Cost effective and powerful embedded ECG devices are
now widely available. Additionally, a lot of research has been carried into determining the
relationship between apnea events and heart rate.

Breathing monitoring is an essential diagnostic tool and a crucial safety measure when high risk
apnea is present. Direct monitoring of breathing is not always possible, hence secondary sources
of information, such as heart arrythmia (unexpected heart rate changes) are essential to track
apnea events.

### APNEA ECG DATABASE
The data consist of 70 records, divided into a learning set of 35 records (a01 through a20, b01
through b05, and c01 through c10), and a test set of 35 records (x01 through x35).
Recordings vary in length from slightly less than 7 hours to nearly 10 hours each. Each recording
includes a continuous digitized ECG signal, a set of apnea annotations (derived by human
experts on the basis of simultaneously recorded respiration and related signals), and a set of
machine-generated QRS annotations (in which all beats regardless of type have been labeled
normal). In addition, eight recordings (a01 through a04, b01, and c01 through c03) are
accompanied by four additional signals (Resp C and Resp A, chest and abdominal respiratory
effort signals obtained using inductance plethysmography; Resp N, oronasal airflow measured
using nasal thermistors; and SpO2, oxygen saturation).

### DIFFERENT TYPES OF FILE EXTENSIONS AND THEIR USES
- The files with names of the form rnn.dat contain the digitized ECGs (16 bits per sample,
least significant byte first in each pair, 100 samples per second, nominally 200 A/D units
per millivolt).
- The .hea files are (text) header files that specify the names and formats of the associated
signal files; these header files are needed by the software available from this site.
- The .apn files are (binary) annotation files, containing an annotation for each minute of
each recording indicating the presence or absence of apnea at that time; these are
available for the 35 learning set recordings only.
- The qrs files are machine-generated (binary) annotation files, made using sqrs125, and
provided for the convenience of those who do not wish to use their own QRS detectors.

### HEADER FILE INFORMATIONS
a01.hea
1. sampling frequency = 100
2. number of datapoints = 2957000
3. number of bits per value = 16
4. conversion rate to voltage = 200

a02.hea
1. sampling frequency = 100
2. number of datapoints = 3182000
3. number of bits per value = 16
4. conversion rate to voltage = 200

a03.hea
1. sampling frequency = 100
2. number of datapoints = 3135000
3. number of bits per value = 16
4. conversion rate to voltage = 200

a04.hea
1. sampling frequency= 100
2. number of datapoints = 2980000
3. number of bits per value = 16
4. conversion rate to voltage = 200

### PROGRAM BUILDING
This program uses many matlab functions to generate the results, they are:
1. load()
2. plot(), title(), xlabel(), ylabel(), legend()
3. resample()
4. designfilt(), filter()
5. mean(), max(), min()
6. length()
7. fft()
8. abs()
9. pcolor()

#### Works Cited:
Apnea-ECG Database v1.0.0 (physionet.org)

## Input/output Description:
The inputs are:
- a01.txt file
- a02.txt file
- a03.txt file
- a04.txt file
- Time
- ECG Data

The outputs are:
- Graph of two seconds of data before and after resampling
- Graph of the signal before and after filtering for two seconds of data
- Graph of the average heart rate values against time for the 4 hours of data
- Graph of frequency versus power
- Graph of spectrogram of the signal
- generate labels for apnea (A) and not apnea (N)
