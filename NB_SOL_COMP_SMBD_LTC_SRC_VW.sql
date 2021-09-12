REPLACE  VIEW PROD_NBR_VW.NB_SOL_COMP_SMBD_LTC_SRC_VW
AS LOCKING ROW FOR ACCESS 
(

SELECT 
  SRC_SOL.HLDG_KEY
, 0 AS APPL_ID
, SRC_SOL.AGMT_ID
, 'LTC' AS SRC_SYS
, SOL_MRG_AGCY_SRC_SYS_PRTY_ID AS SOL_MRG_AGY_SRC_SYS_PRTY_ID
, SOL_MRG_ENT_NM
, SOLICITING_AGT_FULL_NM
, SOLICITING_AGT_SRC_SYS_PRTY_ID
, SOLICITING_AGT_TYP_CD
, COMP.COMP_MRG_AGCY_SRC_SYS_PRTY_ID AS COMP_MRG_AGY_SRC_SYS_PRTY_ID
, COMP.COMP_MRG_ENT_NM
, COMP.COMP_AGT_FULL_NM AS COMP_SOL_AGT_FULL_NM
, COMP.COMP_AGT_SRC_SYS_PRTY_ID AS COMP_SOL_AGT_SRC_SYS_PRTY_ID
, COMP.COMP_AGT_TYP_CD AS COMP_SOL_AGT_TYP_CD
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(COMP_SM_BKD_SRC_SYS_PRTY_ID)))) AS COMP_SM_BKD_SRC_SYS_PRTY_ID
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(COMP_SM_BKD_NM)))) AS COMP_SM_BKD_NM
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_SRC_SYS_PRTY_ID)))) AS SOL_SM_BKD_SRC_SYS_PRTY_ID
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_NM))))  AS SOL_SM_BKD_NM
, COMP.SPLIT_STRT_DT
, COMP.SPLIT_END_DT
, COMP.SM_SPLIT_PCT
, 0 AS COMP_WEIGHTED_ANNUAL_PREM_AMT
, 0 AS COMP_ESTIMATED_FYC
, COMP.COMP_PCT
, 0 AS SOL_ESTIMATED_FYC
, 0 AS SOL_WEIGHTED_ANNUAL_PREM_AMT
, 0 AS HLDG_CR
, COMP.UNIT_STRT_DT
, COMP.UNIT_END_DT
FROM 

(
SELECT 

  AGMT_ID
, HLDG_KEY
, SOL_MRG_AGCY_SRC_SYS_PRTY_ID
, SOL_MRG_ENT_NM
, SOLICITING_AGT_TYP_CD
, SOLICITING_AGT_SRC_SYS_PRTY_ID
, SOLICITING_AGT_FULL_NM

 , MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SOL.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''  END) AS SOL_SM_BKD_SRC_SYS_PRTY_ID

, MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SOL.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE ''  END) AS SOL_SM_BKD_NM


FROM 





