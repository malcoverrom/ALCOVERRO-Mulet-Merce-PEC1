Aquest informe prenten plasmar tots els passos utilitzats per a
respondre l’enunciat de la PAC 1.

### 1. Descàrrega del dataset

La selecció del dataset de metabolòmica ha estat a través del repositori
de github: <https://github.com/nutrimetabolomics/metaboData/>. He
seleccionat el repositori 2024-Cachexia:

<figure>
<img src="/Users/merce/Desktop/repositori.png"
alt="Captura del repositori triat" />
<figcaption aria-hidden="true">Captura del repositori triat</figcaption>
</figure>

Aquest dataset recull els canvis metabolòmics associats a la caquèxia,
síndrome què és caracteritza per la pèrdua severa de pes corporal,
múscul i greix. Per tant, quines són les diferències en els perfils
metabolòmics entre pacients amb caquèxia i els control? Gràcies a
explorar les diferències moleculars pordia ajudar a identificar
biomarcadors potencials per al diagnòstic o el tractament de la
malaltia.

En la descripció, se’ns proporciona la següent informació:

-   Les dades han superat les verificacions inicials

-   Les mostres no estan aparellades; fet que podria afectar a la
    interpretació dels resultats ja que les diferències observades
    podien venir de factors externs no controlats, com edat, sexe …

-   Conté dos grups diferents de mostres; els que pateixen la malaltia i
    els control.

-   El conjunt de dades són numèriques

-   No s’han detectat valors perduts

<!-- -->

    if (!require("readr", quietly = TRUE)) install.packages("readr")
    dades <- read_csv("/Users/merce/Desktop/Master/Analisis de dades òmiques. PEC1/human_cachexia.csv")

    ## Rows: 77 Columns: 65
    ## ── Column specification ──────────────────────
    ## Delimiter: ","
    ## chr  (2): Patient ID, Muscle loss
    ## dbl (63): 1,6-Anhydro-beta-D-glucose, 1-Me...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Gràcies a la funció read\_csv en el moment que es carrega el fitxer
