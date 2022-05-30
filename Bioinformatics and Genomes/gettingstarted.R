
# Computational Genomics with R 
# Link: https://compgenomr.github.io/book/index.html

### ----- Packages ----- ### 

# Install and Update Bioconductor Packages
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

### Not Run!
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install(c('qvalue','plot3D','ggplot2','pheatmap','cowplot',
#                        'cluster', 'NbClust', 'fastICA', 'NMF','matrixStats',
#                        'Rtsne', 'mosaic', 'knitr', 'genomation',
#                        'ggbio', 'Gviz', 'DESeq2', 'RUVSeq',
#                        'gProfileR', 'ggfortify', 'corrplot',
#                        'gage', 'EDASeq', 'citr', 'formatR',
#                        'svglite', 'Rqc', 'ShortRead', 'QuasR',
#                        'methylKit','FactoMineR', 'iClusterPlus',
#                        'enrichR','caret','xgboost','glmnet',
#                        'DALEX','kernlab','pROC','nnet','RANN',
#                        'ranger','GenomeInfoDb', 'GenomicRanges',
#                        'GenomicAlignments', 'ComplexHeatmap', 'circlize', 
#                        'rtracklayer', 'BSgenome.Hsapiens.UCSC.hg38',
#                        'BSgenome.Hsapiens.UCSC.hg19','tidyr',
#                        'AnnotationHub', 'GenomicFeatures', 'normr',
#                        'MotifDb', 'TFBSTools', 'rGADEM', 'JASPAR2018'
# ))

devtools::install_github("compgenomr/compGenomRData")


### ----- End ----- ### 
