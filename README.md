# MCILBoost
[Project](https://www.cs.cmu.edu/~junyanz/projects/MCIL/) | [CVPR Paper](https://www.cs.cmu.edu/~junyanz/projects/MCIL/cvpr12_mcil.pdf) | [MIA Paper](https://www.cs.cmu.edu/~junyanz/projects/MCIL/mia14_mcil.pdf)<br>
Contact: [Jun-Yan Zhu](https://www.cs.cmu.edu/~junyanz/) (junyanz at cs dot cmu dot edu)


## Overview
This is the authors' implementation of MCIL-Boost method described in:  
[1] Multiple Clustered Instance Learning for Histopathology Cancer Image Segmentation, Clustering, and Classification.  
Yan Xu\*, Jun-Yan Zhu\*, Eric Chang, and Zhuowen Tu (\*equal contribution)  
In IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2012.

[2] Weakly Supervised Histopathology Cancer Image Segmentation and Classification  
Yan Xu, Jun-Yan Zhu, Eric I-Chao Chang, Maode Lai, and Zhuowen Tu  
In Medical Image Analysis, 2014.

Please cite our papers if you use our code for your research.  

This package consists of the following two multiple-instance learning (MIL) methods:
* MIL-Boost [Viola et al. 2006]: set c = 1
* MCIL-Boost [1] [2]: set c &gt; 1

The core of this package is a command-line interface written in C++. Various Matlab helper functions are provided to help users easily train/test MCIL-Boost model, perform cross-validation, and evaluate the performance.




## System Requirement
* Linux and Windows.
* For Linux, the code is compiled by gcc 4.8.2 under Ubuntu 14.04.


## Installation
* Download and unzip the code.
  - For Linux users, type "chmod +x MCILBoost".
* Open Matlab and run "demoToy.m".
* To use the command-line interface, see "Command Usage".
* To use Matlab functions, see "Matlab helper functions"; You can modify "SetParamsToy.m" and "demoToy.m" to run your own experiments.


## Quick Examples
(Windows: MCILBoost.exe; Linux: ./MCILBoost)  
An example for training:  
MCILBoost.exe -v 2 -t 0 -c 2 -n 150 -s 0 -r 20 toy.data toy.model  
An example for testing:  
MCILBoost.exe -v 2 -t 1 -c 2 toy.data toy.model toy.result



## Command Usage ([ ]: options)
MCILBoost.exe [-v verbose] [-t mode] [-c #clusters] [-n #weakClfs] [-s softmax] data_file model_file [result_file]
(No need to specifiy c, n, s, r for test as the program will copy these parameters from the model_file)

-v verbose: shows details about the runtime output (default = 1)
	0 -- no output
	1 -- some output
	2 -- more output

-t mode:    set the training mode (default=0)
	0 -- train a model
	1 -- test a model

-c #clusters: set the number of clusters in positive bags (default = 1)
        c = 1 -- train a MIL-Boost model
        c &gt; 1 -- train a MCIL-Boost model with multiple clusters

-n #weakClfs: set the maximum number of weak classifiers (default = 150)

-s softmax: set the softmax type: (default s = 0)
	0 -- GM
	1 -- LSE

-r exponent: set the exponent used in GM and LSE (default r = 20)

data_file: set the path for input data.

model_file: set the path for the model file.

result_file: set the path for result file. If result_file is not specified, result_file = data_file + '.result'


## Matlab helper functions
* **MCILBoost.m**: main entry function: model training/testing, and cross-validation.
* **SetParams.m**: Set parameters for MCILBoost.m. You need to modify this file to run your own experiment.
* **TrainModel.m**: train a model, call MCIL-Boost command line.
* **TestModel.m**: test a model, call MCIL-Boost command line.
* **CrossValidate**.m: split the data into n-fold, perform n-fold cross-validation, and report performance.
* **ReadData.m**: read Matlab data from a text file.
* **WriteData.m**: write Matlab data to a text file.
* **ReadResult.m**: read Matlab result data from a text file.
* **MeasureResult.m**: evaluate performance in terms of accuracy and auc (area under the curve).
* **AUC**: compute the area under ROC curve given prediction and ground truth labels.
* **demoToy.m**: demo script for toy data.
* **SetParamsToy.m**: set parameters for demoToy.
* **demo1.m**: demo script for Fox, Tiger, Elephant experiment.
* **SetParamsDemo1.m**: set parameters for demo1.
* **demo2.m**: demo script for SIVAL experiment.
* **SetParamsDemo2.m**: set parameters for demo2.


## Summary of Benchmark Results
* I provide two scripts for running experiments on publicly available MIL benchmarks.
  - "demo1.m": experiments on Fox, Tiger, Elephant dataset.  
The MIL-Boost achieved **0.61** (Fox), **0.81** (Tiger), **0.82** (Elephant) on 10-fold cross-validation over 10 runs.
  - "demo2.m": experiments on SIVAL dataset.
There are 180 positive bags (3 clusters), and 180 negative bags. While multiple clusters appear in positive bags, MCIL-Boost works better than MIL-Boost does.  
MIL-Boost  (c=1):  mean_acc = **0.742**, mean_auc = **0.824**  
MCIL-Boost (c=3):  mean_acc = **0.879**, mean_auc = **0.944**  
* Note: See "demo1.m" and "demo2.m" for details.


## Input Format
* Note: You can use Matlab function "ReadData.m" and "WriteData.m" to read/write Matlab data from/to the text file.
* Description: the input format is similar to the format used in LIBSVM and MILL package. The software also supports a sparse format.
In the first line, you first need to specify the number of all instances, and the number of feature dimensions.
Each line represents one instance, which has an instance id, bag id, and the label id (&gt;= 1 for positive bags, and 0 for negative bags). Each feature value is represented as a &lt;index&gt;:&lt;value&gt; pair where &lt;index&gt; is the index of the feature (starting from 1)
* Format:
&lt;the total number of instances&gt; &lt;number of feature dimensions&gt;  
&lt;instanceId0&gt;:&lt;bagId0&gt;:&lt;label0&gt; &lt;index&gt;:&lt;value&gt; &lt;index&gt;:&lt;value&gt; ...  
&lt;instanceId1&gt;:&lt;bagId1&gt;:&lt;label1&gt; &lt;index&gt;:&lt;value&gt; &lt;index&gt;:&lt;value&gt; ...  
* Example: A toy example that contains two negative bags and two positive bags. (see "toy.data") The negative instance is always (0, 0, 0) while there are two clusters of positive instances (0, 1, 0) and (0, 0, 1)  
8 3  
0:0:0 1:0 2:0 3:0  
1:0:0 1:0 2:0 3:0  
2:1:0 1:0 2:0 3:0  
3:1:0 1:0 2:0 3:0  
4:2:1 1:0 2:1 3:0  
5:2:1 1:0 2:0 3:0  
6:3:1 1:0 2:0 3:1  
7:3:1 1:0 2:0 3:0  


## Output Format
* Note: You can use Matlab function "ReadResult.m" to load the Matlab data from the result file.
* Description:
The software outputs four kinds of predictions (see more details in the paper):
  - overall bag-level prediction p_i (the probability of the bag x_i being positive bag)
  - cluster-wise bag-level prediction p_i^k (the probability of the bag x_i belonging to k-th cluster)
  - overall instance-level prediction p_{ij} (the probability of the instance x_{ij} being positive instance)
  - cluster-wise instance-level prediction p_{ij}^k (the probability of the instance x_{ij} belonging to the k-th cluster)
  - In the first line, the software outputs the number of bags, and the number of clusters. Then for each bag, the software outputs the bag-level information and prediction (bag id, number of instances, ground truth label, number of clusters, and p_i).The software also outputs the bag-level prediction for each cluster (cluster id and prediction p_i^k for each cluster). Then for each instance, the software outputs the instance-level prediction (instance id and prediction p_{ij}) and instance-level prediction for each cluster (cluster_id and prediction p_{ij}^k)
* Format:  
&#35;bag=&lt;number of bags&gt; &#35;cluster=&lt;number of clusters&gt;  
bag_id=&lt;bag Id 0&gt; &#35;insts=&lt;number of instances in bag0&gt; label=&lt;ground truth label&gt; &#35;cluster=&lt;number of clusters&gt; pred=&lt;bag-level prediction&gt;  
cluster_id=&lt;cluster Id 0&gt;  pred=&lt;bag-level prediction of cluster 0&gt; cluster_id=&lt;cluster Id 1&gt; pred=&lt;bag-level prediction of cluster 1&gt; ...  
inst_id=&lt;instance id 0&gt; pred=&lt;Instance-level prediction 0&gt; cluster_id=&lt;cluster Id 0&gt;  pred=&lt;instance-level prediction of cluster 0&gt; cluster_id=&lt;cluster Id 1&gt;   pred=&lt;instance-level prediction  of cluster 1 ...  
inst_id=&lt;instance id 1&gt; pred=&lt;Instance-level prediction 1&gt; cluster_id=&lt;cluster Id 0&gt;  pred=&lt;instance-level prediction of cluster 0&gt; cluster_id=&lt;cluster Id 1&gt;   pred=&lt;instance-level prediction of cluster 1&gt; ...  
...
* Example: The output of the toy example:  
  &#35;bags=4 &#35;clusters=2  
  bag_id=0 #insts=2 label=0 #clusters=2 pred=0  
  cluster_id=0 pred=0 cluster_id=1 pred=0  
  inst_id=0 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  
  inst_id=1 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  
  bag_id=1 #insts=2 label=0 #clusters=2 pred=0  
  cluster_id=0 pred=0 cluster_id=1 pred=0  
  inst_id=0 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  
  inst_id=1 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  
  bag_id=2 #insts=2 label=1 #clusters=2 pred=1  
  cluster_id=0 pred=1 cluster_id=1 pred=0  
  inst_id=0 pred=1 cluster_id=0 pred=1 cluster_id=1 pred=0  
  inst_id=1 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  
  bag_id=3 #insts=2 label=1 #clusters=2 pred=1  
  cluster_id=0 pred=0 cluster_id=1 pred=1  
  inst_id=0 pred=1 cluster_id=0 pred=0 cluster_id=1 pred=1  
  inst_id=1 pred=0 cluster_id=0 pred=0 cluster_id=1 pred=0  

  ## Credit
  Part of this code is based on the work by Piotr Dollar and Boris Babenko.