obtenim informació; tal com el nombre de files (77) i columnes (65), el
tipus de delimitador (,), que hi ha dos variables de tipus caràcter
(patient ID i muscle loss) i què hi ha 63 columnes que són de tipus
numèric.

    str(dades)

    ## spc_tbl_ [77 × 65] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ Patient ID                : chr [1:77] "PIF_178" "PIF_087" "PIF_090" "NETL_005_V1" ...
    ##  $ Muscle loss               : chr [1:77] "cachexic" "cachexic" "cachexic" "cachexic" ...
    ##  $ 1,6-Anhydro-beta-D-glucose: num [1:77] 40.9 62.2 270.4 154.5 22.2 ...
    ##  $ 1-Methylnicotinamide      : num [1:77] 65.4 340.4 64.7 53 73.7 ...
    ##  $ 2-Aminobutyrate           : num [1:77] 18.7 24.3 12.2 172.4 15.6 ...
    ##  $ 2-Hydroxyisobutyrate      : num [1:77] 26.1 41.7 65.4 74.4 83.9 ...
    ##  $ 2-Oxoglutarate            : num [1:77] 71.5 67.4 23.8 1199.9 33.1 ...
    ##  $ 3-Aminoisobutyrate        : num [1:77] 1480.3 116.8 14.3 555.6 29.7 ...
    ##  $ 3-Hydroxybutyrate         : num [1:77] 56.83 43.82 5.64 175.91 76.71 ...
    ##  $ 3-Hydroxyisovalerate      : num [1:77] 10.1 79.8 23.3 25 69.4 ...
    ##  $ 3-Indoxylsulfate          : num [1:77] 567 369 665 412 166 ...
    ##  $ 4-Hydroxyphenylacetate    : num [1:77] 120.3 432.7 292.9 214.9 97.5 ...
    ##  $ Acetate                   : num [1:77] 126.5 212.7 314.2 37.3 407.5 ...
    ##  $ Acetone                   : num [1:77] 9.49 11.82 4.44 206.44 44.26 ...
    ##  $ Adipate                   : num [1:77] 38.1 327 131.6 144 15 ...
    ##  $ Alanine                   : num [1:77] 314 871 464 590 1119 ...
    ##  $ Asparagine                : num [1:77] 159.2 157.6 89.1 273.1 42.5 ...
    ##  $ Betaine                   : num [1:77] 110 245 117 279 392 ...
    ##  $ Carnitine                 : num [1:77] 265.1 120.3 25 200.3 84.8 ...
    ##  $ Citrate                   : num [1:77] 3714 2618 863 13630 854 ...
    ##  $ Creatine                  : num [1:77] 196.4 212.7 221.4 85.6 105.6 ...
    ##  $ Creatinine                : num [1:77] 16482 15835 24588 20952 6768 ...
    ##  $ Dimethylamine             : num [1:77] 633 608 735 1064 242 ...
    ##  $ Ethanolamine              : num [1:77] 645 488 407 821 365 ...
    ##  $ Formate                   : num [1:77] 441 252 250 469 114 ...
    ##  $ Fucose                    : num [1:77] 337 198.3 186.8 407.5 26.1 ...
    ##  $ Fumarate                  : num [1:77] 7.69 18.92 7.1 96.54 19.69 ...
    ##  $ Glucose                   : num [1:77] 395 8691 1353 863 6836 ...
    ##  $ Glutamine                 : num [1:77] 871 602 302 1686 433 ...
    ##  $ Glycine                   : num [1:77] 2039 1108 620 5064 395 ...
    ##  $ Glycolate                 : num [1:77] 685.4 652 141.2 70.8 26.6 ...
    ##  $ Guanidoacetate            : num [1:77] 154 110 183 103 53 ...
    ##  $ Hippurate                 : num [1:77] 4582 1737 4316 757 1153 ...
    ##  $ Histidine                 : num [1:77] 925 846 284 1043 327 ...
    ##  $ Hypoxanthine              : num [1:77] 97.5 82.3 114.4 223.6 66.7 ...
    ##  $ Isoleucine                : num [1:77] 5.58 8.17 9.3 37.71 40.04 ...
    ##  $ Lactate                   : num [1:77] 107 369 750 369 3641 ...
    ##  $ Leucine                   : num [1:77] 42.1 77.5 31.5 103.5 101.5 ...
    ##  $ Lysine                    : num [1:77] 146.9 284.3 97.5 290 122.7 ...
    ##  $ Methylamine               : num [1:77] 52.5 23.6 18.7 48.9 27.9 ...
    ##  $ Methylguanidine           : num [1:77] 9.97 7.69 4.66 141.17 5.31 ...
    ##  $ N,N-Dimethylglycine       : num [1:77] 23.3 87.4 24.5 40 46.1 ...
    ##  $ O-Acetylcarnitine         : num [1:77] 52.98 50.4 5.58 254.68 45.6 ...
    ##  $ Pantothenate              : num [1:77] 25.8 186.8 145.5 42.5 74.4 ...
    ##  $ Pyroglutamate             : num [1:77] 437 437 713 567 185 ...
    ##  $ Pyruvate                  : num [1:77] 21.1 37 29.4 64.1 12.3 ...
    ##  $ Quinolinate               : num [1:77] 165.7 73 192.5 86.5 38.1 ...
    ##  $ Serine                    : num [1:77] 284 392 296 1249 206 ...
    ##  $ Succinate                 : num [1:77] 154.5 244.7 142.6 144 68.7 ...
    ##  $ Sucrose                   : num [1:77] 45.1 459.4 160.8 111 75.2 ...
    ##  $ Tartrate                  : num [1:77] 97.51 32.79 16.28 837.15 4.53 ...
    ##  $ Taurine                   : num [1:77] 1920 1261 4273 1525 469 ...
    ##  $ Threonine                 : num [1:77] 184.9 198.3 110 376.1 64.1 ...
    ##  $ Trigonelline              : num [1:77] 943.9 208.5 192.5 992.3 86.5 ...
    ##  $ Trimethylamine N-oxide    : num [1:77] 2122 639 1153 1451 172 ...
    ##  $ Tryptophan                : num [1:77] 259.8 83.1 82.3 235.1 103.5 ...
    ##  $ Tyrosine                  : num [1:77] 290 167.3 60.3 323.8 142.6 ...
    ##  $ Uracil                    : num [1:77] 111 47 31.5 30.6 44.3 ...
    ##  $ Valine                    : num [1:77] 86.5 110 59.1 102.5 160.8 ...
    ##  $ Xylose                    : num [1:77] 72.2 192.5 2164.6 125.2 186.8 ...
    ##  $ cis-Aconitate             : num [1:77] 237 334 330 1863 101 ...
    ##  $ myo-Inositol              : num [1:77] 135.6 376.1 86.5 247.2 750 ...
    ##  $ trans-Aconitate           : num [1:77] 51.9 217 58.6 75.9 98.5 ...
    ##  $ pi-Methylhistidine        : num [1:77] 157.6 308 145.5 249.6 84.8 ...
    ##  $ tau-Methylhistidine       : num [1:77] 160.8 130.3 83.9 254.7 79.8 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   `Patient ID` = col_character(),
    ##   ..   `Muscle loss` = col_character(),
    ##   ..   `1,6-Anhydro-beta-D-glucose` = col_double(),
    ##   ..   `1-Methylnicotinamide` = col_double(),
    ##   ..   `2-Aminobutyrate` = col_double(),
    ##   ..   `2-Hydroxyisobutyrate` = col_double(),
    ##   ..   `2-Oxoglutarate` = col_double(),
    ##   ..   `3-Aminoisobutyrate` = col_double(),
    ##   ..   `3-Hydroxybutyrate` = col_double(),
    ##   ..   `3-Hydroxyisovalerate` = col_double(),
    ##   ..   `3-Indoxylsulfate` = col_double(),
    ##   ..   `4-Hydroxyphenylacetate` = col_double(),
    ##   ..   Acetate = col_double(),
    ##   ..   Acetone = col_double(),
    ##   ..   Adipate = col_double(),
    ##   ..   Alanine = col_double(),
    ##   ..   Asparagine = col_double(),
    ##   ..   Betaine = col_double(),
    ##   ..   Carnitine = col_double(),
    ##   ..   Citrate = col_double(),
    ##   ..   Creatine = col_double(),
    ##   ..   Creatinine = col_double(),
    ##   ..   Dimethylamine = col_double(),
    ##   ..   Ethanolamine = col_double(),
    ##   ..   Formate = col_double(),
    ##   ..   Fucose = col_double(),
    ##   ..   Fumarate = col_double(),
    ##   ..   Glucose = col_double(),
    ##   ..   Glutamine = col_double(),
    ##   ..   Glycine = col_double(),
    ##   ..   Glycolate = col_double(),
    ##   ..   Guanidoacetate = col_double(),
    ##   ..   Hippurate = col_double(),
    ##   ..   Histidine = col_double(),
    ##   ..   Hypoxanthine = col_double(),
    ##   ..   Isoleucine = col_double(),
    ##   ..   Lactate = col_double(),
    ##   ..   Leucine = col_double(),
    ##   ..   Lysine = col_double(),
    ##   ..   Methylamine = col_double(),
    ##   ..   Methylguanidine = col_double(),
    ##   ..   `N,N-Dimethylglycine` = col_double(),
    ##   ..   `O-Acetylcarnitine` = col_double(),
    ##   ..   Pantothenate = col_double(),
    ##   ..   Pyroglutamate = col_double(),
    ##   ..   Pyruvate = col_double(),
    ##   ..   Quinolinate = col_double(),
    ##   ..   Serine = col_double(),
    ##   ..   Succinate = col_double(),
    ##   ..   Sucrose = col_double(),
    ##   ..   Tartrate = col_double(),
    ##   ..   Taurine = col_double(),
    ##   ..   Threonine = col_double(),
    ##   ..   Trigonelline = col_double(),
    ##   ..   `Trimethylamine N-oxide` = col_double(),
    ##   ..   Tryptophan = col_double(),
    ##   ..   Tyrosine = col_double(),
    ##   ..   Uracil = col_double(),
    ##   ..   Valine = col_double(),
    ##   ..   Xylose = col_double(),
    ##   ..   `cis-Aconitate` = col_double(),
    ##   ..   `myo-Inositol` = col_double(),
    ##   ..   `trans-Aconitate` = col_double(),
    ##   ..   `pi-Methylhistidine` = col_double(),
    ##   ..   `tau-Methylhistidine` = col_double()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

