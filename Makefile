########################################################################
## Title: Makefile for creating the FAO Strategic Objective Dashboards
## Date: 2013-09-19
########################################################################

all: so1pdf so2pdf so3pdf so4pdf so5pdf

so1a:    
	sed -i 's/SO = "so[0-9]"/SO = "so1"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so1"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R


so1b:    
	sed -i 's/SO = "so[0-9]"/SO = "so1"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so1"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R

so1pdf: so1a so1b
	make -C ./dashboard_so1/ pdf


so2a:    
	sed -i 's/SO = "so[0-9]"/SO = "so2"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so2"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R


so2b:    
	sed -i 's/SO = "so[0-9]"/SO = "so2"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so2"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R

so2pdf: so2a so2b
	make -C ./dashboard_so2/ pdf


so3a:    
	sed -i 's/SO = "so[0-9]"/SO = "so3"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so3"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R


so3b:    
	sed -i 's/SO = "so[0-9]"/SO = "so3"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so3"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R

so3pdf: so3a so3b
	make -C ./dashboard_so3/ pdf

so4a:    
	sed -i 's/SO = "so[0-9]"/SO = "so4"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so4"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R


so4b:    
	sed -i 's/SO = "so[0-9]"/SO = "so4"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so4"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R

so4pdf: so4a so4b
	make -C ./dashboard_so4/ pdf


so5a:    
	sed -i 's/SO = "so[0-9]"/SO = "so5"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so5"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "A"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R


so5b:    
	sed -i 's/SO = "so[0-9]"/SO = "so5"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "timeseries"/template = "benchmark"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R
	sed -i 's/SO = "so[0-9]"/SO = "so5"/g' generate_dashboard.R
	sed -i 's/version = "[AB]"/version = "B"/g' generate_dashboard.R
	sed -i 's/template = "benchmark"/template = "timeseries"/g' generate_dashboard.R 
	R --vanilla --slave < generate_dashboard.R

so5pdf: so5a so5b
	make -C ./dashboard_so5/ pdf


objects := *.sty *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls \
	*.dvi *.ps *.hd *.los


objectspdf := *.tex *.pdf

clean:
	$(RM) $(addprefix ./dashboard_so1/, $(objects))
	$(RM) $(addprefix ./dashboard_so2/, $(objects))
	$(RM) $(addprefix ./dashboard_so3/, $(objects))
	$(RM) $(addprefix ./dashboard_so4/, $(objects))
	$(RM) $(addprefix ./dashboard_so5/, $(objects))

veryclean: clean
	$(RM) $(addprefix ./dashboard_so1/, $(objectspdf))
	$(RM) $(addprefix ./dashboard_so2/, $(objectspdf))
	$(RM) $(addprefix ./dashboard_so3/, $(objectspdf))
	$(RM) $(addprefix ./dashboard_so4/, $(objectspdf))
	$(RM) $(addprefix ./dashboard_so5/, $(objectspdf))

cpmake:
	cp ./dashboard_so1/Makefile ./dashboard_so2/
	cp ./dashboard_so1/Makefile ./dashboard_so3/
	cp ./dashboard_so1/Makefile ./dashboard_so4/
	cp ./dashboard_so1/Makefile ./dashboard_so5/

