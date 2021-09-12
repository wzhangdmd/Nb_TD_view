REPLACE VIEW PROD_NBR_VW.NB_SOL_COMP_SMBD_LIFE_SRC_VW
AS LOCKING ROW FOR ACCESS 
(

SELECT 
      SOL.HLDG_KEY,
      SOL.APPL_ID ,
      0 AS AGMT_ID ,
      CASE WHEN  SOL.SRC_SYS_ID=32 THEN 'TPP' ELSE 'WINRISK'  END AS SRC_SYS  ,
      SOL_MRG_AGY_SRC_SYS_PRTY_ID,
      SOL_MRG_ENT_NM ,
      SOLICITING_AGT_FULL_NM,
      SOLICITING_AGT_SRC_SYS_PRTY_ID ,
      SOLICITING_AGT_TYP_CD AS SOLICITING_AGT_TYP_CD,
      COMP.COMP_MRG_AGY_SRC_SYS_PRTY_ID,
      COMP.COMP_SOL_AGT_SRC_SYS_PRTY_ID ,
      COMP.COMP_MRG_ENT_NM ,
      COMP.COMP_SOL_AGT_FULL_NM ,
      COMP.COMP_AGT_TYP_CD AS COMP_SOL_AGT_TYP_CD,
      TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(COMP_SM_BKD_SRC_SYS_PRTY_ID))))  AS COMP_SM_BKD_SRC_SYS_PRTY_ID,
      TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(COMP_SM_BKD_NM))))   AS COMP_SM_BKD_NM,
      TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_SRC_SYS_PRTY_ID)))) AS SOL_SM_BKD_SRC_SYS_PRTY_ID,
      TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_NM)))) AS SOL_SM_BKD_NM,
      COMP.SPLIT_STRT_DT ,
      COMP.SPLIT_END_DT ,
      COMP.SM_SPLIT_PCT ,
      0 AS COMP_WEIGHTED_ANNUAL_PREM_AMT ,
      0 AS COMP_ESTIMATED_FYC ,
       COMP.COMP_PCT ,
      0 AS SOL_ESTIMATED_FYC ,
      0 AS  SOL_WEIGHTED_ANNUAL_PREM_AMT ,
      0 AS HLDG_CR ,
      COMP.UNIT_STRT_DT,
      COMP.UNIT_END_DT




FROM 



(
SELECT 
  HLDG_KEY
 ,APPL_ID 
 ,SOL_MRG_AGY_SRC_SYS_PRTY_ID
 ,SOL_MRG_ENT_NM
, SOLICITING_AGT_FULL_NM
 ,SOLICITING_AGT_SRC_SYS_PRTY_ID
 ,SOLICITING_AGT_TYP_CD
 ,SRC_SYS_ID
 , MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) AS SOL_SM_BKD_SRC_SYS_PRTY_ID

, MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SRC_SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) AS SOL_SM_BKD_NM

FROM 