(

SELECT 
  AGMT_ID
, HLDG_KEY
, SOL_MRG_AGCY_SRC_SYS_PRTY_ID
, SOL_MRG_ENT_NM
, SOLICITING_AGT_TYP_CD
, SOLICITING_AGT_SRC_SYS_PRTY_ID
, SOLICITING_AGT_FULL_NM
 , HIERARCHY_SOL.SM_BKD_BP_ID 
 , HIERARCHY_SOL.SM_BKD_NM 
 , ROW_NUMBER() OVER (PARTITION BY  AGMT_ID  ORDER BY AGMT_ID , SM_BKD_BP_ID ) -1 AS   ROW_NUM_sol
FROM 


(
SELECT
AGMT.AGREEMENT_ID AS AGMT_ID,
TRIM(LEADING '0' FROM HLDG_KEY) HLDG_KEY,
PDCR_SVC.MRG_ENT_NB SOL_MRG_AGCY_SRC_SYS_PRTY_ID,
PDCR_SVC.MRG_ENT_NM SOL_MRG_ENT_NM,
 COALESCE(AGT_TYP_CD, (case when PDCR_SVC.CAS_IND='N' then 'CAB' else 'CAS' end) )  SOLICITING_AGT_TYP_CD ,
PDCR_SVC.BUSINESS_PARTNER_ID SOLICITING_AGT_SRC_SYS_PRTY_ID,
CASE WHEN char_length( trim(   PDCR_SVC.FIRST_NM   ) ) = 0
          AND  char_length( trim(  PDCR_SVC.LST_NM )) =  0 THEN  PDCR_SVC.FULL_NM 
     ELSE  PDCR_SVC.LST_NM || ', ' || PDCR_SVC.FIRST_NM
 END  SOLICITING_AGT_FULL_NM
 
 , HO_RECEIPT_DATE


 FROM
PROD_USIG_STND_VW.AGMT_CMN_VW AGMT 

LEFT OUTER JOIN 
(
SELECT 
A.AGREEMENT_ID,SUBSTR(A.AGT_WRTG_AGY_CD,8) AGT_WRTG_AGY_CD
,MRG_ENT_NB,'AA' || TRIM ( SUBSTR( A.BUSINESS_PARTNER_ID , 5 , 6 ) ) BUSINESS_PARTNER_ID
,  B.FIRST_NM, B.LST_NM,B.FULL_NM,B.CAS_IND,A.AGT_1ST_YR_COMM_PCT,A.AGT_COMM_SPLIT,ENT_VW.MRG_ENT_NM
FROM  PROD_USIG_STND_VW.PDCR_AGMT_CMN_VW A
 INNER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW B
    ON A.PRTY_ID=B.PRTY_ID
LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW
 ON ENT_NB = SUBSTR(A.AGT_WRTG_AGY_CD,8) 
WHERE A.AGREEMENT_SOURCE_CD in ('LFCARE','LTC')
 AND A.PRTY_AGMT_RLE_CD ='AGT'
  AND A.PRTY_AGMT_RLE_STYP_CD = 'SVC'
QUALIFY(row_number() over (partition by A.AGREEMENT_ID order by A.BUS_STRT_DT DESC))=1
) PDCR_SVC  on AGMT.AGREEMENT_ID=PDCR_SVC.AGREEMENT_ID



LEFT OUTER JOIN 
                           (	
									
											SELECT
															
											TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
											, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
											, PRD_REL_STRT_DT
											, PRD_REL_END_DT
									
											,  CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END AS AGT_TYP_CD																			

											FROM PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW  HIST
											 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											      ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                                        AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                        AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                                        AND SDT.SRC_CDE ='SAP'   
																					
											GROUP BY 1,2,3,4,5
															
															
									) AGT_TYP
      ON   AGT_TYP.PRD_BPID =  PDCR_SVC.BUSINESS_PARTNER_ID
     AND    AGMT.HO_RECEIPT_DATE    BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND PDCR_SVC.MRG_ENT_NB = AGT_TYP.AGY_LGCY_ID       

WHERE AGMT.AGREEMENT_SOURCE_CD in ('LFCARE','LTC')

				QUALIFY (ROW_NUMBER() OVER(PARTITION BY AGMT.AGREEMENT_ID    
		                  ORDER BY AGMT.AGREEMENT_ID  , CASE WHEN SOLICITING_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1
		                  
) LVL1
 

LEFT OUTER JOIN 
									(
										
															
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
															, SOLICITING_AGT_TYP_CD_s
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
																					, PRD_NM
																					, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	 AS SOLICITING_AGT_TYP_CD_s
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
																					WHERE SM_BKD_BPID IS NOT NULL 
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		) A
																			
									) HIERARCHY_SOL


ON 		UPPER(SOLICITING_AGT_SRC_SYS_PRTY_ID) = HIERARCHY_SOL.PRD_BPID 
AND 	TRIM(SOL_MRG_AGCY_SRC_SYS_PRTY_ID)=TRIM(HIERARCHY_SOL.AGY_LGCY_ID)
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_SOL.PRD_REL_STRT_DT AND HIERARCHY_SOL.PRD_REL_END_DT
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_SOL.PRD_UNT_REL_STRT_DT AND HIERARCHY_SOL.PRD_UNT_REL_END_DT
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_SOL.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY_SOL.SM_BKD_UNIT_REL_END_DT
AND   SOLICITING_AGT_TYP_CD = HIERARCHY_SOL.SOLICITING_AGT_TYP_CD_s
    
group by 1,2,3,4,5,6,7,8,9


--) SRC

) SOL

