This README file was generated on 2026-05-28 by Beatriz Willink.

GENERAL INFORMATION

1. Title of Dataset: The temperature-size ‘rule’ and its underlying mechanisms are not universal: evidence from New Zealand stick insects

2. Author Information

	A. Principal Investigator Contact Information
	   
     Name: Thomas R. Buckley	
  	 
     Institution: Bioeconomy Science Institute
  	 
     Address: Auckland, New Zealand
  	 
     Email: buckleyT@landcareresearch.co.nz

	B. Associate or Co-investigator Contact Information
     
     Name: Claudio A. Cubillos
	
     Institution: University of Auckland
		 
     Address: Auckland, New Zealand
		 
     Email: claudiocubillosp@gmail.com
  	 
	C. Associate or Co-investigator Contact Information
	   
     Name: Brent J. Sinclair	
  	 
     Institution: Cornell University
  	 
     Address: Ithaca, NY, US
  	 
     Email: bjs299@cornell.edu
		 
	D. Associate or Co-investigator Contact Information
	   
     Name: Beatriz Willink	
  	 
     Institution: Cornell University
  	 
     Address: Ithaca, NY, US
  	 
     Email: beatriz.willink@cornell.edu


3. Date of data collection (single date, range, approximate date): spring/summer seasons of 2018-2020

4. Geographic location of data collection: 

	A. Field sites
	 New Zealand: Ōtari-Wilton's Bush, Auckland Botanic Gardens, Waitākere Ranges, Totara Park, Sewell Peak, Okuti Valley
	
5. Information about funding sources that supported the collection of the data: 

	A. The Royal Society of New Zealand Marsden Fund (LCR1701)
	

SHARING/ACCESS INFORMATION

1. Licenses/restrictions placed on the data: CC0 1.0 Universal (CC0 1.0) Public Domain

2. Links to publications that cite or use the data: None

3. Links to other publicly accessible locations of the data: https://github.com/bwillink/Temperature-size_rule

4. Links/relationships to ancillary data sets: None

5. Was data derived from another source? Yes, a phylogenetic tree was derived from the literature.

	A. If yes, list source(s): 
	 Phylogeny:
	 
	 Dennis, A.B., L.T. Dunning, B.J. Sinclair, and T.R. Buckley. 2015. Parallel molecular routes to cold adaptation in eight genera of New Zealand stick insects. Scientific Reports, 5: 13965.
	 
	 Dunning, L.T., G. Thomson, A.B. Dennis, B.J. Sinclair, R.D. Newcomb, and T.R. Buckley. 2013. Positive selection in glycolysis among Australasian stick insects. BMC Evolutionary Biology, 13: 215. 


6. Recommended citation for this dataset: 

Cubillos, C. A., Sinclair, B. J., Willink, B. & Buckley, T. B. (2026). Data from: The temperature-size ‘rule’ and its underlying mechanisms are not universal: evidence from New Zealand stick insects. Zenodo. Link TBD.

DATA & FILE OVERVIEW

1. File List:

	A. growth_rate_data.csv
  	 
	B. Relabeled_data_TSR.csv
	  		 
	C. stick_tree.tre	

2. Relationship between files, if important: The phylogeny in stick_tree.tre was combined with the individual-level data in TSR_data.csv to estimate thermal sensitivity effects and reaction norms while accounting for phylogenetic non-independence between related species.

3. Additional related data collected that was not included in the current data package: None

4. Are there multiple versions of the dataset? No
	
#########################################################################

DATA-SPECIFIC INFORMATION FOR: growth_rate_data.csv

1. File type: csv

2. Number of variables: 14

3. Number of cases/rows: 1994

