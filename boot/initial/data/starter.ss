#V3.30.16;_Stock_Synthesis_by_Richard_Methot_(NOAA)
#_File written by GUI version 3.30.16.2
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#C setup of Herring SD 30-31
HerringSD3031_datav3_30_10_DG_2023_ass.dat #_data file name
HerringSD3031_ctlv3_30_10_DG_2023_ass.ctl #_control file name
0    #_0=use init values in control file; 1=use ss.par
1    #_run display detail (0,1,2)
1    #_detailed age-structured reports in REPORT.SSO (0-3)
0    #_write detailed checkup.sso file (0,1)
0    #_write parm values to ParmTrace.sso (0=no,1=good,active; 2=good,all; 3=every_iter,all_parms; 4=every,active)
0    #_write to cumreport.sso (0=no,1=like&timeseries; 2=add survey fits)
1    #_Include prior_like for non-estimated parameters (0,1)
1    #_Use Soft Boundaries to aid convergence (0,1) (recommended)
1    #_Number of datafiles to produce: 1st is input, 2nd is estimates, 3rd and higher are bootstrap
10   #_Turn off estimation for parameters entering after this phase
1    #_MCeval burn interval
1    #_MCeval thin interval
0    #_jitter initial parm value by this fraction
1950 #_min yr for sdreport outputs (-1 for styr)
2025 #_max yr for sdreport outputs (-1 for endyr; -2 for endyr+Nforecastyrs)
0    #_N individual STD years
#vector of year values

0.0001 #_final convergence criteria (e.g. 1.0e-04)
0    #_retrospective year relative to end year (e.g. -4)
0    #_min age for calc of summary biomass
1    #_Depletion basis:  denom is: 0=skip; 1=rel X*B0; 2=rel X*Bmsy; 3=rel X*B_styr; 4=rel X*B_endyr
1    #_Fraction (X) for Depletion denominator (e.g. 0.4)
1    #_SPR_report_basis:  0=skip; 1=(1-SPR)/(1-SPR_tgt); 2=(1-SPR)/(1-SPR_MSY); 3=(1-SPR)/(1-SPR_Btarget); 4=rawSPR
5    #_F_report_units: 0=skip; 1=exploitation(Bio); 2=exploitation(Num); 3=sum(Frates); 4=true F for range of ages; 5=ave F for range of ages
 3 7 #_min and max age over which average F will be calculated
0    #_F_std_basis: 0=raw_F_report; 1=F/Fspr; 2=F/Fmsy ; 3=F/Fbtgt
0    #_MCMC output detail (0=default; 1=obj func components; 2=expanded; 3=make output subdir for each MCMC vector)
0    #_ALK tolerance (example 0.0001)
3.30 #_check value for end of file and for version control