### 2. Creació d’un contenidor del tipus SummarizedExperiment.

Amb l’objecte SummarizedExperiment es poden combinar dades i metadades
en una única estructura. El primer pas, consisteix en comprovar que el
paquet SummarizedExperiment està instal·lat i carregat.

    if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
    BiocManager::install("SummarizedExperiment")

    ## 'getOption("repos")' replaces Bioconductor
    ## standard repositories, see
    ## 'help("repositories", package =
    ## "BiocManager")' for details.
    ## Replacement repositories:
    ##     CRAN: https://cran.rstudio.com/

    ## Bioconductor version 3.20 (BiocManager
    ##   1.30.25), R 4.4.2 (2024-10-31)

    ## Warning: package(s) not installed when version(s) same
    ##   as or greater than current; use `force =
    ##   TRUE` to re-install: 'SummarizedExperiment'

    library(SummarizedExperiment)

Tal i com s’ha vist al moment de descarregar les dades, aquestes
contenen dues parts; la matriu de les dades (metabòlits) i les metadades
dels pacients. Per tant, se separen. Per tal de conèixer on estan les
columnes que contenen les metadades, s’utilitza colnames().

    colnames(dades)

    ##  [1] "Patient ID"                
    ##  [2] "Muscle loss"               
    ##  [3] "1,6-Anhydro-beta-D-glucose"
    ##  [4] "1-Methylnicotinamide"      
    ##  [5] "2-Aminobutyrate"           
    ##  [6] "2-Hydroxyisobutyrate"      
    ##  [7] "2-Oxoglutarate"            
    ##  [8] "3-Aminoisobutyrate"        
    ##  [9] "3-Hydroxybutyrate"         
    ## [10] "3-Hydroxyisovalerate"      
    ## [11] "3-Indoxylsulfate"          
    ## [12] "4-Hydroxyphenylacetate"    
    ## [13] "Acetate"                   
    ## [14] "Acetone"                   
    ## [15] "Adipate"                   
    ## [16] "Alanine"                   
    ## [17] "Asparagine"                
    ## [18] "Betaine"                   
    ## [19] "Carnitine"                 
    ## [20] "Citrate"                   
    ## [21] "Creatine"                  
    ## [22] "Creatinine"                
    ## [23] "Dimethylamine"             
    ## [24] "Ethanolamine"              
    ## [25] "Formate"                   
    ## [26] "Fucose"                    
    ## [27] "Fumarate"                  
    ## [28] "Glucose"                   
    ## [29] "Glutamine"                 
    ## [30] "Glycine"                   
    ## [31] "Glycolate"                 
    ## [32] "Guanidoacetate"            
    ## [33] "Hippurate"                 
    ## [34] "Histidine"                 
    ## [35] "Hypoxanthine"              
    ## [36] "Isoleucine"                
    ## [37] "Lactate"                   
    ## [38] "Leucine"                   
    ## [39] "Lysine"                    
    ## [40] "Methylamine"               
    ## [41] "Methylguanidine"           
    ## [42] "N,N-Dimethylglycine"       
    ## [43] "O-Acetylcarnitine"         
    ## [44] "Pantothenate"              
    ## [45] "Pyroglutamate"             
    ## [46] "Pyruvate"                  
    ## [47] "Quinolinate"               
    ## [48] "Serine"                    
    ## [49] "Succinate"                 
    ## [50] "Sucrose"                   
    ## [51] "Tartrate"                  
    ## [52] "Taurine"                   
    ## [53] "Threonine"                 
    ## [54] "Trigonelline"              
    ## [55] "Trimethylamine N-oxide"    
    ## [56] "Tryptophan"                
    ## [57] "Tyrosine"                  
    ## [58] "Uracil"                    
    ## [59] "Valine"                    
    ## [60] "Xylose"                    
    ## [61] "cis-Aconitate"             
    ## [62] "myo-Inositol"              
    ## [63] "trans-Aconitate"           
    ## [64] "pi-Methylhistidine"        
    ## [65] "tau-Methylhistidine"

    dades_metadades <- dades[, 1:2] 
    dades_matriu <- as.matrix(dades[, -c(1:2)]) 

Per tal de comprovar que la separació s’ha fet correctament es
verifiquen les dimensions.

    dim(dades_metadades)

    ## [1] 77  2

    dim(dades_matriu)

    ## [1] 77 63

