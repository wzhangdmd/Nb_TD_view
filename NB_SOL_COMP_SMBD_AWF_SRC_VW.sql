REPLACE VIEW PROD_NBR_VW.NB_SOL_COMP_SMBD_AWF_SRC_VW
AS LOCKING ROW FOR ACCESS
(
SELECT 

  SOL.HLDG_KEY
, SOL.APPL_ID
, 0 AS AGMT_ID
, 'AWF' SRC_SYS
, SOL.SOL_MRG_AGY_SRC_SYS_PRTY_ID   AS SOL_MRG_AGY_SRC_SYS_PRTY_ID
, SOL.SOL_MRG_ENT_NM
, SOL.SOLICITING_AGT_FULL_NM   AS SOLICITING_AGT_FULL_NM
, SOL.SOLICITING_AGT_SRC_SYS_PRTY_ID    AS SOLICITING_AGT_SRC_SYS_PRTY_ID
, SOL.SOLICITING_AGT_TYP_CD
, COMP_MRG_AGY_SRC_SYS_PRTY_ID
, COMP_SOL_AGT_SRC_SYS_PRTY_ID
, COMP_MRG_ENT_NM
, COMP_SOL_AGT_FULL_NM
, COMP_SOL_AGT_TYP_CD
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM( COMP_SM_BKD_SRC_SYS_PRTY_ID)))) AS COMP_SM_BKD_SRC_SYS_PRTY_ID
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(COMP_SM_BKD_NM)))) AS COMP_SM_BKD_NM
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_SRC_SYS_PRTY_ID)))) AS SOL_SM_BKD_SRC_SYS_PRTY_ID
, TRIM(TRIM( TRAILING '/' FROM TRIM(LEADING '/' FROM TRIM(SOL_SM_BKD_NM)))) AS SOL_SM_BKD_NM
, SPLIT_STRT_DT
, SPLIT_END_DT
, SM_SPLIT_PCT
, 0 AS COMP_WEIGHTED_ANNUAL_PREM_AMT
, 0 AS COMP_ESTIMATED_FYC
, COMP_PCT
, 0 AS SOL_ESTIMATED_FYC
, 0 AS SOL_WEIGHTED_ANNUAL_PREM_AMT
, 0 AS HLDG_CR
, UNIT_STRT_DT
, UNIT_END_DT

FROM 


(
SELECT 
   APPL_ID
 , SOL_MRG_AGY_SRC_SYS_PRTY_ID
, MRG_ENT_NM AS SOL_MRG_ENT_NM
, SOLICITING_AGT_FULL_NM
, SOLICITING_AGT_SRC_SYS_PRTY_ID
, SOLICITING_AGT_TYP_CD
, HLDG_KEY
 , MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE ''END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SRC.SM_BKD_BP_ID, 'UN-ASSIGNED') ELSE '' END) AS SOL_SM_BKD_SRC_SYS_PRTY_ID

, MAX(CASE WHEN ROW_NUM_sol MOD 10 = 0 THEN COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 1 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 2 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 3 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 4 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 5 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 6 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 7 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 8 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) ||
MAX(CASE WHEN ROW_NUM_sol MOD 10 = 9 THEN ' / ' || COALESCE( SRC.SM_BKD_NM , 'UN-ASSIGNED' )  ELSE '' END) AS SOL_SM_BKD_NM
FROM 