GROUP BY 1,2,3,4,5,6,7

)  SRC_SOL


INNER JOIN 


(
SELECT
AGMT_ID
,HLDG_KEY
,COMP_MRG_AGCY_SRC_SYS_PRTY_ID
,COMP_AGT_TYP_CD
,COMP_AGT_SRC_SYS_PRTY_ID
,COMP_AGT_FULL_NM
,COMP_MRG_ENT_NM
,COMP_PCT
 , COALESCE(HIERARCHY_COMP.SM_BKD_BP_ID,'UN-ASSIGNED')  AS COMP_SM_BKD_SRC_SYS_PRTY_ID
 , COALESCE(HIERARCHY_COMP.SM_BKD_NM,'UN-ASSIGNED')  AS COMP_SM_BKD_NM
, SM_SPLITS.BUS_STRT_DT AS SPLIT_STRT_DT
, SM_SPLITS.BUS_END_DT AS SPLIT_END_DT
, SM_SPLITS.SM_SPLIT_PCT AS SM_SPLIT_PCT
, MIN(HIERARCHY_COMP.PRD_UNT_REL_STRT_DT)  OVER(PARTITION BY    AGMT_ID,  COMP_AGT_SRC_SYS_PRTY_ID ,COMP_MRG_AGCY_SRC_SYS_PRTY_ID ) AS UNIT_STRT_DT
, HIERARCHY_COMP.PRD_UNT_REL_END_DT  AS   UNIT_END_DT

FROM
(

SELECT
AGMT.AGREEMENT_ID AS AGMT_ID,
TRIM(LEADING '0' FROM AGMT.HLDG_KEY) HLDG_KEY,
WRTG.MRG_ENT_NB COMP_MRG_AGCY_SRC_SYS_PRTY_ID,
 COALESCE(AGT_TYP_CD, (case when WRTG.CAS_IND='N' then 'CAB' else 'CAS' end) )  COMP_AGT_TYP_CD ,
WRTG.BUSINESS_PARTNER_ID COMP_AGT_SRC_SYS_PRTY_ID,
CASE WHEN char_length( trim(   WRTG.FIRST_NM   ) ) = 0
          AND  char_length( trim(  WRTG.LST_NM )) =  0 THEN  WRTG.FULL_NM 
     ELSE  WRTG.LST_NM || ', ' || WRTG.FIRST_NM
 END  COMP_AGT_FULL_NM
 ,MRG_ENT_NM AS COMP_MRG_ENT_NM
 ,WRTG.AGT_COMM_SPLIT*100  AS COMP_PCT
, HO_RECEIPT_DATE
 FROM
PROD_USIG_STND_VW.AGMT_CMN_VW AGMT 

LEFT OUTER JOIN 
(
SELECT 
A.AGREEMENT_ID, TRIM(LEADING '0' FROM A.HLDG_KEY) HLDG_KEY,SUBSTR(A.AGT_WRTG_AGY_CD,8) AGT_WRTG_AGY_CD,MRG_ENT_NB
,'AA' || TRIM ( SUBSTR( A.BUSINESS_PARTNER_ID , 5 , 6 ) ) BUSINESS_PARTNER_ID,  B.FIRST_NM, B.LST_NM
,B.FULL_NM,B.CAS_IND,A.AGT_COMM_SPLIT, ENT_VW.MRG_ENT_NM
FROM  PROD_USIG_STND_VW.PDCR_AGMT_CMN_VW A 
INNER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW B
 ON A.PRTY_ID=B.PRTY_ID
LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW
 ON ENT_NB = SUBSTR(A.AGT_WRTG_AGY_CD,8) 
WHERE A.AGREEMENT_SOURCE_CD in  ('LFCARE','LTC')
AND A.PRTY_AGMT_RLE_CD ='AGT'
 AND A.PRTY_AGMT_RLE_STYP_CD = 'WRTG'
) WRTG 
on  AGMT.AGREEMENT_ID=WRTG.AGREEMENT_ID


LEFT OUTER JOIN 
                           (	
									
											SELECT
															
											TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
											, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
											, PRD_REL_STRT_DT
											, PRD_REL_END_DT
									
											,  CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END AS AGT_TYP_CD																			

											FROM PROD_USIG_STND_VW.SALES_HIERARCHY_HIST_VW  HIST
											 INNER JOIN  PROD_USIG_CMN_VW.SRC_DATA_TRNSLT_VW SDT
											      ON   HIST.PRD_STD_CONTR_TYP= SDT.SRC_FLD_VAL
                                                        AND SDT.SRC_FLD_NM='CONTRACT_TYPE'
                                                        AND SDT.TRNSLT_FLD_NM ='SELLING AGREEMENT'
                                                        AND SDT.SRC_CDE ='SAP' 
																				
											GROUP BY 1,2,3,4,5
															
															
									) AGT_TYP
      ON   AGT_TYP.PRD_BPID =  WRTG.BUSINESS_PARTNER_ID
     AND    AGMT.HO_RECEIPT_DATE    BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND WRTG.MRG_ENT_NB = AGT_TYP.AGY_LGCY_ID       

WHERE AGMT.AGREEMENT_SOURCE_CD in ('LFCARE','LTC')

QUALIFY (ROW_NUMBER() OVER(PARTITION BY  AGMT.AGREEMENT_ID ,  WRTG.MRG_ENT_NB ,WRTG.BUSINESS_PARTNER_ID  
   ORDER BY  AGMT.AGREEMENT_ID ,  WRTG.MRG_ENT_NB, WRTG.BUSINESS_PARTNER_ID, CASE WHEN COMP_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1        

) LVL1
 

LEFT OUTER JOIN 
									(
										
															
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
															, SOLICITING_AGT_TYP_CD_s
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
																					, PRD_NM
																					, CASE WHEN SDT.TRNSLT_FLD_VAL IN ( 'CAR' ,'CARS')THEN 'CAS'   ELSE 'CAB' END	 AS SOLICITING_AGT_TYP_CD_s
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
																					WHERE SM_BKD_BPID IS NOT NULL 
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		) A
																			
									) HIERARCHY_COMP


ON 		UPPER(COMP_AGT_SRC_SYS_PRTY_ID) = HIERARCHY_COMP.PRD_BPID 
AND 	TRIM(COMP_MRG_AGCY_SRC_SYS_PRTY_ID)=TRIM(HIERARCHY_COMP.AGY_LGCY_ID)
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_COMP.PRD_REL_STRT_DT AND HIERARCHY_COMP.PRD_REL_END_DT
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_COMP.PRD_UNT_REL_STRT_DT AND HIERARCHY_COMP.PRD_UNT_REL_END_DT
AND	 LVL1.HO_RECEIPT_DATE BETWEEN HIERARCHY_COMP.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY_COMP.SM_BKD_UNIT_REL_END_DT
AND    LVL1.COMP_AGT_TYP_CD = HIERARCHY_COMP.SOLICITING_AGT_TYP_CD_s
    
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


ON		COMP_AGT_SRC_SYS_PRTY_ID = SM_SPLITS.PRD_BPID
AND	HIERARCHY_COMP.SM_BKD_BP_ID = SM_SPLITS.SM_BPID
AND	LVL1.HO_RECEIPT_DATE BETWEEN SM_SPLITS.BUS_STRT_DT AND SM_SPLITS.BUS_END_DT   



QUALIFY (ROW_NUMBER() OVER(PARTITION BY    AGMT_ID, COMP_AGT_SRC_SYS_PRTY_ID ,COMP_MRG_AGCY_SRC_SYS_PRTY_ID, HIERARCHY_COMP.SM_BKD_BP_ID
  ORDER BY AGMT_ID, COMP_AGT_SRC_SYS_PRTY_ID , HIERARCHY_COMP.SM_BKD_BP_ID   ) - 1) = 0
--group by 1,2,3,4,5,6,7,8,9,10,11,12,13,15


) COMP

ON COMP.AGMT_ID= SRC_SOL.AGMT_ID
) ;