A continuació, es converteixen les metadades en un objecte DataFrame i
es crea l’objecte SummarizedExperiment amb les dades que s’han anat
preparant. I guardar-lo.

    SE<- SummarizedExperiment(assays = list(counts = dades_matriu), rowData = dades_metadades)
    save(SE, file = "human_cachexia_data.Rda")

### 3. Exploració del dataset

    dim(SE)

    ## [1] 77 63

    head(assay(SE, "counts"))

    ##      1,6-Anhydro-beta-D-glucose
    ## [1,]                      40.85
    ## [2,]                      62.18
    ## [3,]                     270.43
    ## [4,]                     154.47
    ## [5,]                      22.20
    ## [6,]                     212.72
    ##      1-Methylnicotinamide 2-Aminobutyrate
    ## [1,]                65.37           18.73
    ## [2,]               340.36           24.29
    ## [3,]                64.72           12.18
    ## [4,]                52.98          172.43
    ## [5,]                73.70           15.64
    ## [6,]                31.82           18.36
    ##      2-Hydroxyisobutyrate 2-Oxoglutarate
    ## [1,]                26.05          71.52
    ## [2,]                41.68          67.36
    ## [3,]                65.37          23.81
    ## [4,]                74.44        1199.91
    ## [5,]                83.93          33.12
    ## [6,]                80.64          47.94
    ##      3-Aminoisobutyrate 3-Hydroxybutyrate
    ## [1,]            1480.30             56.83
    ## [2,]             116.75             43.82
    ## [3,]              14.30              5.64
    ## [4,]             555.57            175.91
    ## [5,]              29.67             76.71
    ## [6,]              17.46             31.82
    ##      3-Hydroxyisovalerate 3-Indoxylsulfate
    ## [1,]                10.07           566.80
    ## [2,]                79.84           368.71
    ## [3,]                23.34           665.14
    ## [4,]                25.03           411.58
    ## [5,]                69.41           165.67
    ## [6,]                35.16           183.09
    ##      4-Hydroxyphenylacetate Acetate Acetone
    ## [1,]                 120.30  126.47    9.49
    ## [2,]                 432.68  212.72   11.82
    ## [3,]                 292.95  314.19    4.44
    ## [4,]                 214.86   37.34  206.44
    ## [5,]                  97.51  407.48   44.26
    ## [6,]                 132.95   81.45   14.44
    ##      Adipate Alanine Asparagine Betaine
    ## [1,]   38.09  314.19     159.17  109.95
    ## [2,]  327.01  871.31     157.59  244.69
    ## [3,]  131.63  464.05      89.12  116.75
    ## [4,]  144.03  589.93     273.14  278.66
    ## [5,]   15.03 1118.79      42.52  391.51
    ## [6,]   25.28  237.46     157.59   66.69
    ##      Carnitine  Citrate Creatine Creatinine
    ## [1,]    265.07  3714.50   196.37   16481.60
    ## [2,]    120.30  2617.57   212.72   15835.35
    ## [3,]     25.03   862.64   221.41   24587.66
    ## [4,]    200.34 13629.61    85.63   20952.22
    ## [5,]     84.77   854.06   105.64    6768.26
    ## [6,]     40.04  1958.63   200.34   15677.78
    ##      Dimethylamine Ethanolamine Formate
    ## [1,]        632.70       645.48  441.42
    ## [2,]        607.89       487.85  252.14
    ## [3,]        735.10       407.48  249.64
    ## [4,]       1064.22       820.57  468.72
    ## [5,]        242.26       365.04  114.43
    ## [6,]        614.00       459.44  314.19
    ##      Fucose Fumarate Glucose Glutamine
    ## [1,] 336.97     7.69  395.44    871.31
    ## [2,] 198.34    18.92 8690.62    601.85
    ## [3,] 186.79     7.10 1352.89    301.87
    ## [4,] 407.48    96.54  862.64   1685.81
    ## [5,]  26.05    19.69 6836.29    432.68
    ## [6,] 123.97     5.05  512.86    298.87
    ##      Glycine Glycolate Guanidoacetate
    ## [1,] 2038.56    685.40         154.47
    ## [2,] 1107.65    651.97         109.95
    ## [3,]  620.17    141.17         183.09
    ## [4,] 5064.45     70.81         102.51
    ## [5,]  395.44     26.58          52.98
    ## [6,]  482.99    428.38          57.97
    ##      Hippurate Histidine Hypoxanthine
    ## [1,]   4582.50    925.19        97.51
    ## [2,]   1737.15    845.56        82.27
    ## [3,]   4315.64    284.29       114.43
    ## [4,]    757.48   1043.15       223.63
    ## [5,]   1152.86    327.01        66.69
    ## [6,]   3568.85    459.44        62.80
    ##      Isoleucine Lactate Leucine Lysine
    ## [1,]       5.58  106.70   42.10 146.94
    ## [2,]       8.17  368.71   77.48 284.29
    ## [3,]       9.30  749.95   31.50  97.51
    ## [4,]      37.71  368.71  103.54 290.03
    ## [5,]      40.04 3640.95  101.49 122.73
    ## [6,]       8.17  113.30   28.79 120.30
    ##      Methylamine Methylguanidine
    ## [1,]       52.46            9.97
    ## [2,]       23.57            7.69
    ## [3,]       18.73            4.66
    ## [4,]       48.91          141.17
    ## [5,]       27.94            5.31
    ## [6,]       36.97           43.38
    ##      N,N-Dimethylglycine O-Acetylcarnitine
    ## [1,]               23.34             52.98
    ## [2,]               87.36             50.40
    ## [3,]               24.53              5.58
    ## [4,]               40.04            254.68
    ## [5,]               46.06             45.60
    ## [6,]               24.29             13.46
    ##      Pantothenate Pyroglutamate Pyruvate
    ## [1,]        25.79        437.03    21.12
    ## [2,]       186.79        437.03    36.97
    ## [3,]       145.47        713.37    29.37
    ## [4,]        42.52        566.80    64.07
    ## [5,]        74.44        184.93    12.30
    ## [6,]        35.52        432.68    32.79
    ##      Quinolinate  Serine Succinate Sucrose
    ## [1,]      165.67  284.29    154.47   45.15
    ## [2,]       72.97  391.51    244.69  459.44
    ## [3,]      192.48  295.89    142.59  160.77
    ## [4,]       86.49 1248.88    144.03  111.05
    ## [5,]       38.09  206.44     68.72   75.19
    ## [6,]      112.17  387.61     33.45  336.97
    ##      Tartrate Taurine Threonine Trigonelline
    ## [1,]    97.51 1919.85    184.93       943.88
    ## [2,]    32.79 1261.43    198.34       208.51
    ## [3,]    16.28 4272.69    109.95       192.48
    ## [4,]   837.15 1525.38    376.15       992.27
    ## [5,]     4.53  468.72     64.07        86.49
    ## [6,]    24.05 2059.05    105.64       862.64
    ##      Trimethylamine N-oxide Tryptophan
    ## [1,]                2121.76     259.82
    ## [2,]                 639.06      83.10
    ## [3,]                1152.86      82.27
    ## [4,]                1450.99     235.10
    ## [5,]                 172.43     103.54
    ## [6,]                 880.07     239.85
    ##      Tyrosine Uracil Valine  Xylose
    ## [1,]   290.03 111.05  86.49   72.24
    ## [2,]   167.34  46.99 109.95  192.48
    ## [3,]    60.34  31.50  59.15 2164.62
    ## [4,]   323.76  30.57 102.51  125.21
    ## [5,]   142.59  44.26 160.77  186.79
    ## [6,]   127.74  29.67  36.97   89.12
    ##      cis-Aconitate myo-Inositol
    ## [1,]        237.46       135.64
    ## [2,]        333.62       376.15
    ## [3,]        330.30        86.49
    ## [4,]       1863.11       247.15
    ## [5,]        101.49       749.95
    ## [6,]        287.15       129.02
    ##      trans-Aconitate pi-Methylhistidine
    ## [1,]           51.94             157.59
    ## [2,]          217.02             307.97
    ## [3,]           58.56             145.47
    ## [4,]           75.94             249.64
    ## [5,]           98.49              84.77
    ## [6,]          121.51             399.41
    ##      tau-Methylhistidine
    ## [1,]              160.77
    ## [2,]              130.32
    ## [3,]               83.93
    ## [4,]              254.68
    ## [5,]               79.84
    ## [6,]               68.72

