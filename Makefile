all: paper.pdf # resources.pdf 

paper.pdf: paper.tex references.bib acmart.cls 
	latexmk -pdf paper.tex

resources.pdf: resources.tex acmart.cls references.bib 
	latexmk -pdf resources.tex

# Needs paper.bbl for arXiv reasons, but I'm too lazy to make that
# a separate target, so I'm adding paper.pdf as a dep  
arxiv.tar.gz: paper.tex references.bib paper.pdf 
	tar cvzf archive.tar.gz acmart.bib acmart.cls acmauthoryear.cbx acm-jdslogo.png acmnumeric.cbx paper.bbl paper.tex references.bib string-diagrams.sty 


clean: 
	rm -f *.aux *.dtx *.bbx *.dbx *.bbl *.fdb_latexmk *.fls *.log *.out *~

realclean: 
	rm -f paper.pdf *.aux *.dtx *.bbx *.dbx *.bbl *.fdb_latexmk *.fls *.log *.out *~
