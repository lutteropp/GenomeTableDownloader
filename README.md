# GenomeTableRetriever
R script that takes a list of species names, automatically downloads the FASTA genomes, and returns a tab-separated mapping from each taxon name to its FASTA file as it is required for the hakmer-tool. The script has no problems with species synonyms or misclassified species, because it is using the biomartr package and the Catalogue of Life web interface.

Example usage:
- Create a text file called species_names containing the taxon names line by line.
- Adapt the path to this text file in the R script
- Wait for the genomes to be downloaded and the table to be created. :-)
- Decompress the downloaded genomes. On purpose, this is not done automatically.

An example output file genomes.table looks like this:

_ncbi_downloads/genomes/Lachancea_waltii_genomic_genbank.fna	Kluyveromyces waltii
_ncbi_downloads/genomes/Lachancea_thermotolerans_genomic_refseq.fna	Kluyveromyces thermotolerans
_ncbi_downloads/genomes/Lachancea_kluyveri_genomic_genbank.fna	Saccharomyces kluyveri
_ncbi_downloads/genomes/Kluyveromyces_lactis_genomic_refseq.fna	Kluyveromyces lactis
_ncbi_downloads/genomes/Eremothecium_gossypii_genomic_refseq.fna	Eremothecium gossypii
_ncbi_downloads/genomes/Zygosaccharomyces_rouxii_genomic_refseq.fna	Zygosaccharomyces rouxii
_ncbi_downloads/genomes/Vanderwaltozyma_polyspora_genomic_refseq.fna	Kluyveromyces polysporus
_ncbi_downloads/genomes/[Candida]_glabrata_genomic_genbank.fna	Candida glabrata
_ncbi_downloads/genomes/Naumovozyma_castellii_genomic_refseq.fna	Saccharomyces castellii
_ncbi_downloads/genomes/Saccharomyces_bayanus_genomic_genbank.fna	Saccharomyces bayanus
_ncbi_downloads/genomes/[Saccharomyces]_kudriavzevii_genomic_refseq.fna	Saccharomyces kudriavzevii
_ncbi_downloads/genomes/Saccharomyces_mikatae_genomic_genbank.fna	Saccharomyces mikatae
_ncbi_downloads/genomes/Saccharomyces_paradoxus_genomic_genbank.fna	Saccharomyces paradoxus
_ncbi_downloads/genomes/Saccharomyces_cerevisiae_genomic_refseq.fna	Saccharomyces cerevisiae
_ncbi_downloads/genomes/Clavispora_lusitaniae_genomic_refseq.fna	Candida lusitaniae
_ncbi_downloads/genomes/Candida_dubliniensis_genomic_refseq.fna	Candida dubliniensis
_ncbi_downloads/genomes/Candida_albicans_genomic_refseq.fna	Candida albicans
_ncbi_downloads/genomes/Candida_tropicalis_genomic_refseq.fna	Candida tropicalis
_ncbi_downloads/genomes/Candida_parapsilosis_genomic_genbank.fna	Candida parapsilosis
_ncbi_downloads/genomes/Lodderomyces_elongisporus_genomic_refseq.fna	Lodderomyces elongisporus
_ncbi_downloads/genomes/Scheffersomyces_stipitis_genomic_refseq.fna	Pichia stipitis
_ncbi_downloads/genomes/Meyerozyma_guilliermondii_genomic_refseq.fna	Candida guilliermondii
_ncbi_downloads/genomes/Debaryomyces_hansenii_genomic_refseq.fna	Debaryomyces hansenii