-   Les dimencions de l’objecte creat són 77 files i 63 columnes.

-   Head() permet veure les primeres línies de la taula

<!-- -->

    rowData(SE)

    ## DataFrame with 77 rows and 2 columns
    ##       Patient ID Muscle loss
    ##      <character> <character>
    ## 1        PIF_178    cachexic
    ## 2        PIF_087    cachexic
    ## 3        PIF_090    cachexic
    ## 4    NETL_005_V1    cachexic
    ## 5        PIF_115    cachexic
    ## ...          ...         ...
    ## 73  NETCR_019_V2     control
    ## 74   NETL_012_V1     control
    ## 75   NETL_012_V2     control
    ## 76   NETL_003_V1     control
    ## 77   NETL_003_V2     control

    colData(SE)

    ## DataFrame with 63 rows and 0 columns

    summary(assay(SE, "counts"))

    ##  1,6-Anhydro-beta-D-glucose
    ##  Min.   :  4.71            
    ##  1st Qu.: 28.79            
    ##  Median : 45.60            
    ##  Mean   :105.63            
    ##  3rd Qu.:141.17            
    ##  Max.   :685.40            
    ##  1-Methylnicotinamide 2-Aminobutyrate 
    ##  Min.   :   6.42      Min.   :  1.28  
    ##  1st Qu.:  15.80      1st Qu.:  5.26  
    ##  Median :  36.60      Median : 10.49  
    ##  Mean   :  71.57      Mean   : 18.16  
    ##  3rd Qu.:  73.70      3rd Qu.: 19.49  
    ##  Max.   :1032.77      Max.   :172.43  
    ##  2-Hydroxyisobutyrate 2-Oxoglutarate   
    ##  Min.   : 4.85        Min.   :   5.53  
    ##  1st Qu.:15.80        1st Qu.:  22.42  
    ##  Median :32.46        Median :  55.15  
    ##  Mean   :37.25        Mean   : 145.09  
    ##  3rd Qu.:54.60        3rd Qu.:  92.76  
    ##  Max.   :93.69        Max.   :2465.13  
    ##  3-Aminoisobutyrate 3-Hydroxybutyrate
    ##  Min.   :   2.61    Min.   :  1.70   
    ##  1st Qu.:  11.70    1st Qu.:  5.99   
    ##  Median :  22.65    Median : 11.70   
    ##  Mean   :  76.76    Mean   : 21.72   
    ##  3rd Qu.:  56.26    3rd Qu.: 29.96   
    ##  Max.   :1480.30    Max.   :175.91   
    ##  3-Hydroxyisovalerate 3-Indoxylsulfate 
    ##  Min.   :  0.92       Min.   :  27.66  
    ##  1st Qu.:  5.26       1st Qu.:  82.27  
    ##  Median : 12.55       Median : 144.03  
    ##  Mean   : 21.65       Mean   : 218.88  
    ##  3rd Qu.: 30.27       3rd Qu.: 333.62  
    ##  Max.   :164.02       Max.   :1043.15  
    ##  4-Hydroxyphenylacetate    Acetate      
    ##  Min.   : 15.49         Min.   :  3.49  
    ##  1st Qu.: 41.68         1st Qu.: 16.28  
    ##  Median : 70.11         Median : 39.65  
    ##  Mean   :112.02         Mean   : 66.14  
    ##  3rd Qu.:145.47         3rd Qu.: 86.49  
    ##  Max.   :796.32         Max.   :411.58  
    ##     Acetone          Adipate      
    ##  Min.   :  2.29   Min.   :  1.55  
    ##  1st Qu.:  4.95   1st Qu.:  6.11  
    ##  Median :  7.10   Median : 10.18  
    ##  Mean   : 11.43   Mean   : 24.76  
    ##  3rd Qu.: 10.49   3rd Qu.: 19.11  
    ##  Max.   :206.44   Max.   :327.01  
    ##     Alanine          Asparagine    
    ##  Min.   :  16.78   Min.   :  6.69  
    ##  1st Qu.:  78.26   1st Qu.: 20.49  
    ##  Median : 194.42   Median : 42.10  
    ##  Mean   : 273.56   Mean   : 62.28  
    ##  3rd Qu.: 399.41   3rd Qu.: 89.12  
    ##  Max.   :1312.91   Max.   :273.14  
    ##     Betaine         Carnitine     
    ##  Min.   :  2.29   Min.   :  2.18  
    ##  1st Qu.: 28.79   1st Qu.: 14.44  
    ##  Median : 64.72   Median : 23.81  
    ##  Mean   : 90.32   Mean   : 52.09  
    ##  3rd Qu.:127.74   3rd Qu.: 60.95  
    ##  Max.   :391.51   Max.   :487.85  
    ##     Citrate            Creatine      
    ##  Min.   :   59.74   Min.   :   2.75  
    ##  1st Qu.:  788.40   1st Qu.:  17.64  
    ##  Median : 1790.05   Median :  44.26  
    ##  Mean   : 2235.35   Mean   : 126.83  
    ##  3rd Qu.: 3071.74   3rd Qu.: 117.92  
    ##  Max.   :13629.61   Max.   :1863.11  
    ##    Creatinine    Dimethylamine    
    ##  Min.   : 1002   Min.   :  41.26  
    ##  1st Qu.: 3498   1st Qu.: 142.59  
    ##  Median : 7631   Median : 304.90  
    ##  Mean   : 8734   Mean   : 358.17  
    ##  3rd Qu.:12333   3rd Qu.: 454.86  
    ##  Max.   :33860   Max.   :1556.20  
    ##   Ethanolamine        Formate       
    ##  Min.   :  16.12   Min.   :   6.42  
    ##  1st Qu.:  86.49   1st Qu.:  53.52  
    ##  Median : 204.38   Median :  95.58  
    ##  Mean   : 276.26   Mean   : 147.40  
    ##  3rd Qu.: 407.48   3rd Qu.: 167.34  
    ##  Max.   :1436.55   Max.   :1480.30  
    ##      Fucose          Fumarate    
    ##  Min.   :  5.70   Min.   : 0.79  
    ##  1st Qu.: 29.37   1st Qu.: 2.23  
    ##  Median : 61.56   Median : 4.10  
    ##  Mean   : 88.67   Mean   : 8.44  
    ##  3rd Qu.:123.97   3rd Qu.: 7.85  
    ##  Max.   :407.48   Max.   :96.54  
    ##     Glucose          Glutamine      
    ##  Min.   :  26.84   Min.   :  23.34  
    ##  1st Qu.:  80.64   1st Qu.: 113.30  
    ##  Median : 210.61   Median : 225.88  
    ##  Mean   : 559.85   Mean   : 306.87  
    ##  3rd Qu.: 407.48   3rd Qu.: 445.86  
    ##  Max.   :8690.62   Max.   :1685.81  
    ##     Glycine          Glycolate     
    ##  Min.   :  38.09   Min.   :  5.42  
    ##  1st Qu.: 262.43   1st Qu.: 50.91  
    ##  Median : 528.48   Median :130.32  
    ##  Mean   : 880.72   Mean   :187.99  
    ##  3rd Qu.:1096.63   3rd Qu.:267.74  
    ##  Max.   :5064.45   Max.   :720.54  
    ##  Guanidoacetate     Hippurate       
    ##  Min.   :  7.03   Min.   :   92.76  
    ##  1st Qu.: 33.78   1st Qu.:  492.75  
    ##  Median : 64.72   Median : 1224.15  
    ##  Mean   : 86.37   Mean   : 2286.84  
    ##  3rd Qu.:108.85   3rd Qu.: 2921.93  
    ##  Max.   :561.16   Max.   :19341.34  
    ##    Histidine        Hypoxanthine   
    ##  Min.   :  14.15   Min.   :  3.78  
    ##  1st Qu.:  66.69   1st Qu.: 20.70  
    ##  Median : 174.16   Median : 40.04  
    ##  Mean   : 292.64   Mean   : 61.10  
    ##  3rd Qu.: 419.89   3rd Qu.: 83.93  
    ##  Max.   :1863.11   Max.   :265.07  
    ##    Isoleucine        Lactate       
    ##  Min.   : 1.790   Min.   :   7.32  
    ##  1st Qu.: 3.900   1st Qu.:  35.52  
    ##  Median : 7.170   Median :  81.45  
    ##  Mean   : 8.709   Mean   : 158.46  
    ##  3rd Qu.:11.250   3rd Qu.: 139.77  
    ##  Max.   :40.040   Max.   :3640.95  
    ##     Leucine           Lysine      
    ##  Min.   :  2.51   Min.   : 10.49  
    ##  1st Qu.:  9.12   1st Qu.: 30.27  
    ##  Median : 19.11   Median : 69.41  
    ##  Mean   : 24.36   Mean   :108.79  
    ##  3rd Qu.: 31.19   3rd Qu.:121.51  
    ##  Max.   :103.54   Max.   :788.40  
    ##   Methylamine    Methylguanidine 
    ##  Min.   : 1.51   Min.   :  1.70  
    ##  1st Qu.: 5.26   1st Qu.:  4.26  
    ##  Median :14.73   Median :  7.85  
    ##  Mean   :17.38   Mean   : 15.32  
    ##  3rd Qu.:24.05   3rd Qu.: 19.30  
    ##  Max.   :52.46   Max.   :141.17  
    ##  N,N-Dimethylglycine O-Acetylcarnitine
    ##  Min.   :  0.79      Min.   :  1.23   
    ##  1st Qu.:  7.03      1st Qu.:  3.94   
    ##  Median : 21.98      Median : 11.47   
    ##  Mean   : 26.35      Mean   : 19.73   
    ##  3rd Qu.: 40.04      3rd Qu.: 20.91   
    ##  Max.   :120.30      Max.   :254.68   
    ##   Pantothenate    Pyroglutamate    
    ##  Min.   :  2.59   Min.   :  21.33  
    ##  1st Qu.: 11.13   1st Qu.:  68.72  
    ##  Median : 22.65   Median : 157.59  
    ##  Mean   : 44.88   Mean   : 211.45  
    ##  3rd Qu.: 41.26   3rd Qu.: 301.87  
    ##  Max.   :692.29   Max.   :1064.22  
    ##     Pyruvate       Quinolinate    
    ##  Min.   :  0.90   Min.   :  5.21  
    ##  1st Qu.:  4.85   1st Qu.: 26.58  
    ##  Median : 13.46   Median : 51.42  
    ##  Mean   : 21.29   Mean   : 66.44  
    ##  3rd Qu.: 29.08   3rd Qu.: 87.36  
    ##  Max.   :184.93   Max.   :259.82  
    ##      Serine          Succinate     
    ##  Min.   :  16.12   Min.   :  1.72  
    ##  1st Qu.:  83.10   1st Qu.:  8.58  
    ##  Median : 142.59   Median : 30.88  
    ##  Mean   : 197.69   Mean   : 60.23  
    ##  3rd Qu.: 270.43   3rd Qu.: 74.44  
    ##  Max.   :1248.88   Max.   :589.93  
    ##     Sucrose           Tartrate     
    ##  Min.   :   6.49   Min.   :  2.20  
    ##  1st Qu.:  19.30   1st Qu.:  6.89  
    ##  Median :  40.85   Median : 12.94  
    ##  Mean   : 113.23   Mean   : 40.00  
    ##  3rd Qu.:  94.63   3rd Qu.: 25.79  
    ##  Max.   :2079.74   Max.   :837.15  
    ##     Taurine          Threonine     
    ##  Min.   :  17.81   Min.   :  8.25  
    ##  1st Qu.:  99.48   1st Qu.: 31.82  
    ##  Median : 249.64   Median : 64.07  
    ##  Mean   : 525.12   Mean   : 95.36  
    ##  3rd Qu.: 665.14   3rd Qu.:137.00  
    ##  Max.   :4272.69   Max.   :450.34  
    ##   Trigonelline     Trimethylamine N-oxide
    ##  Min.   :  10.07   Min.   :  55.7        
    ##  1st Qu.:  53.52   1st Qu.: 175.9        
    ##  Median : 114.43   Median : 383.8        
    ##  Mean   : 270.44   Mean   : 652.2        
    ##  3rd Qu.: 340.36   3rd Qu.: 735.1        
    ##  Max.   :2252.96   Max.   :5486.2        
    ##    Tryptophan        Tyrosine     
    ##  Min.   :  8.67   Min.   :  4.22  
    ##  1st Qu.: 21.33   1st Qu.: 23.57  
    ##  Median : 46.99   Median : 60.34  
    ##  Mean   : 66.24   Mean   : 81.76  
    ##  3rd Qu.: 96.54   3rd Qu.:113.30  
    ##  Max.   :259.82   Max.   :539.15  
    ##      Uracil           Valine      
    ##  Min.   :  3.10   Min.   :  4.10  
    ##  1st Qu.: 11.94   1st Qu.: 12.18  
    ##  Median : 27.39   Median : 33.12  
    ##  Mean   : 35.56   Mean   : 35.67  
    ##  3rd Qu.: 44.26   3rd Qu.: 50.40  
    ##  Max.   :179.47   Max.   :160.77  
    ##      Xylose        cis-Aconitate    
    ##  Min.   :  10.07   Min.   :  12.94  
    ##  1st Qu.:  29.96   1st Qu.:  36.23  
    ##  Median :  50.40   Median : 129.02  
    ##  Mean   : 100.93   Mean   : 204.22  
    ##  3rd Qu.:  89.12   3rd Qu.: 254.68  
    ##  Max.   :2164.62   Max.   :1863.11  
    ##   myo-Inositol    trans-Aconitate 
    ##  Min.   : 11.59   Min.   :  4.90  
    ##  1st Qu.: 30.27   1st Qu.: 12.43  
    ##  Median : 78.26   Median : 26.84  
    ##  Mean   :135.40   Mean   : 40.63  
    ##  3rd Qu.:167.34   3rd Qu.: 57.40  
    ##  Max.   :854.06   Max.   :217.02  
    ##  pi-Methylhistidine tau-Methylhistidine
    ##  Min.   :  11.36    Min.   :  8.00     
    ##  1st Qu.:  67.36    1st Qu.: 27.39     
    ##  Median : 162.39    Median : 68.72     
    ##  Mean   : 370.29    Mean   : 89.69     
    ##  3rd Qu.: 387.61    3rd Qu.:130.32     
    ##  Max.   :2697.28    Max.   :317.35