(

SELECT 
  HLDG_KEY
 ,APPL_ID 
 ,SOL_MRG_AGY_SRC_SYS_PRTY_ID
 ,SOL_MRG_ENT_NM
, SOLICITING_AGT_FULL_NM
 ,SOLICITING_AGT_SRC_SYS_PRTY_ID
 ,SOLICITING_AGT_TYP_CD
 ,SRC_SYS_ID
 , SM_BKD_BP_ID 
, SM_BKD_NM 
, ROW_NUMBER() OVER (PARTITION BY  HLDG_KEY,APPL_ID  ORDER BY HLDG_KEY , HIERARCHY_SOL.SM_BKD_BP_ID ) -1 AS   ROW_NUM_sol

FROM
(
      
SELECT 
       APPL.HLDG_KEY
     , APPL.APPL_ID 
     , TRIM( ENT.MRG_ENT_NB )  AS SOL_MRG_AGY_SRC_SYS_PRTY_ID
     , ENT_sol.MRG_ENT_NM AS SOL_MRG_ENT_NM 
     , CASE WHEN  TRIM(PDCR.FIRST_NM) = ''  OR TRIM(PDCR.LST_NM) = ''  THEN  TRIM(FULL_NM)
       ELSE  COALESCE((TRIM(BOTH FROM PDCR.LST_NM) || ', ' || TRIM(BOTH FROM PDCR.FIRST_NM)), LST_NM) 
       END  AS SOLICITING_AGT_FULL_NM
      , 'AA' || SUBSTR('000000' , 1 ,6-CHAR_LENGTH( TRIM(BOTH FROM (CAST(SPLT.BP_ID AS CHAR(6)))) )) || TRIM(BOTH FROM SPLT.BP_ID)  AS SOLICITING_AGT_SRC_SYS_PRTY_ID 
      , COALESCE(SMBD.AGT_TYP_CD, AGT_TYP_CD_2,
          CASE	 WHEN APPL.BRKRG_IND = 'Y' THEN 'CAB'
                     WHEN APPL.BRKRG_IND = 'N' THEN 'CAS'
         ELSE NULL
		 END ) AS SOLICITING_AGT_TYP_CD

      , APPL.SRC_SYS_ID
      ,  APPL.APPL_ADE_DT
      ,  AGT_FIRM_BPID
      
FROM PROD_NBR_VW.NB_APPL_VW   APPL

LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW ENT
		ON		ENT.ENT_NB = APPL.SLCT_AGY 

 LEFT OUTER JOIN PROD_NBR_VW.MRG_ENT_VW ENT_sol
  ON  SOL_MRG_AGY_SRC_SYS_PRTY_ID = ENT_sol.MRG_ENT_NB
  
  LEFT OUTER JOIN PROD_NBR_VW.NB_BP_COMM_SPLT_VW SPLT
		ON		APPL.APPL_ID = SPLT.APPL_ID
		AND   SPLT.SRC_SYS_ID in (32,36)
		AND 	SPLT.BP_COMM_SPLT_TO_DT =  '9999-12-31 00:00:00.000000'
		AND 	SPLT.SRC_AGT_TYP IN ('Y','1000001','1000002')
		
LEFT OUTER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW PDCR
       ON  SOLICITING_AGT_SRC_SYS_PRTY_ID= ('AA' || TRIM ( SUBSTR(PDCR.BUSINESS_PARTNER_ID , 5 , 6 ) ))		


LEFT OUTER JOIN (SELECT   TRIM(LEADING '0' FROM SVC.HLDG_KEY) HLDG_KEY  
                                                      ,  'AA' || TRIM ( SUBSTR( SVC.BUSINESS_PARTNER_ID , 5 , 6 ) ) AS SOL_PRD_BPID
                                                      , CASE WHEN SVC.AGT_FIRM_BPID='' THEN NULL ELSE SVC.AGT_FIRM_BPID END AS AGT_FIRM_BPID
                                                      ,  CASE WHEN SDT.TRNSLT_FLD_VAL IN  ( 'CAR' ,'CARS' ) THEN 'CAS'   ELSE 'CAB' END AGT_TYP_CD   
                                                      , SLLNG.BUS_STRT_DT  BUS_STRT_DT_s
                                                      , SLLNG.BUS_END_DT        BUS_END_DT_s                                                                                             
                                         FROM  PROD_USIG_STND_VW.PDCR_AGMT_CMN_VW SVC 
                                                      ,(SELECT CONTR_SRC_ALT_ID,STD_CONTR_TYP_CD,BUS_STRT_DT,BUS_END_DT
                                                                FROM  PROD_USIG_STND_VW.SLLNG_AGMT_HIST_VW GROUP BY 1,2,3,4) SLLNG 
                                                      ,PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
                                                 WHERE  SVC.AGT_CONTR_SRC_ALT_ID = SLLNG.CONTR_SRC_ALT_ID
                                                       AND  SLLNG.STD_CONTR_TYP_CD= SDT.SRC_FLD_VAL
                                                       AND  SVC.SRC_SYS_ID = 79 
                                                        AND SVC.PRTY_AGMT_RLE_CD ='AGT' 
                                                        AND SVC.PRTY_AGMT_RLE_STYP_CD ='SVC'                                                                                   
                                                        AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                        AND SDT.SRC_CDE ='SAP'                                            
                                            )  SMBD
 ON APPL.HLDG_KEY  =  SMBD.HLDG_KEY
 AND SOLICITING_AGT_SRC_SYS_PRTY_ID = SMBD.SOL_PRD_BPID
AND   APPL.APPL_ADE_DT          BETWEEN  SMBD.BUS_STRT_DT_s AND  SMBD.BUS_END_DT_s    


LEFT OUTER JOIN 
                           (	/*		HIERARCHY -- Get Agent Type (CAS/CAB)  information for Producer when Policy was Submitted		*/
									
											SEL  DISTINCT
															
											TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
											, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
											, PRD_REL_STRT_DT
											, PRD_REL_END_DT
											, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	  AS AGT_TYP_CD_2																			

											FROM PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW  HIST 
											 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											   ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                              AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                             AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                             AND SDT.SRC_CDE ='SAP'   											
											WHERE  HIER_DEPTH = '1'											
											GROUP BY 1,2,3,4,5
															
															
									) AGT_TYP
      ON   AGT_TYP.PRD_BPID =   SOLICITING_AGT_SRC_SYS_PRTY_ID      
     AND  CAST(APPL.APPL_ADE_DT  AS DATE) BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND SOL_MRG_AGY_SRC_SYS_PRTY_ID = AGT_TYP.AGY_LGCY_ID          
      AND CASE WHEN SMBD.AGT_TYP_CD  IS NOT NULL THEN  2 ELSE 1 END =1
      

WHERE 	APPL.APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
		AND 	APPL.APPL_ID NOT IN (9882896) -- TO EXCLUDE THE POLICY NUMBER  WITH TWO ACTIVE SOLICITING AGENTS
		AND   APPL.SRC_SYS_ID in (32,36)   
		AND   APPL.APPL_TYP  IN ('NEWAPP','ADD', 'ALT', 'CNC', 'CNV', 'EXC', 'INC', 'OPT', 'ORW')
		      
				QUALIFY (ROW_NUMBER() OVER(PARTITION BY APPL.HLDG_KEY ,APPL.APPL_ID   
		                  ORDER BY APPL.HLDG_KEY , CASE WHEN SOLICITING_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1

) LVL1

LEFT OUTER JOIN 
									(
										
															
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
															,FIRM_BPID
															, HIER_AGT_TYP_CD
													 		 ,PRD_REL_STRT_DT
											                , PRD_REL_END_DT
											                , PRD_UNT_REL_STRT_DT 
											                , PRD_UNT_REL_END_DT
											                , SM_BKD_UNIT_REL_STRT_DT
											                , SM_BKD_UNIT_REL_END_DT											                
															

															FROM (
											
																					SEL  DISTINCT
																					TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
																					, 'AA' || TRIM ( SUBSTR( SM_BKD_BPID , 5 , 6 ) ) AS SM_BKD_BP_ID
																					, SM_BKD_NM 
																					, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
																					, FIRM_BPID
																					, PRD_NM
																					, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	 AS HIER_AGT_TYP_CD
																					,PRD_REL_STRT_DT
											                                        , PRD_REL_END_DT
											                                        , PRD_UNT_REL_STRT_DT -- minimum because it seems PRD will have a different PRD_UNT_STRT_DT when under different MAs within the UNT
											                                        , PRD_UNT_REL_END_DT
											                                        , SM_BKD_UNIT_REL_STRT_DT
											                                        , SM_BKD_UNIT_REL_END_DT	
																					
																					FROM  PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW HIST
																						 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											                                           ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                                                                          AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                                                          AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                                                                          AND SDT.SRC_CDE ='SAP'   
																					      AND  SM_BKD_BPID IS NOT NULL 
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		) A
								 									

									
									) HIERARCHY_SOL


ON 		UPPER(SOLICITING_AGT_SRC_SYS_PRTY_ID) = HIERARCHY_SOL.PRD_BPID 
AND 	TRIM(SOL_MRG_AGY_SRC_SYS_PRTY_ID)=TRIM(HIERARCHY_SOL.AGY_LGCY_ID)
AND	LVL1.APPL_ADE_DT BETWEEN HIERARCHY_SOL.PRD_REL_STRT_DT AND HIERARCHY_SOL.PRD_REL_END_DT
AND	LVL1.APPL_ADE_DT BETWEEN HIERARCHY_SOL.PRD_UNT_REL_STRT_DT AND HIERARCHY_SOL.PRD_UNT_REL_END_DT
AND	LVL1.APPL_ADE_DT BETWEEN HIERARCHY_SOL.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY_SOL.SM_BKD_UNIT_REL_END_DT
AND   SOLICITING_AGT_TYP_CD = HIERARCHY_SOL.HIER_AGT_TYP_CD
AND   COALESCE(AGT_FIRM_BPID,'NA' ) = COALESCE(HIERARCHY_SOL.FIRM_BPID,'NA')

		
QUALIFY (ROW_NUMBER() OVER(PARTITION BY HLDG_KEY ,APPL_ID, SM_BKD_BP_ID  ORDER BY HLDG_KEY , SM_BKD_BP_ID) - 1) = 0		

) SRC_SOL

 GROUP BY 1,2,3,4,5,6,7,8
 
) SOL

INNER JOIN 

(
SELECT 
COMP_MRG_AGY_SRC_SYS_PRTY_ID
,COMP_MRG_ENT_NM
,COMP_SOL_AGT_SRC_SYS_PRTY_ID
,COMP_SOL_AGT_FULL_NM
,COMP_AGT_TYP_CD
,HLDG_KEY
,APPL_ID
,COMP_PCT
, COALESCE(HIERARCHY.SM_BKD_BP_ID,'UN-ASSIGNED')  AS COMP_SM_BKD_SRC_SYS_PRTY_ID
, COALESCE(HIERARCHY.SM_BKD_NM,'UN-ASSIGNED')  AS COMP_SM_BKD_NM  
, MIN(HIERARCHY.PRD_UNT_REL_STRT_DT) OVER(PARTITION BY HLDG_KEY , APPL_ID,  COMP_MRG_AGY_SRC_SYS_PRTY_ID, COMP_SOL_AGT_SRC_SYS_PRTY_ID) AS UNIT_STRT_DT
, HIERARCHY.PRD_UNT_REL_END_DT AS UNIT_END_DT
 ,SM_SPLITS.BUS_STRT_DT AS SPLIT_STRT_DT
 ,SM_SPLITS.BUS_END_DT AS SPLIT_END_DT
 ,SM_SPLITS.SM_SPLIT_PCT AS SM_SPLIT_PCT
 
FROM 

(

SELECT 

 ENT_comp.MRG_ENT_NB AS COMP_MRG_AGY_SRC_SYS_PRTY_ID
 
 , ( 'AA' || SUBSTR('000000' , 1 ,6-CHAR_LENGTH( TRIM(BOTH FROM (CAST(SPLT.BP_ID AS CHAR(6)))) ))
      || TRIM(BOTH FROM SPLT.BP_ID))  AS COMP_SOL_AGT_SRC_SYS_PRTY_ID
      
 ,ENT_comp.MRG_ENT_NM AS COMP_MRG_ENT_NM
 
 ,(COALESCE( TRIM(  CASE 	WHEN TRIM(LIFE.LST_NM) = ''  AND TRIM(LIFE.FRST_NM) = ''  THEN COALESCE ( TRIM( LIFE.FULL_NM ) , ' ' ) 
                                     ELSE TRIM ( LIFE.LST_NM ) || ', ' || TRIM( TRIM ( LIFE.FRST_NM ) ||' ' || TRIM(LIFE.SFX_NM) ) 
                                    END ) , 'Unknown' )) AS COMP_SOL_AGT_FULL_NM
                                    

,COALESCE(  PDCR.AGT_TYP_CD   , AGT_TYP.AGT_TYP_CD_2)  COMP_AGT_TYP_CD
,SRC.HLDG_KEY
,SRC.APPL_ID
, SPLT.FRST_YR_COMM AS COMP_PCT
, SRC.APPL_ADE_DT
 ,SRC.SRC_SYS_ID
, ENT_NB
 ,AGT_FIRM_BPID


FROM  PROD_NBR_VW.NB_APPL_VW  SRC


 LEFT OUTER JOIN  PROD_NBR_VW.NB_BP_COMM_SPLT_VW  SPLT
    ON SRC.APPL_ID = SPLT.APPL_ID
    AND	SPLT.BP_COMM_SPLT_TO_DT = '9999-12-31 00:00:00.000000'
    AND  SPLT.SRC_SYS_ID in (32,36)

 LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW ENT_comp
     ON  ENT_Comp.ENT_NB = SPLT.PRNT_SEL_AGY    
     

  LEFT OUTER JOIN (SELECT LST_NM,FRST_NM,FULL_NM,NM.SFX_NM , BP_ID
                                           FROM PROD_STND_VW.PDCR_XREF_VW PDCR_XREF
                                         LEFT OUTER JOIN PROD_STND_VW.NM_VW NM
                                           ON PDCR_XREF.PDCR_PRTY_ID = NM.PRTY_ID
                                           AND	NM.NM_END_DT = '9999-12-31 00:00:00.000000'
                                         AND 	NM.NM_TYP_CD = 'FULL'
                                        ) LIFE 
ON		SUBSTR('0000000000' , 1 ,10-CHAR_LENGTH( TRIM(BOTH FROM (CAST(SPLT.BP_ID AS CHAR(10)))) )) || TRIM(BOTH FROM SPLT.BP_ID)  = LIFE.BP_ID     





 LEFT OUTER JOIN (SELECT   TRIM(LEADING '0' FROM SVC.HLDG_KEY) HLDG_KEY  
                                                      ,  'AA' || TRIM ( SUBSTR( SVC.BUSINESS_PARTNER_ID , 5 , 6 ) ) AS COMP_PRD_BPID
                                                      ,  CASE WHEN SVC.AGT_FIRM_BPID='' THEN NULL ELSE SVC.AGT_FIRM_BPID END AS AGT_FIRM_BPID
                                                      ,   CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS' ) THEN 'CAS'   ELSE 'CAB' END AGT_TYP_CD   
                                                      , SLLNG.BUS_STRT_DT  BUS_STRT_DT_s
                                                      , SLLNG.BUS_END_DT        BUS_END_DT_s                                                                                             
                                         FROM  PROD_USIG_STND_VW.PDCR_AGMT_CMN_VW SVC 
                                                      ,(SELECT CONTR_SRC_ALT_ID,STD_CONTR_TYP_CD,BUS_STRT_DT,BUS_END_DT
                                                                FROM  PROD_USIG_STND_VW.SLLNG_AGMT_HIST_VW GROUP BY 1,2,3,4) SLLNG 
                                                      ,PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
                                                 WHERE  SVC.AGT_CONTR_SRC_ALT_ID = SLLNG.CONTR_SRC_ALT_ID
                                                       AND  SLLNG.STD_CONTR_TYP_CD= SDT.SRC_FLD_VAL
                                                       AND  SVC.SRC_SYS_ID = 79 
                                                        AND SVC.PRTY_AGMT_RLE_CD ='AGT' 
                                                        AND SVC.PRTY_AGMT_RLE_STYP_CD ='WRTG'                                                                                   
                                                        AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                        AND SDT.SRC_CDE ='SAP'                                                                                       
                                            )  PDCR
 ON SRC.HLDG_KEY  =  PDCR.HLDG_KEY   
 AND    COMP_SOL_AGT_SRC_SYS_PRTY_ID = COMP_PRD_BPID   
AND   SRC.APPL_ADE_DT          BETWEEN  PDCR.BUS_STRT_DT_s AND  PDCR.BUS_END_DT_s      


LEFT OUTER JOIN 
                           (	/*		HIERARCHY -- Get Agent Type (CAS/CAB)  information for Producer when Policy was Submitted		*/
									
									
											SEL  DISTINCT
															
											TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
											, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
											, PRD_REL_STRT_DT
											, PRD_REL_END_DT
											, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	  AS AGT_TYP_CD_2																			

											FROM PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW  HIST 
											 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											   ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                              AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                             AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                             AND SDT.SRC_CDE ='SAP'   											
											WHERE  HIER_DEPTH = '1'
															
															
									) AGT_TYP
      ON   AGT_TYP.PRD_BPID =   COMP_SOL_AGT_SRC_SYS_PRTY_ID      
     AND  CAST(SRC.APPL_ADE_DT AS DATE) BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND (ENT_comp.MRG_ENT_NB = AGT_TYP.AGY_LGCY_ID
              OR
                  ENT_Comp.ENT_NB = AGT_TYP.AGY_LGCY_ID       )
      AND CASE WHEN PDCR.AGT_TYP_CD  IS NOT NULL THEN  2 ELSE 1 END =1
      
WHERE 	SRC.APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
		AND 	SRC.APPL_ID NOT IN (9882896) -- TO EXCLUDE THE POLICY NUMBER  WITH TWO ACTIVE SOLICITING AGENTS
		AND   SRC.SRC_SYS_ID in (32,36)  
        AND   SRC.APPL_TYP  IN ('NEWAPP','ADD', 'ALT', 'CNC', 'CNV', 'EXC', 'INC', 'OPT', 'ORW')      

      				QUALIFY (ROW_NUMBER() OVER(PARTITION BY SRC.HLDG_KEY ,SRC.APPL_ID, ENT_comp.MRG_ENT_NB ,SPLT.BP_ID  
		                  ORDER BY SRC.HLDG_KEY ,SRC.APPL_ID,  ENT_comp.MRG_ENT_NB, SPLT.BP_ID, CASE WHEN COMP_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1        

) LVL1

LEFT OUTER JOIN 
									(	/*		HIERARCHY -- Get Sales Manager/Brokerage Director information for when Policy was Submitted		*/
									
									
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
															, FIRM_BPID
															, HIER_AGT_TYP_CD
													 		 ,PRD_REL_STRT_DT
											                , PRD_REL_END_DT
											                , PRD_UNT_REL_STRT_DT 
											                , PRD_UNT_REL_END_DT
											                , SM_BKD_UNIT_REL_STRT_DT
											                , SM_BKD_UNIT_REL_END_DT											                
															

															FROM (
											
																					SEL  DISTINCT
																					TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
																					, 'AA' || TRIM ( SUBSTR( SM_BKD_BPID , 5 , 6 ) ) AS SM_BKD_BP_ID
																					, SM_BKD_NM 
																					, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
																					, FIRM_BPID
																					, PRD_NM
																					, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	 AS HIER_AGT_TYP_CD
																					,PRD_REL_STRT_DT
											                                        , PRD_REL_END_DT
											                                        , PRD_UNT_REL_STRT_DT -- minimum because it seems PRD will have a different PRD_UNT_STRT_DT when under different MAs within the UNT
											                                        , PRD_UNT_REL_END_DT
											                                        , SM_BKD_UNIT_REL_STRT_DT
											                                        , SM_BKD_UNIT_REL_END_DT	
																					
																					FROM  PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW HIST
																						 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											                                           ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                                                                          AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                                                          AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                                                                          AND SDT.SRC_CDE ='SAP'   
																					      AND  SM_BKD_BPID IS NOT NULL 
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		
                                               ) A 
															
									
									) HIERARCHY
									
ON		(COMP_MRG_AGY_SRC_SYS_PRTY_ID = HIERARCHY.AGY_LGCY_ID OR  LVL1.ENT_NB = HIERARCHY.AGY_LGCY_ID )
AND	COMP_SOL_AGT_SRC_SYS_PRTY_ID = HIERARCHY.PRD_BPID
AND	APPL_ADE_DT BETWEEN HIERARCHY.PRD_REL_STRT_DT AND HIERARCHY.PRD_REL_END_DT
AND	APPL_ADE_DT BETWEEN HIERARCHY.PRD_UNT_REL_STRT_DT AND HIERARCHY.PRD_UNT_REL_END_DT
AND	APPL_ADE_DT BETWEEN HIERARCHY.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY.SM_BKD_UNIT_REL_END_DT
AND   HIERARCHY.HIER_AGT_TYP_CD = COMP_AGT_TYP_CD
AND   COALESCE(AGT_FIRM_BPID,'NA' ) = COALESCE(HIERARCHY.FIRM_BPID,'NA')



LEFT OUTER JOIN 
									(	/*		SM Splits -- Get Sales Manager Split % information for when Policy was Submitted		*/
									
									SELECT	 
									
									'AA' || SUBSTR( PRD_SRC_PRTY_ALT_ID , 5 , 6 ) AS PRD_BPID
									, 'AA' || SUBSTR( SM_SRC_PRTY_ALT_ID , 5 , 6 ) AS SM_BPID
									, CAST( SM_SPLIT_PCT AS DEC(5,2) ) AS SM_SPLIT_PCT
									, CAST( BUS_STRT_DT AS DATE ) AS BUS_STRT_DT
									, CAST( BUS_END_DT AS DATE ) AS BUS_END_DT
									
									FROM	PROD_STND_PRTY_VW.SLLNG_AGMT_SM_SPLIT_VW A
									
									WHERE SLLNG_AGMT_SM_SPLIT_TO_DT = '9999-12-31 00:00:00.000000'
									AND INVLD_VER_IND = ' '


									) SM_SPLITS


ON		COMP_SOL_AGT_SRC_SYS_PRTY_ID = SM_SPLITS.PRD_BPID
AND	HIERARCHY.SM_BKD_BP_ID = SM_SPLITS.SM_BPID
AND	APPL_ADE_DT BETWEEN SM_SPLITS.BUS_STRT_DT AND SM_SPLITS.BUS_END_DT



QUALIFY (ROW_NUMBER() OVER(PARTITION BY HLDG_KEY ,APPL_ID,  COMP_MRG_AGY_SRC_SYS_PRTY_ID, COMP_SOL_AGT_SRC_SYS_PRTY_ID,HIERARCHY.SM_BKD_BP_ID
                                            ORDER BY HLDG_KEY ,COMP_SOL_AGT_SRC_SYS_PRTY_ID, HIERARCHY.SM_BKD_BP_ID  ) - 1) = 0

) COMP

ON SOL.APPL_ID = COMP.APPL_ID
);
