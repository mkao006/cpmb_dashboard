CPMB monitoring dashboard
=========================


**Setup**

First, the LaTeX package *faoscorecard* needs to be install on the
machine. Please refer to installation instruction depending on your
operating system.

**Descriptions**

1. meta_data_new.csv

This is file contains the dissemination information, the file was
received from Adam Prakash. It is used to decide what variables are
included in each of the Strategic Objective dashboard.

2. dashboard_package.R

This script contains all the necessary function to generate the dashboard.

3. generate_dashboard.R

This script generates the dashboards depending on the initial
parameter and the template type.

4. radarChart.R

This piece of code produces the prototype of the radar chart that was
proposed to the CPMB, the labels were processed in Microsoft
Powerpoint.


**Instruction**
If you have *Make* utility, simply run

```
make
```

To produce all four version of the report for each of the SO
dashboard. 

To make specific version:

```
### Make SO1 version A
make so1a

## Make all SO1 deshboard
make so1pdf
```


If *Make* is not available, then manually change them in
*generate_dashboard.R* to generate the desired dashboard and the
folders become irrelevant.