-   Assay() dóna accés a la matriu de les dades.

-   rowData() es per a obtenir la informació de les característiques en
    cada fila. en aquest cas hi ha 77 files corresponent al nombre de
    mostres i 2 columnes, corresponent a les dos metadades.

-   colData() es per a obternir la informació de les característiques de
    cada mostra. Conté 63 files, corresponent al nombre variables
    numèriques però cap columna.

-   summary() dóna les estadístiques descriptives. Dels resultats es pot
    extreure què hi ha metabòlits com el citrat, la creatinina i l’òxid
    de trimetiamina que presenten valors alts en diverses mostres.
    Altres com el 2-aminobutirat i el cisaconitat que tenen
    concentracions baixes o poc variabeles. i, en alguns metabòlits cm
    la glicina o hipurat que hi ha fluctuacions indicant que pot tenir
    diferències.

A continuació, es preparen les dades en dataframe per poder treballar
millor. Primer el df només amb les metadades i després es fa la
combinació d’ambdós.

    df_comp <- data.frame(dades_metadades)
    df_comp <- cbind(df_comp, dades_matriu)

    dim(df_comp) 

    ## [1] 77 65

    head(df_comp) 

Per tal d’assegurar que ha sortit bé es comproven les dimencions i
aquesta ha de ser 77 x (63+2) i es mostren amb head les primeres línies.

