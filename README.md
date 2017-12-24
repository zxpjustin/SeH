# SeH
Regularized Semi-NMF for Hashing

Learning with NMF (Non-negative Matrix Factorization) has significantly benefited large numbers of fields such as information retrieval, computer vision, natural language processing, biomedicine \& neuroscience etc. However, little research (with NMF) has scratched hashing, which is a sharp sword in approximately nearest neighbors search for economical storage and efficient hardware-level XOR operations. To explore more, we propose a novel hashing model, called Regularized \underline{Se}mi-NMF for \underline{H}ashing (SeH), which is a minimal optimization between Semi-NMF, semantics preserving and efficient coding. Tricks as balance codes, binary-like relaxation and stochastic learning are employed to yield efficient algorithms which raise the capabilities to deal with large-scale dataset. SeH is shown to evidently improve retrieval effectiveness over some state-of-the-art baselines on several public datasets (MSRA-CFW, Caltech256, Cifar10, and ImageNet) with different sample-scales and feature representations. Furthermore, a case study on Caltech256, i.e. three image queries are randomly selected and the corresponding search results are presented, would intuitively exhibits which method is better.


## Usage

To help others using our codes conveniently, we provide a implementation instance named <code>SeH_demo.m</code> which can be directly run. 
In this instance, all default hyper-parameters are set in accordance with the paper 'Regularized Semi-Nonnegative Matrix Factorization for Hashing'. 
The function <code>doTrain.m</code> and <code>doTest.m</code> are used in the training stage and testing stage respectively for SeH, while the <code>doTrain_RS.m</code> is used for PSeH which uses random sampling strategy and applies to the large-scale datasets.


In addition, we provide a typical public dataset <code>Caltech256 (cnn_1024d_Caltech-256.mat)</code> which was represented as 1024-dimensional CNN features with single labels. 


## Paper URL

http://ieeexplore.ieee.org/document/8115178/











