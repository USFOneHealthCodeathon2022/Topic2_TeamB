# Topic2_TeamB
Rapid extraction of genomic data from these diseases 

<b>INTRODUCTION</b>

Navigating the landscape of genomic data can be a challenging endeavor without 
adequate computational expertise and knowledge of several different databases. An
extra layer of difficulty is added when looking for accessible genomic data for rare 
and neglected diseases because data is often scarce and dispersed among different
databases. Some of the most popular databases for genomic data include the 
Sequence Read Archive (SRA) and the Gene Expression Omnibus (GEO) of the 
National Center for Biotechnology Information (NCBI), The Cancer Genome Atlas 
(TCGA) of the National Cancer Institute and the Genetic and Rare Diseases 
Information Center (GARD) of the National Center for Advancing Translational 
Sciences (NCATS).
To make the process of identifying available data for rare and neglected diseases 
easier, we developed , RDGREx: Rare Disease Genome Data Extractor, a user-
friendly tool for quick and streamlined identification of available genomic data in 
several common databases. This software, available at , can be utilized to 
interrogate the availability of genomic data for a range of rare and neglected 
diseases in several publicly available databases. The tool can identify a range of 
different omics data types including Whole genome sequencing, whole exome 
sequencing, RNA-sequencing, ChIP-sequencing data and many more, streamline the
downloading process and also provide options for visualization. 
The input for the RDGREx search is a disease of interest. Additionally, the number of
studies to be included in the query can be specified. Ancestry information can be specificed in your search to limit your query to samples from yoru ethnic group of interest. After submission of the query, 
the user will be able to explore the meta-data associated with the search including 
a quick summary of the experiment associated with the data. Additional tabs 
include the location of the data from where it originated, the sequencing platforms 
associated with it, the Raw data, a summary and supplementary files.

<b> Rare and Neglected Diseases </b>
The current version of the RDGREx contains data on the following diseases:

Acute lymphoblastic leukemia

Acute promyelocytic leukemia

Adrenocortical carcinoma

Beta thalassemia

Ehlers-Danlos syndrome

Friedreich ataxia

Glioblastoma

Hodgkin lymphoma

Huntington's disease

Klienefelter Syndrome

Leigh Syndrome

Mantle cell pymphoma

Multiple myeloma

Pituitary Cancer

Prader-Willi syndrome

Retinoblastoma

Sjogren's syndrome

Small cell lung cancer

Spinal muscular atrophy

Turner Syndrome

Williams syndrome

Xeroderma pigmentosum

<b>RDGREx: Rare Disease Genome Data Extractor </b>

<img width="1440" alt="Screen Shot 2022-03-01 at 2 55 46 PM" src="https://user-images.githubusercontent.com/100782707/156402061-4fdd92e0-417b-43d8-b3e3-dc9efa358653.png">
Once a disease has been selected, the desired data can be downloaded and used. 
  
<b> Structure of RDGREx </b>

RDGREx consists of a web interface.

<b>PREREQUISITIES</b>

R


<b>Future Directions </b>

This software has the potential to be improved by:

-expanding upon the diseases in the database

-allowing the user to filter search results based on data method (RNAseq, microarray, etc.)


<b> Codeathon Team Members: </b>
Agaz Wani, Jan Dahrendorff, Xochitl Diaz, and Hyacinth Burrowes