(

SELECT 
APPL_ID
,SOL_MRG_AGY_SRC_SYS_PRTY_ID
, MRG_ENT_NM
,SOLICITING_AGT_FULL_NM
,SOLICITING_AGT_SRC_SYS_PRTY_ID
,SOLICITING_AGT_TYP_CD
,HLDG_KEY
,SUBMISSION_DATE
, SM_BKD_BP_ID 
, SM_BKD_NM 
, ROW_NUMBER() OVER (PARTITION BY  HLDG_KEY,   APPL_ID 
                              ORDER BY HLDG_KEY , HIERARCHY_SOL.SM_BKD_BP_ID ) -1 AS   ROW_NUM_sol
FROM 
(
SELECT 
     APPL.APPL_ID	
	,TRIM( ENT.MRG_ENT_NB ) AS SOL_MRG_AGY_SRC_SYS_PRTY_ID
	, ENT_sol.MRG_ENT_NM
    ,CASE WHEN char_length( trim(   PDCR.FIRST_NM   ) ) = 0
	          AND  char_length( trim(  PDCR.LST_NM )) =  0 THEN  PDCR.FULL_NM 
     ELSE  PDCR.LST_NM || ', ' || PDCR.FIRST_NM
	 END  AS SOLICITING_AGT_FULL_NM
	, (case when BP_COMM.BP_ID='0000000000' then 'AA000000' else 'AA' 
	                   || SUBSTR('000000' , 1 ,6-CHAR_LENGTH( TRIM(BOTH FROM (CAST( BP_COMM.BP_ID AS CHAR(6)))) )) 
	                   || TRIM(BOTH FROM  BP_COMM.BP_ID) end) AS SOLICITING_AGT_SRC_SYS_PRTY_ID
    ,  COALESCE ( SMBD.AGT_TYP_CD , AGT_TYP.AGT_TYP_CD_2 , case when PDCR.CAS_IND='N' then 'CAB' else 'CAS' end ) AS SOLICITING_AGT_TYP_CD    
    ,  APPL.HLDG_KEY_PFX||TRIM(LEADING '0' FROM APPL.HLDG_KEY) AS HLDG_KEY

    
   , cast(APPL.APPL_SUBM_DT as date) AS    SUBMISSION_DATE
   
FROM  PROD_NBR_VW.NB_APPL_VW APPL

	
 LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW ENT
     ON   ENT.ENT_NB = (case when APPL.SLCT_AGY='FILI' then '244' else APPL.SLCT_AGY end)         


 LEFT OUTER JOIN PROD_NBR_VW.MRG_ENT_VW ENT_sol
  ON  ENT.MRG_ENT_NB = ENT_sol.MRG_ENT_NB
  
   
 LEFT OUTER JOIN PROD_NBR_VW.NB_BP_COMM_SPLT_VW  BP_COMM
       ON       APPL.APPL_ID = BP_COMM.APPL_ID
       AND     BP_COMM.SRC_SYS_ID=82
       AND      BP_COMM.BP_COMM_SPLT_TO_DT =  '9999-12-31 00:00:00.000000'


 LEFT OUTER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW PDCR 
       ON  (case when BP_COMM.BP_ID='0000000000' then 'AA000000' else 'AA' 
                       || SUBSTR('000000' , 1 ,6-CHAR_LENGTH( TRIM(BOTH FROM (CAST(BP_COMM.BP_ID AS CHAR(6)))) )) 
                       || TRIM(BOTH FROM BP_COMM.BP_ID) end)  =  'AA' || TRIM(SUBSTR(PDCR.BUSINESS_PARTNER_ID,5,6))
  
LEFT OUTER JOIN (SELECT    HLDG_KEY  , HLDG_KEY_PFX
                                                      ,  'AA' || TRIM ( SUBSTR( SVC.BUSINESS_PARTNER_ID , 5 , 6 ) ) AS SOL_PRD_BPID
                                                      ,   CASE WHEN SDT.TRNSLT_FLD_VAL IN  ( 'CAR' ,'CARS' ) THEN 'CAS'   ELSE 'CAB' END AGT_TYP_CD   
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
 AND TRIM(APPL.HLDG_KEY_PFX) = TRIM(SMBD.HLDG_KEY_PFX)
 AND SOLICITING_AGT_SRC_SYS_PRTY_ID = SMBD.SOL_PRD_BPID
AND   SUBMISSION_DATE          BETWEEN  SMBD.BUS_STRT_DT_s AND  SMBD.BUS_END_DT_s    


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
     AND  SUBMISSION_DATE BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND SOL_MRG_AGY_SRC_SYS_PRTY_ID = AGT_TYP.AGY_LGCY_ID          
      AND CASE WHEN SMBD.AGT_TYP_CD  IS NOT NULL THEN  2 ELSE 1 END =1

WHERE  --  TRIM(BOTH FROM APPL_TYP)='NEWAPP'  AND
 APPL.SRC_SYS_ID = 82
AND APPL_DATA_TO_DT='9999-12-31 00:00:00.00000' 
-- AND APPL.APPL_ISS_DT is not null

QUALIFY (ROW_NUMBER() OVER(PARTITION BY APPL.HLDG_KEY ,APPL.APPL_ID
	ORDER BY APPL.HLDG_KEY ,APPL.APPL_ID, CASE WHEN SOLICITING_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1
      
) LVL1      
      
LEFT OUTER JOIN 
									(
										
															
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
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
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		) A
								 									

									
									) HIERARCHY_SOL


ON 		UPPER(SOLICITING_AGT_SRC_SYS_PRTY_ID) = HIERARCHY_SOL.PRD_BPID 
AND 	TRIM(SOL_MRG_AGY_SRC_SYS_PRTY_ID)=TRIM(HIERARCHY_SOL.AGY_LGCY_ID)
AND	SUBMISSION_DATE  BETWEEN HIERARCHY_SOL.PRD_REL_STRT_DT AND HIERARCHY_SOL.PRD_REL_END_DT
AND	SUBMISSION_DATE  BETWEEN HIERARCHY_SOL.PRD_UNT_REL_STRT_DT AND HIERARCHY_SOL.PRD_UNT_REL_END_DT
AND	SUBMISSION_DATE  BETWEEN HIERARCHY_SOL.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY_SOL.SM_BKD_UNIT_REL_END_DT
AND   SOLICITING_AGT_TYP_CD = HIERARCHY_SOL.HIER_AGT_TYP_CD      
    


QUALIFY (ROW_NUMBER() OVER(PARTITION BY APPL_ID, SM_BKD_BP_ID  ORDER BY APPL_ID , SM_BKD_BP_ID) - 1) = 0

) SRC

GROUP BY 1,2,3,4,5,6,7

) SOL

INNER JOIN 

(
SELECT 
 APPL_ID
,COMP_MRG_AGY_SRC_SYS_PRTY_ID
,COMP_MRG_ENT_NM
,COMP_SOL_AGT_SRC_SYS_PRTY_ID
,COMP_SOL_AGT_FULL_NM
,COMP_SOL_AGT_TYP_CD
,HLDG_KEY
 ,COALESCE(HIERARCHY.SM_BKD_BP_ID,'UN-ASSIGNED') AS COMP_SM_BKD_SRC_SYS_PRTY_ID
 ,COALESCE(HIERARCHY.SM_BKD_NM,'UN-ASSIGNED') AS  COMP_SM_BKD_NM
 ,SM_SPLITS.BUS_STRT_DT AS SPLIT_STRT_DT
 ,SM_SPLITS.BUS_END_DT AS SPLIT_END_DT
 ,SM_SPLITS.SM_SPLIT_PCT AS SM_SPLIT_PCT
  , MIN(HIERARCHY.PRD_UNT_REL_STRT_DT) OVER(PARTITION BY HLDG_KEY ,APPL_ID,  COMP_MRG_AGY_SRC_SYS_PRTY_ID, COMP_SOL_AGT_SRC_SYS_PRTY_ID) AS  UNIT_STRT_DT
 ,HIERARCHY.PRD_UNT_REL_END_DT  AS   UNIT_END_DT
 ,COMP_PCT
 ,SUBMISSION_DATE


FROM 

(

SELECT 
  APPL.APPL_ID	
 ,WRTG.MRG_ENT_NB   AS COMP_MRG_AGY_SRC_SYS_PRTY_ID
 
 , WRTG.BUSINESS_PARTNER_ID    AS COMP_SOL_AGT_SRC_SYS_PRTY_ID
      
 , WRTG.MRG_ENT_NM   AS COMP_MRG_ENT_NM
 
,  CASE WHEN char_length( trim(   WRTG.FIRST_NM   ) ) = 0
                         AND  char_length( trim(  WRTG.LST_NM )) =  0 THEN  WRTG.FULL_NM 
               ELSE  WRTG.LST_NM || ', ' || WRTG.FIRST_NM
 END        AS COMP_SOL_AGT_FULL_NM
                                   
, COALESCE ( SMBD.AGT_TYP_CD , AGT_TYP.AGT_TYP_CD_2 , case when WRTG.CAS_IND='N' then 'CAB' else 'CAS' end ) AS COMP_SOL_AGT_TYP_CD
, APPL.HLDG_KEY_PFX||TRIM(LEADING '0' FROM APPL.HLDG_KEY) AS HLDG_KEY


 ,COMM.FRST_YR_COMM AS COMP_PCT

, cast(APPL.APPL_SUBM_DT as date) AS    SUBMISSION_DATE


FROM  PROD_NBR_VW.NB_APPL_VW APPL

 LEFT OUTER JOIN PROD_NBR_VW.NB_BP_COMM_SPLT_VW  COMM
       ON       APPL.APPL_ID = COMM.APPL_ID
       AND     COMM.SRC_SYS_ID=82
       AND      COMM.BP_COMM_SPLT_TO_DT =  '9999-12-31 00:00:00.000000'	    
       
LEFT OUTER JOIN 
(
SELECT 
   HLDG_KEY,HLDG_KEY_PFX, SUBSTR(A.AGT_WRTG_AGY_CD,8) AGT_WRTG_AGY_CD ,MRG_ENT_NM , MRG_ENT_NB
 ,'AA' || TRIM ( SUBSTR( A.BUSINESS_PARTNER_ID , 5 , 6 ) ) BUSINESS_PARTNER_ID,  B.FIRST_NM, B.LST_NM,B.FULL_NM
 ,B.CAS_IND,A.AGT_COMM_SPLIT ,A.AGREEMENT_SOURCE_CD
FROM  PROD_USIG_STND_VW.PDCR_AGMT_CMN_VW A INNER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW B ON A.PRTY_ID=B.PRTY_ID
LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VW ON ENT_NB = SUBSTR(A.AGT_WRTG_AGY_CD,8) 
WHERE  A.PRTY_AGMT_RLE_CD ='AGT' AND A.PRTY_AGMT_RLE_STYP_CD = 'WRTG'
) WRTG 
on  APPL.HLDG_KEY=WRTG.HLDG_KEY
AND APPL.HLDG_KEY_PFX = WRTG.HLDG_KEY_PFX
AND APPL.CARR_ADMIN_SYS_CD = WRTG.AGREEMENT_SOURCE_CD
 
 
LEFT OUTER JOIN (SELECT    HLDG_KEY  ,HLDG_KEY_PFX
                                                      ,  'AA' || TRIM ( SUBSTR( SVC.BUSINESS_PARTNER_ID , 5 , 6 ) ) AS SOL_PRD_BPID
                                                      ,   CASE WHEN SDT.TRNSLT_FLD_VAL IN  ( 'CAR' ,'CARS' ) THEN 'CAS'   ELSE 'CAB' END AGT_TYP_CD   
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
 AND TRIM(APPL.HLDG_KEY_PFX) = TRIM(SMBD.HLDG_KEY_PFX)
 AND COMP_SOL_AGT_SRC_SYS_PRTY_ID = SMBD.SOL_PRD_BPID
AND   SUBMISSION_DATE          BETWEEN  SMBD.BUS_STRT_DT_s AND  SMBD.BUS_END_DT_s    


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
      ON   AGT_TYP.PRD_BPID =   COMP_SOL_AGT_SRC_SYS_PRTY_ID      
     AND  SUBMISSION_DATE BETWEEN AGT_TYP.PRD_REL_STRT_DT AND AGT_TYP.PRD_REL_END_DT
      AND COMP_MRG_AGY_SRC_SYS_PRTY_ID = AGT_TYP.AGY_LGCY_ID          
      AND CASE WHEN SMBD.AGT_TYP_CD  IS NOT NULL THEN  2 ELSE 1 END =1
    
WHERE  -- TRIM(BOTH FROM APPL_TYP)='NEWAPP' AND
 APPL.SRC_SYS_ID = 82
AND APPL_DATA_TO_DT='9999-12-31 00:00:00.00000' 
-- AND APPL.APPL_ISS_DT is not null      
      
 QUALIFY (ROW_NUMBER() OVER(PARTITION BY APPL.HLDG_KEY ,APPL.APPL_ID,WRTG.MRG_ENT_NB ,WRTG.BUSINESS_PARTNER_ID  
		                  ORDER BY APPL.HLDG_KEY ,APPL.APPL_ID, WRTG.MRG_ENT_NB,  WRTG.BUSINESS_PARTNER_ID, CASE WHEN COMP_SOL_AGT_TYP_CD='CAS'  THEN 0 ELSE 1 END ) ) = 1
      
 ) LV1
      
      
LEFT OUTER JOIN 
									(
										
															
															SEL	 DISTINCT 
															
															  AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
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
																					GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,PRD_DIRECT_TO_AGY_IND,PRD_BPID,PRD_STD_CONTR_TYP
																		) A
								 									

									
									) HIERARCHY


ON 		UPPER(COMP_SOL_AGT_SRC_SYS_PRTY_ID) = HIERARCHY.PRD_BPID 
AND 	TRIM(COMP_MRG_AGY_SRC_SYS_PRTY_ID)=TRIM(HIERARCHY.AGY_LGCY_ID)
AND	SUBMISSION_DATE  BETWEEN HIERARCHY.PRD_REL_STRT_DT AND HIERARCHY.PRD_REL_END_DT
AND	SUBMISSION_DATE  BETWEEN HIERARCHY.PRD_UNT_REL_STRT_DT AND HIERARCHY.PRD_UNT_REL_END_DT
AND	SUBMISSION_DATE  BETWEEN HIERARCHY.SM_BKD_UNIT_REL_STRT_DT AND HIERARCHY.SM_BKD_UNIT_REL_END_DT
AND   COMP_SOL_AGT_TYP_CD = HIERARCHY.HIER_AGT_TYP_CD      

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
AND SUBMISSION_DATE BETWEEN SM_SPLITS.BUS_STRT_DT AND SM_SPLITS.BUS_END_DT


QUALIFY (ROW_NUMBER() OVER(PARTITION BY APPL_ID, COMP_MRG_AGY_SRC_SYS_PRTY_ID ,COMP_SOL_AGT_SRC_SYS_PRTY_ID ,HIERARCHY.SM_BKD_BP_ID
                                                                               ORDER BY APPL_ID, COMP_SOL_AGT_SRC_SYS_PRTY_ID, HIERARCHY.SM_BKD_BP_ID  ) - 1) = 0
) COMP
ON SOL.HLDG_KEY = COMP.HLDG_KEY
 );