Es pot realitzar un anàlisis ANOVA per poder mirar quines de les
variables són estadísticament significatives entre els dos grups i
aquests seran els que tindan un valor p &lt; 0.05. En aquest cas, es
recomanable comprovar que la variable Muscle loss és un factor amb
as.factor i str.

    df_comp$Muscle.loss <- as.factor(df_comp$Muscle.loss)
    str(df_comp$Muscle.loss)  

    ##  Factor w/ 2 levels "cachexic","control": 1 1 1 1 1 1 1 1 1 1 ...

El següent pas, es realitzar un data frame buit (resultats\_anova) que
serà on s’emmagatzemaran els valors obtinguts del test ANOVA. Per no
haver de repetir el test ANOVA variable per variable, es pot fer una
iteració per a cada metabòlit mitjançant for i in. En cas d’error, es
retorna NULL, d’aquesta manera es una verificació de que el test esta
funcionant. I, finalment, per tal de poder filtrar tots els metabòlits
que són estadísticament significatius es fa una divisió dels resultats
amb subset, definint com a criteri pvalue &lt; 0.05.

    resultats_anova <- data.frame(Variable = character(), p_value = numeric(), stringsAsFactors = FALSE)


    for (metabolit in colnames(dades_matriu)) {
        anova_result <- tryCatch({
            with(df_comp, aov(get(metabolit) ~ Muscle.loss))
        }, error = function(e) {
            NULL
        })
        
       
        if (!is.null(anova_result)) {
            p_value <- summary(anova_result)[[1]][["Pr(>F)"]][1]
            
            resultats_anova <- rbind(resultats_anova, data.frame(Variable = metabolit, p_value = p_value))
        }
    }


    resultats_significatius <- subset(resultats_anova, p_value < 0.05)
    print(resultats_significatius)

