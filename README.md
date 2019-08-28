# pike-time
Analysis of pike ddRAD data for Yakutat origins

## Organization

1. Subdirectories
  + /metadata/ for storing sample information
  + /bams/ for bam files (in .gitignore)
  + /outputs/ for outputs

2. Scripts
  + Beginning with 101 and so on, will have corresponding /outputs/101/ etc.

3. Script Descriptions
  1. _101-creating-test-data.Rmd_ Downsampled data to 243 individuals to analyze.
  2. _102-subsample.sh_ Selecting the first chromosome of the *.bams to speed up analyses.
  3. 103
    1. _103.1-run-PCA.sh_ Nothing like a PCA to get an idea on the distribution of samples.
    2. _103.2-present-PCA.Rmd Let's make a multi-axis plot.
  4. _104-cluster.R_ Always a fan of clustering...
  5. _105-generate-alleles-and-alignments.Rmd_ Somehow, we should generate alleles and a phylogeny.