4. Variable List:
    
    * full_id: ids for individual stick insects
    
    * species: species code: ASN = Asteliaphasma jucundum, AXG = Acanthoxyla prasina, AXI = Acanthoxyla inermis, CLH = Clitarchus hookeri, MS2 =Micrarchus nov. sp. 2, SPA = Spinotectarchus acornutus, TTH = Tectarchus huttoni, TTS = Tectarchus salebrosus.

    * stage: developmental stage: A = adult, N = nymph

    * population: source population: BG = Botanic Gardens, MR = Waitākere Ranges, OV = Okuti Valley, SP = Sewell Peak, WB = Ōtari-Wilton's Bush.

    * n: individual number within its species

    * test_temp: experimental temperature: 10 C, 20 C.

    * food_plant: plant species fed during growth period: RU = Rubus ulmifolius

    * weight: body mass in g

    * date: calendar date DD/MM/YYYY

    * days_week: number of days elapsed in the current week

    * days_cumulative: total number of days elapsed since the start of the experiment (moult to fourth instar)

    * days_instar: number of days elapsed in the current instar
    
    * week: number of full weeks elapsed since the start of the experiment (moult to fourth instar)
    
    * instar: current instar: 4 = fourth, 5 = fifth, 6 = sixth, 7 = adult
    
5. Missing data codes: None

6. Specialized formats or other abbreviations used: None

#########################################################################

DATA-SPECIFIC INFORMATION FOR: Relabeled_data_TSR.csv

1. File type: csv

2. Number of variables: 25

3. Number of cases/rows: 87

4. Variable List:

    * full_id: ids for individual stick insects
    
    * species: species code: ASN = Asteliaphasma jucundum, AXG = Acanthoxyla prasina, AXI = Acanthoxyla inermis, CLH = Clitarchus hookeri, MS2 =Micrarchus nov. sp. 2, SPA = Spinotectarchus acornutus, TTH = Tectarchus huttoni, TTS = Tectarchus salebrosus.

    * n: individual number within its species

    * acclimation: experimental temperature: 10 C, 20 C.

    * Initial-mass: body mass at the start of the experiment (moult to fourth instar) in g
    
    * Days-fourth-Instar: number of days elapsed as fourth-instar nymph

    * DR-fourth-instar: Developmental rate (1/days) during the fourth instar

    * Mass-fourth-instar: Final mass (g) on the last day of the fourth instar 

    * Mass-gain-fourth-instar: difference in mass (g) between the last day and the first day of the fourth instar

    * GR-fourth-instar: Growth rate (g/day) during the fourth instar

    * Days-fifth-Instar: number of days elapsed as fifth-instar nymph

    * DR-fifth-instar: Developmental rate (1/days) during the fifth instar

    * Mass-fifth-instar: Final mass (g) on the last day of the fifth instar 

    * Mass-gain-fifth-instar: difference in mass (g) between the last day and the first day of the fifth instar

    * GR-fifth-instar: Growth rate (g/day) during the fifth instar
    
    * Days-last-Instar: number of days elapsed as sixth-instar nymph

    * DR-last-instar: Developmental rate (1/days) during the sixth instar

    * Mass-last-instar: Final mass (g) on the last day of the sixth instar 

    * Mass-gain-last-instar: difference in mass (g) between the last day and the first day of the sixth instar

    * GR-last-instar: Growth rate (g/day) during the sixth instar
    
    * Days-imago-maturity: number of days elapsed as adult (imago) prior to sexual maturity

    * DR-imago: Developmental rate (1/days) during the pre-reproductive adult (imago) stage

    * Mass-imago: Final mass (g) on the last day of the pre-reproductive adult (imago) stage

    * Mass-gain-imago: difference in mass (g) between the last day and the first day of the pre-reproductive adult (imago) stage

    * GR-imago: Growth rate (g/day) during the pre-reproductive adult (imago) stage
 
5. Missing data codes: NA

6. Specialized formats or other abbreviations used: None

#########################################################################

DATA-SPECIFIC INFORMATION FOR: stick_tree.tre

1. File type: newick

2. Number of trees: 1

3. Number of taxa: 8

4. Notes: species tree from Dunning et al. 2013, Dennis et al 2015

#########################################################################