40 dels 63 metabòlis han sortir estadísticament significatius. La
comparativa gràfica d’aquests 63 metabòlits amb els grups control i
pacients es poden fer mitjançant boxplots. La llibreria ggplot2 ofereix
la possiblitat de crear molts tipus de gràfiques que permet una
visualització dels resultats.

    library(ggplot2)

    for (metabolit in resultats_significatius$Variable) {
        p <- ggplot(df_comp, aes(x = Muscle.loss, y = .data[[metabolit]])) +
            geom_boxplot() +
            labs(title = paste("Distribució de", metabolit, "segons Muscle loss"),
                 x = "Muscle loss",
                 y = metabolit) +
            theme_minimal()
        
        print(p)
    }

![](informe_files/figure-markdown_strict/unnamed-chunk-13-1.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-2.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-3.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-4.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-5.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-6.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-7.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-8.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-9.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-10.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-11.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-12.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-13.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-14.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-15.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-16.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-17.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-18.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-19.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-20.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-21.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-22.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-23.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-24.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-25.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-26.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-27.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-28.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-29.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-30.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-31.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-32.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-33.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-34.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-35.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-36.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-37.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-38.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-39.png)![](informe_files/figure-markdown_strict/unnamed-chunk-13-40.png)

La informació obtinguda dels metabòlits expressats a diferents nivells
entre els pacients i el grup control es pot interpretar a través de vies
metabòliques relacionades amb la inflamació, el catabolisme muscular, o
l’estrès oxidatiu, que són crucials en la fisiopatologia de la caquèxia.

Requeriria de la continuació de l’estudi amb els metabòlits
estadísticament significatius per escollir uns biomarcadors i poder
diagnosticar o dissenyar teràpies per a aquesta malaltia.

### 4. Informe

L’informe ha estat elaborat amb el format RMarkdown perquè permet
agrupar el text, els codis R utilitzats per a la pràctica i els seus
resultats.

### 5. Creació del Repositori GitHub

Un cop al compte, crear un nou repositori: ![Captura del procés de
creació del repositori](/Users/merce/Desktop/Creació.png) L’enllaç per a
poder accedir al repositori és
<https://github.com/malcoverrom/ALCOVERRO-Mulet-Merce-PEC1.git>
