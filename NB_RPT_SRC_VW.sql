REPLACE VIEW PROD_NBR_VW.NB_RPT_SRC_VW
AS LOCKING ROW FOR ACCESS 

(

SELECT DISTINCT 	  A.APPL_ID
											, A.HLDG_KEY
											, COV_BENE_AMT AS BEN_AMT
											, ( ZEROIFNULL(K.ANNL_PREM) + ZEROIFNULL(COV_ADL_PREM) + ZEROIFNULL(K.APPL_1035_AS_PREM) ) AS AGMT_TOT_ANNUAL_PREM_AMT
											, 'NO' AS GRADED_PREMIUM_POLICY --DEFAULT FOR LIFE NO VALUE PROVIDED
											, PREPAID_IND AS PREPAID_PREMIUM_IND
											, APPL_SIGN_ST AS CNTR_JURISDICTION
											, SLCT_AGY  AS AGENCY_SRC_SYS_PRTY_ID
											, TRIM( MRG_ENT_NB ) AS MRG_AGENCY_SRC_SYS_PRTY_ID
											, TOP_BL_IND AS MASTERS_GROUP_PARTICIPANT --DEFAULT FOR LIFE NO VALUE PROVIDED
											, PRODUCER_ID AS SOLICITING_AGT_SCARAB_ID 
											, PRODUCER_ID AS SOLICITING_AGT_SRC_SYS_PRTY_ID
											, COALESCE(A.AGNT_NM,AGNT_NM_MISS) AS SOLICITING_AGT_FULL_NM
											, SSN AS SOLICITING_AGT_GOVT_ID
											, CASE	
															WHEN BROKERAGE_IND = 'Y' THEN 'BROKER'
															WHEN BROKERAGE_IND = 'N' THEN 'CAREER'
															ELSE NULL
											  END AS SOLICITING_AGT_TYP_CD
											, GRP_NB AS GROUP_SRC_SYS_PRTY_ID
											, SUBSTRING(GRP_NB FROM 1 FOR 5) AS GROUP_SRC_SYS_PRTY_ID_5
											, CAST(NULL AS VARCHAR(100) ) AS GROUP_FULL_NM  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, PRODUCT_CODE AS ORGANIZATION_BUSINESS_TYPE_CD  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, UW_TYP AS UW_TYPE  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, CASE
															WHEN BINGO_FLG = 'Y' THEN 'BINGO'
															WHEN BINGO_FLG = 'N' THEN 'NIGO'
															ELSE ' '
											  END AS BINGO_IND
											, CAST(BINGO_FLG_DT AS DATE) AS BINGO_REVIEW_DATE
											, APPL_TYP AS APPLICATION_TYPE_CD
											, REPL_IND AS REPLACEMENT_INSURANCE_IND
											, REPL_TYP AS REPLACEMENT_TYPE
											, PROD_CD AS PROD_ID
											, PRODUCT_CODE AS PRODUCT_TYPE
											, LST_NM AS INS_LAST_NAME
											, FRST_NM AS INS_FIRST_NAME
											, CAST(NULL AS VARCHAR(2) ) AS OCCUPATION_CLASS  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, CAST(NULL AS VARCHAR(40) ) AS OCCUPATION_TYP_CD  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, GNDR_CD AS INS_GNDR_CD
											, DOB AS INS_BRTH_DT
											, INS_AG AS INS_AGE
											, GOVT_ID AS INS_GOVT_ID
											/*  I3 Defect 250 */
											/*
											, AD_LN_1 AS INS_RES_ADDR_L1_TEXT
											, AD_LN_2 AS INS_RES_ADDR_L2_TEXT
											, AD_LN_3 AS INS_RES_ADDR_L3_TEXT
											, AD_CITY AS INS_RES_CTY_NM
											, ST_CD AS INS_RES_ST_TYP
											, AD_ZIP_CD AS INS_FULL_POST_CD
											, CNTR_CD AS INS_CTRY_TYPE
											*/
											, CAST(NULL AS VARCHAR(50) ) AS INS_ELEC_AD_TXT  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, RISK_CLS AS UNDERWRITER_CLASS_CD  --DEFAULT FOR LIFE NO VALUE PROVIDED
											, RATED_IND AS RATED_IND ------------------------------
											, CASE
															WHEN XCLDE_TYP <> 'UNK' THEN 'YES'
															ELSE 'NO'
											  END AS EXCLUSION_IND -----------------------------
											, H.UW_LOG_IN_ID AS UW_SRC_SYS_PRTY_ID 
											, CASE
															WHEN CHAR_LENGTH(TRIM(BOTH ' ' FROM UW_FRST_NM))>1  THEN UW_FRST_NM   || ' ' ||  UW_LST_NM
															ELSE UW_LST_NM
											  END AS UW_FULL_NM
											, UW_TEAM_NM AS UW_TEAM_NM
											, I.CM_LOG_IN_ID AS SPECIALIST_SRC_SYS_PRTY_ID
											, CASE
															WHEN CHAR_LENGTH(TRIM(BOTH ' ' FROM CM_FRST_NM))>1  THEN CM_FRST_NM   || ' ' ||  CM_LST_NM
															ELSE CM_LST_NM
											  END AS SPECIALIST_FULL_NM
											, CAST(APPLICATION_SUBMIT_DATE AS DATE) AS SUBMISSION_DATE
											, CAST(COALESCE(APP_CAPTURE_DATE, APPL_ADE_DT) AS DATE) AS CARRIER_INPUT_DATE ---------------------------------
											, CAST(NULL AS VARCHAR(20) ) AS CARRIER_SRC_SYS_PRTY_ID --------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS CARRIER_FULL_NM ----------------------------------
											, CAST(COALESCE(TPP_INIT_RVW_STRT_DT,WR_INIT_RVW_STRT_DT) AS DATE) AS INIT_REVIEW_STRT_STUS_EVENT_DT ----------------------------------
											, CAST(COALESCE(TPP_INIT_RVW_END_DT, WR_INIT_RVW_END_DT) AS DATE) AS INIT_REVIEW_CMPL_STUS_EVENT_DT ----------------------------------
											, CAST(NULL AS VARCHAR(20) ) AS INITIAL_REVIEW_SRC_SYS_PRTY_ID ----------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS INITIAL_REVIEWER_FULL_NM ----------------------------------
											, CAST(ISSUE_DATE  AS DATE) AS ISSUE_DATE ---CHANGED ON 2/5/2015 FROM ISSUE_DATE     APPL_ISS_DT
											, CAST(NULL AS VARCHAR(20) ) AS ISSUED_BY_SRC_SYS_PRTY_ID ----------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS ISSUED_BY_FULL_NM  ----------------------------------
											, CAST(POSTPONE_DATE AS DATE) AS POSTPONE_STATUS_EVENT_DATE
											, CAST(NULL AS VARCHAR(20) ) AS POSTPONE_BY_SRC_SYS_PRTY_ID  ----------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS POSTPONED_BY_FULL_NM  ----------------------------------
											, CAST(DECLINE_DATE AS DATE) AS DECLINED_STATUS_EVENT_DATE
											, CAST(NULL AS VARCHAR(20) ) AS DECLINED_BY_SRC_SYS_PRTY_ID  ----------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS DECLINED_BY_FULL_NM  ----------------------------------
											, CAST(NOT_TAKEN_DATE AS DATE) AS NOT_TAKEN_STATUS_EVENT_DATE
											, CAST(NULL AS VARCHAR(20)) AS NOT_TAKEN_BY_SRC_SYS_PRTY_ID
                                            , CAST(NULL AS VARCHAR(30) ) AS NOT_TAKEN_BY_FULL_NM
											, CAST(WITHDRAWN_DATE AS DATE) AS WITHDRAWN_STATUS_EVENT_DATE
											, CAST(NULL AS VARCHAR(20) ) AS WITHDRAWN_BY_SRC_SYS_PRTY_ID ----------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS WITHDRAWN_FULL_NM ----------------------------------
											, CAST(D.FIRST_FA_DATE AS DATE) AS FRST_FINL_ACTION_STUS_EVENT_DT
											, FA_STUS AS FRST_FINAL_ACTION_DETAIL -----------------------------------
											, CAST(NULL AS VARCHAR(20) ) AS FRST_FN_ACT_BY_SRC_SYS_PRTY_ID ---------------------------------
											, CAST(NULL AS VARCHAR(30) ) AS FRST_FINAL_ACTION_FULL_NM --------------------------
											, CAST(APPL_INCMP_DT AS DATE) AS APPL_INCMP_EVENT_DT
                        					, CAST(NULL AS VARCHAR(20)) AS APPL_INCMP_BY_SRC_SYS_PRTY_ID 
                        					, CAST(NULL AS VARCHAR(30)) AS APPL_INCMP_BY_FULL_NM
											, CAST(CUR_STATUS_DATE AS DATE) AS CURR_STATUS_EVENT_DT
											, CASE WHEN RPT.ADMIN_TRANSACTION_DT IS NOT NULL  then 'Reported' ELSE CUR_STUS END AS CURR_STATUS_EVENT_DETAIL---CURRENT STATUS
											, CAST(NULL AS VARCHAR(20) ) AS CUR_STS_EVN_BY_SRC_SYS_PRTY_ID -----------------------------
											, CAST(NULL AS VARCHAR(30) ) AS CURR_STUS_EVENT_BY_FULL_NM -------------------------------------
											, CUR_STUS AS CASE_STATUS_EVENT_DETAIL -- CURRENT STAUS
											, CAST(STUS_DT AS DATE) AS CASE_STATUS_EVENT_DATE --CHANGED FROM agmt_stus_dt
											--, LST_STUS_DT AS MAX_TRANS_DT
											, T.TRANS_DT AS MAX_TRANS_DT
											, CASE
															WHEN AGMT_FRM IN ('WL', 'EWL', 'SWL') THEN (ZEROIFNULL(ANNL_PREM) * 0.50 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)             
															WHEN AGMT_FRM IN ('MOD WL', 'UL', 'VL') THEN (ZEROIFNULL(ANNL_PREM) * 0.50 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02) 
															WHEN AGMT_FRM IN ('APT', 'LVL TM N') THEN (ZEROIFNULL(ANNL_PREM) * 0.45 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)             
															WHEN AGMT_FRM ='SPWL' THEN (ZEROIFNULL(ANNL_PREM) * 0.04 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)               /* I5: 4/28/2015 - Changed 0.4 to 0.04 */                        
															WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD in ('L10', 'LP10' ) THEN (ZEROIFNULL(ANNL_PREM) * 0.30 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02) 
															WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD in ( 'LP12', 'CC12' ) THEN (ZEROIFNULL(ANNL_PREM) * 0.34 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)      
                                                            WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD = 'LP15' THEN (ZEROIFNULL(ANNL_PREM) * 0.40 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)        
															WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD in ('L20', 'LP20') THEN (ZEROIFNULL(ANNL_PREM) * 0.50 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02) 
															WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD in ('L65','LP65') THEN (ZEROIFNULL(ANNL_PREM) * 0.50 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02)             
															WHEN AGMT_FRM = 'LPL' AND A.SRC_PROD_CD in ('L85','LP85') THEN (ZEROIFNULL(ANNL_PREM) * 0.125 + ZEROIFNULL(K.APPL_1035_AS_PREM) *0.02 + ZEROIFNULL(COV_ADL_PREM) * 0.02) 
															ELSE 0
											  END AS ESTIMATED_FYC
											, CASE
															WHEN CM_FLG = 'Y' THEN 'BINGO'
															WHEN CM_FLG = 'N' THEN 'NIGO'
															ELSE NULL
											  END AS CM_BINGO_IND
											, CASE
															WHEN UW_FLG = 'Y' THEN 'BINGO'
															WHEN UW_FLG = 'N' THEN 'NIGO'
															ELSE NULL
											  END AS UW_BINGO_IND
											, CM_RSN_ADD_DT AS CM_BINGO_RVW_DT
											, UW_RSN_ADD_DT AS UW_BINGO_RVW_DT
											, RPT_PLCM_STUS
											, RPT_INV_STUS
											, CASE
															WHEN APPL_TYP IN ('CNV', 'OPT') THEN 'CONVERSIONS'
															ELSE  'NEW BUSINESS'
											  END AS BUSS_TYP
											, CAST(APPL_RPT_DT AS DATE) AS ISS_RPT_DT
											 /* I5: 4/28/2015 - added logic for CC1*/      
											,( 
 											  CASE WHEN SRC_SYS ='WR' AND  PROD_CD NOT LIKE 'CC%'  THEN
 											         ( ( COALESCE(LISR_ANNL,0) + COALESCE(ALIR_ANNL, 0 ) ) * 0.1 *  K.BILL_FREQ_CONV)   -- Rider Annual
 											        +  (( COALESCE(ALIR_DMP,0) +  COALESCE(LISR_DMP,0)) * 0.1 )   -- Rider Dump In
 											        +     CASE WHEN  COALESCE(ANNL_PREM, 0) > (COALESCE(ALIR_ANNL,0) + COALESCE(LISR_ANNL,0)) * K.BILL_FREQ_CONV
 											                     THEN ANNL_PREM -   (COALESCE(ALIR_ANNL,0) + COALESCE(LISR_ANNL,0)) * K.BILL_FREQ_CONV
 											               ELSE  COALESCE(ANNL_PREM , 0)
 											                END
 											        +     ( CASE WHEN COALESCE(K.APPL_1035_AS_PREM, 0) > ( COALESCE(ALIR_DMP,0) +  COALESCE(LISR_DMP,0)) 
 											                        THEN K.APPL_1035_AS_PREM -   ( COALESCE(ALIR_DMP,0) +  COALESCE(LISR_DMP,0)) 
 											               ELSE   COALESCE(COV_ADL_PREM, 0)
 											                END ) * 0.1
 											  ELSE     
											  CASE WHEN PROD_CD like 'CC%'   and  AGMT_FRM  ='SPWL'  then (ZEROIFNULL(K.ANNL_PREM))*0.10 
												else ( ZEROIFNULL(K.ANNL_PREM) + (ZEROIFNULL(COV_ADL_PREM) + ZEROIFNULL(K.APPL_1035_AS_PREM))*0.10 ) end
												
											  END 	)    AS WEIGHTED_ANNUAL_PREM_AMT
											, ANNL_PREM
											, COV_ADL_PREM
											, APPL_1035_AS_PREM
											, CASE
													WHEN TRIM(BOTH FROM REPL_TYP) IN ('I','F','M') THEN 'Internal'
													WHEN TRIM(BOTH FROM REPL_TYP) IN ('E','X','N') THEN 'External'
													WHEN TRIM(BOTH FROM REPL_TYP) IN ('C') THEN 'Combination'
													ELSE 'Not a Replacement'
												END AS REPL_TYP_DESC
											--preDSP:
											--,SALES_UNIT_MANAGER 
											--postIDM:
											, HIERARCHY.SM_BKD_NM AS SALES_UNIT_MANAGER
											,SRC_PROD_CD AS SRC_PROD_ID
											,SRC_APPL_TYP AS SRC_APPLICATION_TYPE_CD
											,SRC_SYS
											,EZAPP_IND
											,SIGN_METH
											, HIERARCHY.SM_BKD_BP_ID AS SALES_MANAGER_UID /* I6: 5/28/2015  - added to get sales manager Id */
											--, HIERARCHY.SM_BKD_NM AS SM_BD_FULL_NM_dsp 
											,SIGND_DT as SIGNED_DT
 											,APS as APS_IND
 											,BLUE_CHIP
 											,case 
 												when RPT.ADMIN_TRANSACTION_DT is not null  then RPT.ADMIN_TRANSACTION_DT 
 												when RPT.ADMIN_TRANSACTION_DT is null and CAST(APPL_RPT_DT AS DATE) is not null then CAST(APPL_RPT_DT AS DATE) 
 												end as INITIAL_PREM_DT
											
FROM   

(


SELECT DISTINCT			NB_APPL_VW.APPL_ID
												, NB_APPL_VW.HLDG_KEY -- AS "POLICY_NUMBER"
												, COV_BENE_AMT
												, CASE
																WHEN PPD_IND IS NOT NULL THEN PPD_IND
																ELSE 'N'
												  END AS PREPAID_IND
												, APPL_SIGN_ST
												, SLCT_AGY
												, MRG_ENT_NB --INSTEAD OF ENT_NB
												, 'AA' || SUBSTR('000000' , 1 ,6-CHAR_LENGTH( TRIM(BOTH FROM (CAST(BP_ID AS CHAR(6)))) )) || TRIM(BOTH FROM BP_ID) AS PRODUCER_ID
												,  CASE WHEN  TRIM(PDCR.FIRST_NM) = ''  OR TRIM(PDCR.LST_NM) = ''  THEN  TRIM(FULL_NM)
												           ELSE  COALESCE((TRIM(BOTH FROM PDCR.LST_NM) || ', ' || TRIM(BOTH FROM PDCR.FIRST_NM)), LST_NM) 
												    END  AS AGNT_NM
												, NB_APPL_VW.APPL_DATA_FR_DT
												, NB_APPL_VW.APPL_TYP
												, APPL_SUBM_DT AS "SUBMIT DATE" 
												, TOP_BL_IND 
												, ISSUE_DATE
												, ISSUE_DATE_JOIN
												, DECLINE_DATE
												, DECLINE_DATE_JOIN
												, NOT_TAKEN_DATE
												, WITHDRAWN_DATE
												, WITHDRAWN_DATE_JOIN
												, FIRST_FA_DATE
												, LST_STUS_DT
												, FIRST_APPROVED_DATE
												, LAST_APPROVED_DATE
												, CASE_ID
												, APP_CAPTURE_DATE
												, AGMT_ST
												, GRP_NB
												, AGMT_STUS_CD  AS AGREEMENT_STATUS_CODE
												, AGMT_STUS_DT AS STUS_DT
												, COV_ADL_PREM
												, COV_MDL_PREM
												, AGT_TYP_CD
												, CASE
																WHEN AGMT_STUS_CD = 'AO' THEN APPL_OFFR_DT
																ELSE APPL_APPV_DT 
												  END AS APPROVED_DATE
												, NB_APPL_VW.APPL_ADE_DT AS APPLICATION_SUBMIT_DATE
												, CASE
																WHEN MAJOR_PROD_CDE = 'NTL' THEN 'UL/VL'
																WHEN MAJOR_PROD_CDE = 'PERM' THEN 'Whole Life'
																ELSE 'Term' 
												  END AS PRODUCT_CODE
												, BRKRG_IND AS BROKERAGE_IND
												, CAS_STUS_SHRT_DESC
												, APPL_OFFR_DT
												, REPL_IND
												, REPL_TYP
												, NB_APPL_VW.PROD_CD
												, INS_AG
												, AGMT_FRM
											--	, B.SRC_PROD_CD
												, APPL_ISS_DT
												, RISK_CLS
												, RATED_IND
												, FRST_STUS_DT
												, BRKRG_IND
												, APPL_RPT_DT
												, Z.APPL_ADE_DT
												 ,Z.APPL_INCMP_DT
												, NB_APPL_VW.SRC_PROD_CD
												, SRC_APPL_TYP
												,case NB_APPL_VW.SRC_SYS_ID when 32 then 'TPP' when 36 then 'WR' end SRC_SYS  /* I3 REQ1 */
												,case when  NB_APPL_VW.HLDG_KEY=EZAPP.HLDG_KEY then 'Y' else 'N' end AS EZAPP_IND
 											    ,SIGN_METH.SIGN_METH_TYP_CD_SHRT_DESC AS SIGN_METH
 											    ,APPL_SIGND_DT as SIGND_DT
 											    ,(case when APS.APPL_ID is not null then 'Y' else 'N' end) as APS
 											    ,(case when PDCR.BCC_START_DT is not null then 'Y' else 'N' end) BLUE_CHIP
												
FROM PROD_NBR_VW.NB_APPL_VW  

LEFT OUTER JOIN PROD_NATL_SALES_SUM_VW.ENT_VaW 
		ON		ENT_NB = SLCT_AGY 
		
LEFT OUTER JOIN PROD_USIG_CMN_VW.CAS_STUS_CD_VW 
		ON 		CAS_STUS_CD = AGMT_STUS_CD
		
LEFT OUTER JOIN PROD_USIG_CMN_VW.PRODUCT_TRANSLATOR_VW 
		ON		PROD_TYP_CDE = NB_APPL_VW.PROD_CD


LEFT OUTER JOIN

(

SELECT		APPL_ID
					, MIN(CAST(APPL_ISS_DT AS DATE)) AS ISSUE_DATE
					, MIN(AGMT_ISS_DT) AS ISSUE_DATE_JOIN
					, MIN(CAST(APPL_DCLN_DT AS DATE)) AS DECLINE_DATE
					, MIN(APPL_DCLN_DT) AS  DECLINE_DATE_JOIN
					, MIN(APPL_NOT_TAKEN_DT) AS NOT_TAKEN_DATE
					, MIN(CAST(APPL_WDRW_DT AS DATE)) AS WITHDRAWN_DATE
					, MIN(APPL_WDRW_DT) AS WITHDRAWN_DATE_JOIN
					, MIN(APPL_APPV_DT) AS FIRST_FA_DATE
					, MAX(AGMT_STUS_DT) AS LST_STUS_DT
					, MIN(APPL_APPV_DT) AS FIRST_APPROVED_DATE
					, MAX (APPL_APPV_DT) AS LAST_APPROVED_DATE
					, MIN(CAS_ID) AS CASE_ID
					, MIN(APPL_RCV_DT) AS APP_CAPTURE_DATE
					, MIN(AGMT_STUS_DT) AS FRST_STUS_DT
					, MIN(APPL_ADE_DT) AS APPL_ADE_DT
					, MIN(APPL_INCMP_DT) AS APPL_INCMP_DT
FROM PROD_NBR_VW.NB_APPL_VW
WHERE SRC_SYS_ID in (32,36)
GROUP BY 1

) Z

ON NB_APPL_VW.APPL_ID = Z.APPL_ID

LEFT OUTER JOIN

(

SELECT			APPL_ID
						,COV_BENE_AMT
						,PROD_CD
						,COV_TYP
						,PRTY_RLE
						,COV_ANNL_PREM
						,CASE
										WHEN SRC_SYS_ID = 32 THEN COV_MDL_PREM 
										ELSE 0
						 END AS COV_MDL_PREM
						,CASE
										WHEN SRC_SYS_ID = 36 THEN COV_MDL_PREM 
										ELSE 0
						  END AS COV_ADL_PREM
						, RISK_CLS
						, TBAC_CLS
						, INS_AG
						, ISS_AG
						, NB_COV_RISK_VW.SRC_PROD_CD
						, CASE
										WHEN SUBSTRING(BENE_RT_CD FROM 1 FOR 5) = 'TABLE' THEN 'YES'
										ELSE 'NO'
						  END AS RATED_IND
						  
FROM PROD_NBR_VW.NB_COV_RISK_VW

WHERE COV_TYP = 'BASE' 
		AND	COV_RISK_TO_DT  = '9999-12-31 00:00:00.000000'
		AND 	SRC_PRTY_RLE  in ('1','primins')
		AND SRC_SYS_ID in (32,36)

) B

ON NB_APPL_VW.APPL_ID = B.APPL_ID

LEFT OUTER JOIN PROD_NBR_VW.NB_BP_COMM_SPLT_VW 
		ON		NB_APPL_VW.APPL_ID = NB_BP_COMM_SPLT_VW.APPL_ID
		and    NB_BP_COMM_SPLT_VW.SRC_SYS_ID in (32,36)

/* Iteration I5: Checks if Policy came through NBHUB */                                 
LEFT OUTER JOIN  PROD_NBR_VW.NB_ESIGN_VW EZAPP
ON NB_APPL_VW.HLDG_KEY=EZAPP.HLDG_KEY
AND EZAPP.ESIGN_TO_DT= '9999-12-31 00:00:00.000000'

LEFT OUTER JOIN PROD_USIG_CMN_VW.SIGN_METH_CD_VW SIGN_METH
ON EZAPP.SIGN_METH=SIGN_METH.SIGN_METH_TYP_CD

LEFT OUTER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW PDCR
on PRODUCER_ID= ('AA' || TRIM ( SUBSTR(PDCR.BUSINESS_PARTNER_ID , 5 , 6 ) ))

LEFT OUTER JOIN ( SELECT distinct APPL_ID from PROD_NBR_VW.NB_REQ_VW R
where 
SRC_SYS_ID in (32,36) and R.REQ_CD like '%APS%' 
--and   R.REQ_TO_DT = '9999-12-31 00:00:00.000000' 
)  APS
on NB_APPL_VW.APPL_ID=APS.APPL_ID

WHERE 	NB_APPL_VW.APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
		AND	APPL_TYP  IN ('NEWAPP','ADD', 'ALT', 'CNC', 'CNV', 'EXC', 'INC', 'OPT', 'ORW')
		AND 	NB_BP_COMM_SPLT_VW.BP_COMM_SPLT_TO_DT =  '9999-12-31 00:00:00.000000'
		AND 	SRC_AGT_TYP IN ('Y','1000001','1000002')
		AND 	NB_APPL_VW.APPL_ID NOT IN (9882896) -- TO EXCLUDE THE POLICY NUMBER  WITH TWO ACTIVE SOLICITING AGENTS
		AND   NB_APPL_VW.SRC_SYS_ID in (32,36)
--AND hldg_key =21337440
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12, 26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,50

) A

LEFT OUTER JOIN
(
SELECT 
TRIM(LEADING '0' FROM HLDG_KEY) AS HLDG_KEY,
MIN(ADMIN_TRANSACTION_DT) ADMIN_TRANSACTION_DT
FROM PROD_USIG_STND_VW.AGMT_COMM_TXN_CMN_VW 
WHERE 
INITIAL_PREMIUM_CD ='INITIAL' AND FIRST_RENEWAL_YR_COMP_CD = 'FRSTYEAR'
GROUP BY HLDG_KEY
) RPT
ON A.HLDG_KEY=RPT.HLDG_KEY

LEFT OUTER JOIN
(

SELECT 	APPL_ID
					, MIN (CAST(AGMT_STUS_DT AS DATE)) AS POSTPONE_DATE
					, MIN(AGMT_STUS_DT) AS "POSTPONE DATE JOINED"
					
FROM 	PROD_NBR_VW.NB_APPL_VW
				, PROD_USIG_CMN_VW.CAS_STUS_CD_VW
				
WHERE CAS_STUS_SHRT_DESC LIKE('INCOMP%') 
		AND 	NB_APPL_VW.AGMT_STUS_CD =CAS_STUS_CD_VW.CAS_STUS_CD
		AND NB_APPL_VW.SRC_SYS_ID in (32,36)
GROUP BY 1


) C 

ON A.APPL_ID= C.APPL_ID


LEFT OUTER JOIN
(

SELECT			APPL_ID
						, MIN (CAST(AGMT_STUS_DT AS DATE)) AS FIRST_FA_DATE
						, MIN(AGMT_STUS_DT) AS "FIRST FA DATE JOINED"
						, CAS_STUS_SHRT_DESC AS FA_STUS
						, AGMT_STUS_DT
						
FROM PROD_NBR_VW.NB_APPL_VW
			, PROD_USIG_CMN_VW.CAS_STUS_CD_VW

WHERE 
            (
                        CAS_STUS_SHRT_DESC LIKE ('APPROVED%') 
                        OR CAS_STUS_SHRT_DESC LIKE('APVD%') 
                        OR CAS_STUS_SHRT_DESC LIKE('DECLINED%') 
                        OR CAS_STUS_SHRT_DESC LIKE('INCOMP%') 
                        OR CAS_STUS_SHRT_DESC LIKE('WITHDRAWN%')
            )
AND NB_APPL_VW.AGMT_STUS_CD =CAS_STUS_CD_VW.CAS_STUS_CD
AND NB_APPL_VW.SRC_SYS_ID in (32,36)

GROUP BY 1,4,5

QUALIFY ( ROW_NUMBER() OVER ( PARTITION BY APPL_ID ORDER BY AGMT_STUS_DT ASC )  = 1 )


) D
 
ON A.APPL_ID= D.APPL_ID


LEFT OUTER JOIN
(

SELECT		  PRTY_APPL_RLE_VW.APPL_ID
						, PRTY.LST_NM 
						, PRTY.FRST_NM
						, DOB
						, GNDR_CD
						, GOVT_ID
						, SNS
						/* I3 Defect 250 */
						/*
						, PRTY_APL_AD_ID
						, AD_CITY
						, AD_CTRY_OTH
						, AD_LN_1
						, AD_LN_2
						, AD_LN_3
						, AD_LN_4
						, AD_ST_OTH
						, AD_TYP
						, AD_ZIP_CD
						, AD_ZIP_CD_PLUS_4
						, CNTR_CD
						, ST_CD
						*/
						
FROM PROD_NBR_VW.NB_APPL_PRTY_VW  PRTY 

JOIN 
(

SELECT 		  PRTY_ID,
						  APPL_ID
						, PRTY_DATA_FR_DT
						, SRC_RLE
						/* I3 Defect 250 */
		/*				
						, NB_PRTY_APPL_AD_VW.PRTY_APL_AD_ID
						, AD_LN_1
						, AD_LN_2
						, AD_LN_3
						, AD_LN_4
						, AD_ST_OTH
						, AD_TYP
						, AD_ZIP_CD
						, AD_ZIP_CD_PLUS_4
						, AD_CITY
						, AD_CTRY_OTH
						, CNTR_CD
						, ST_CD 
					*/

FROM PROD_NBR_VW.NB_PRTY_APPL_RLE_VW 

/* I3 Defect 250 */

/* 
LEFT OUTER JOIN PROD_NBR_VW.NB_PRTY_APPL_AD_VW 
ON NB_PRTY_APPL_RLE_VW.PRTY_APL_AD_ID=NB_PRTY_APPL_AD_VW.PRTY_APL_AD_ID
*/

WHERE   PRTY_APPL_TO_DT = '9999-12-31 00:00:00.000000'  
AND RLE='INSD' 
AND SRC_RLE IN ( '1','primins')
and AD_TYP='RA' /* I3 Defect 250 */
and SRC_SYS_ID in (32,36)
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17  /* I3 Defect 250 */
GROUP  BY 1,2,3,4

)  PRTY_APPL_RLE_VW  

ON (PRTY.PRTY_ID = PRTY_APPL_RLE_VW.PRTY_ID 
--AND PRTY.PRTY_DATA_FR_DT = PRTY_APPL_RLE_VW.PRTY_DATA_FR_DT
 )
WHERE  PRTY.PRTY_DATA_TO_DT = '9999-12-31 00:00:00.000000'
and PRTY.SRC_SYS_ID in (32,36)
) F 


ON F.APPL_ID = A.APPL_ID


LEFT OUTER JOIN
(

SELECT DISTINCT			A.APPL_ID
												, CASE
																WHEN CM_BINGO.CM_FLG ='N' 				AND UW_BINGO.UW_FLG = 'N' 			THEN 'N'
																WHEN CM_BINGO.CM_FLG ='Y'				AND UW_BINGO.UW_FLG = 'Y' 			THEN 'Y'
																WHEN CM_BINGO.CM_FLG ='Y'				AND UW_BINGO.UW_FLG = 'N' 			THEN 'N'
																WHEN CM_BINGO.CM_FLG ='N' 				AND UW_BINGO.UW_FLG = 'Y' 			THEN 'N'
																WHEN CM_BINGO.CM_FLG ='N' 				AND UW_BINGO.UW_FLG IS NULL 	THEN 'N'
																WHEN CM_BINGO.CM_FLG IS NULL	AND UW_BINGO.UW_FLG = 'N' 			THEN 'N'
																WHEN CM_BINGO.CM_FLG ='Y' 				AND UW_BINGO.UW_FLG IS NULL 	THEN 'N'
																WHEN CM_BINGO.CM_FLG IS NULL	AND UW_BINGO.UW_FLG = 'Y' 			THEN 'N'
																ELSE NULL
												  END AS BINGO_FLG
												, CM_BINGO.CM_FLG
												, UW_BINGO.UW_FLG
												, CM_BINGO.CM_RSN_ADD_DT
												, UW_BINGO.UW_RSN_ADD_DT
												,CASE   
				                                                WHEN CM_BINGO.CM_RSN_ADD_DT > UW_BINGO.UW_RSN_ADD_DT THEN CM_BINGO.CM_RSN_ADD_DT
				                                                WHEN CM_BINGO.CM_RSN_ADD_DT IS NULL AND  UW_BINGO.UW_RSN_ADD_DT IS NOT NULL THEN UW_BINGO.UW_RSN_ADD_DT
				                                                WHEN UW_BINGO.UW_RSN_ADD_DT IS NULL AND CM_BINGO.CM_RSN_ADD_DT IS NOT NULL THEN CM_RSN_ADD_DT
				                                                ELSE UW_BINGO.UW_RSN_ADD_DT
												END AS BINGO_FLG_DT

FROM 

(

SELECT		APPL_ID
FROM PROD_NBR_VW.NB_BINGO_VW
WHERE BINGO_TO_DT = '9999-12-31 00:00:00.000000'
AND NB_BINGO_VW.SRC_SYS_ID in (32,36)
QUALIFY ( ROW_NUMBER() OVER ( PARTITION BY APPL_ID ORDER BY RSN_ADD_DT ASC )  = 1 )

) A

LEFT OUTER JOIN 

(

SELECT			APPL_ID
	                    , ROLE_TYP
	                    , BINGO_FLG AS CM_FLG
	                    , COALESCE(RSN_ADD_DT, BINGO_FR_DT) AS CM_RSN_ADD_DT
FROM PROD_NBR_VW.NB_BINGO_VW
WHERE BINGO_TO_DT = '9999-12-31 00:00:00.000000'
AND ROLE_TYP = 'CM'
AND NB_BINGO_VW.SRC_SYS_ID in (32,36)
QUALIFY ( ROW_NUMBER() OVER ( PARTITION BY APPL_ID ORDER BY RSN_ADD_DT ASC )  = 1 )

)  CM_BINGO

ON A.APPL_ID = CM_BINGO.APPL_ID

LEFT OUTER JOIN
(

SELECT			APPL_ID
                        , ROLE_TYP
                        , BINGO_FLG AS UW_FLG
                        , COALESCE(RSN_ADD_DT, BINGO_FR_DT) AS UW_RSN_ADD_DT
FROM PROD_NBR_VW.NB_BINGO_VW
WHERE BINGO_TO_DT = '9999-12-31 00:00:00.000000'
AND ROLE_TYP = 'UW'
AND NB_BINGO_VW.SRC_SYS_ID in (32,36)
QUALIFY ( ROW_NUMBER() OVER ( PARTITION BY APPL_ID ORDER BY RSN_ADD_DT ASC )  = 1 )

) UW_BINGO


ON A.APPL_ID = UW_BINGO.APPL_ID


WHERE  BINGO_FLG IS NOT NULL

) G

ON G.APPL_ID = A.APPL_ID

LEFT OUTER JOIN

(

SELECT  		APPL_ID
						, LOG_IN_ID AS UW_LOG_IN_ID 
						, APPL_DATA_FR_DT
						, LST_NM AS UW_LST_NM
						, FRST_NM AS UW_FRST_NM
						, NB_PRTY_CASE_OWN_VW.TEAM_CD AS UW_TEAM_CD
						, TEAM_CD_SHRT_DESC AS UW_TEAM_NM

FROM  PROD_NBR_VW.NB_PRTY_CASE_OWN_VW 

LEFT OUTER JOIN PROD_USIG_CMN_VW.USR_RLE_CD_VW
		ON 		NB_PRTY_CASE_OWN_VW.USR_RLE_CD =USR_RLE_CD_VW.USR_RLE_CD
		 
LEFT OUTER JOIN PROD_USIG_CMN_VW.TEAM_CD_VW 
		ON 		TEAM_CD_VW.TEAM_CD = NB_PRTY_CASE_OWN_VW.TEAM_CD
		
WHERE NB_PRTY_CASE_OWN_VW.USR_RLE_CD = 'UW' 
AND NB_PRTY_CASE_OWN_VW.CASE_OWN_TO_DT =  '9999-12-31 00:00:00.000000'
AND NB_PRTY_CASE_OWN_VW.SRC_SYS_ID in (32,36)

) H

ON A.APPL_ID=H.APPL_ID 


LEFT OUTER JOIN
(

SELECT 		APPL_ID
						, LOG_IN_ID AS CM_LOG_IN_ID
						, APPL_DATA_FR_DT
						, LST_NM AS CM_LST_NM
						, FRST_NM AS CM_FRST_NM
						, NB_PRTY_CASE_OWN_VW.TEAM_CD AS CM_TEAM_CD
						, TEAM_CD_SHRT_DESC AS CM_TEAM_NM
						, NB_PRTY_CASE_OWN_VW.USR_RLE_CD
						
FROM  PROD_NBR_VW.NB_PRTY_CASE_OWN_VW 

LEFT OUTER JOIN PROD_USIG_CMN_VW.USR_RLE_CD_VW
		ON 		NB_PRTY_CASE_OWN_VW.USR_RLE_CD =USR_RLE_CD_VW.USR_RLE_CD 

LEFT OUTER JOIN PROD_USIG_CMN_VW.TEAM_CD_VW 
		ON 		TEAM_CD_VW.TEAM_CD = NB_PRTY_CASE_OWN_VW.TEAM_CD
		
WHERE NB_PRTY_CASE_OWN_VW.USR_RLE_CD = 'NBS' 
AND NB_PRTY_CASE_OWN_VW.CASE_OWN_TO_DT =  '9999-12-31 00:00:00.000000' 
AND NB_PRTY_CASE_OWN_VW.SRC_SYS_ID in (32,36)

) I

ON I.APPL_ID = A.APPL_ID


LEFT OUTER JOIN
(
SELECT 	APPL_ID 
					, ANNL_PREM
					, MDL_PREM
					, BILL_TYP_CD
					, BILL_FREQ_CD
					, APPL_1035_AS_PREM
					,CASE WHEN SRC_BILL_FRQ IN ('1', 'A', 'SP') THEN 1 
                                WHEN SRC_BILL_FRQ IN ('2', 'S') THEN 2 				
                                WHEN SRC_BILL_FRQ IN ('3', 'Q', 'SQ')  THEN 4 
                                WHEN SRC_BILL_FRQ IN ('7', 'M', 'MA', 'MQ', 'MS', 'SM', 'TM') THEN 12
                      END AS BILL_FREQ_CONV					
					
FROM PROD_NBR_VW.NB_BILL_INFO_VW
WHERE BILL_INFO_TO_DT='9999-12-31 00:00:00.000000'
AND NB_BILL_INFO_VW.SRC_SYS_ID in (32,36)
) K

ON A.APPL_ID = K.APPL_ID

LEFT OUTER JOIN

(

SELECT 	APPLID
					, UW_LOG_IN_ID
					, CM_LOG_IN_ID
					, CASE WHEN CM_LOG_IN_ID IS NULL THEN 'SIMPLIFIED'	ELSE 'FULLY U/W'	END AS UW_TYP
					
FROM
(

(

SELECT  	APPL_ID AS APPLID	, LOG_IN_ID AS UW_LOG_IN_ID 
FROM  PROD_NBR_VW.NB_PRTY_CASE_OWN_VW 
WHERE NB_PRTY_CASE_OWN_VW.USR_RLE_CD = 'UW' 
AND NB_PRTY_CASE_OWN_VW.CASE_OWN_TO_DT =  '9999-12-31 00:00:00.000000'
AND NB_PRTY_CASE_OWN_VW.SRC_SYS_ID in (32,36)

) A

LEFT OUTER JOIN
(
SELECT  APPL_ID, LOG_IN_ID AS CM_LOG_IN_ID
FROM  PROD_NBR_VW.NB_PRTY_CASE_OWN_VW
WHERE NB_PRTY_CASE_OWN_VW.USR_RLE_CD = 'NBS' 
AND NB_PRTY_CASE_OWN_VW.CASE_OWN_TO_DT =  '9999-12-31 00:00:00.000000'
AND NB_PRTY_CASE_OWN_VW.SRC_SYS_ID in (32,36)
) B

ON (APPLID = B.APPL_ID 
AND UW_LOG_IN_ID = CM_LOG_IN_ID)

) 

) L

ON A.APPL_ID = L.APPLID

LEFT OUTER JOIN

(

SELECT APPL_ID, XCLDE_TYP
FROM PROD_NBR_VW.NB_UWRT_RISK_VW
WHERE UWRT_RISK_TO_DT =  '9999-12-31 00:00:00.000000'
AND XCLDE_TYP<>'UNK'
AND NB_UWRT_RISK_VW.SRC_SYS_ID in (32,36)

) M

ON A.APPL_ID = M.APPL_ID


LEFT OUTER JOIN

(

SELECT 		COALESCE((TRIM(BOTH FROM LST_NM) || ', ' || TRIM(BOTH FROM FRST_NM)),LST_NM) AS AGNT_NM_MISS
						, HIER_USER_VW.UID 
						, HIER_USER_VW.CAS_IND AS CAS_IND_MISS
						, SSN

FROM PROD_PDCR_HIER_VW.HIER_USER_VW
WHERE  REC_END_DT = '9999-12-31 00:00:00.000000'

) N

ON N.UID = A.PRODUCER_ID

LEFT OUTER JOIN

(

SELECT 		APPL_ID
						, CAST(AGMT_STUS_DT AS DATE) AS CUR_STATUS_DATE
						, AGMT_STUS_DT  AS CUR_STATUS_DATE_JOINED
						, CAS_STUS_SHRT_DESC AS CUR_STUS
						
FROM PROD_NBR_VW.NB_APPL_VW 

LEFT OUTER JOIN PROD_USIG_CMN_VW.CAS_STUS_CD_VW
		ON		NB_APPL_VW.AGMT_STUS_CD =CAS_STUS_CD_VW.CAS_STUS_CD
		
WHERE NB_APPL_VW.APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
AND NB_APPL_VW.SRC_SYS_ID in (32,36)

) O
  
 ON A.APPL_ID= O.APPL_ID

LEFT OUTER JOIN 
(

SELECT 		A.APPL_ID
						,  A.RPT_PLCM_STUS_CD 
						,  C.RPT_PLCM_STUS_SHRT_DESC AS RPT_PLCM_STUS
						,  A.RPT_INV_STUS_CD 
						,  B.RPT_INV_STUS_SHRT_DESC AS RPT_INV_STUS
						
FROM  PROD_NBR_VW.NB_APPL_VW A

LEFT OUTER JOIN 	PROD_USIG_CMN_VW.RPT_INV_STUS_CD_VW B
		ON		A.RPT_INV_STUS_CD = B.RPT_INV_STUS_CD
		
LEFT OUTER JOIN 	PROD_USIG_CMN_VW.RPT_PLCM_STUS_CD_VW C
		ON 		A.RPT_PLCM_STUS_CD = C.RPT_PLCM_STUS_CD 

WHERE APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
AND A.SRC_SYS_ID in (32,36)

) P

 ON A.APPL_ID = P.APPL_ID

LEFT OUTER JOIN
(

SELECT 		APPL_ID
						, MIN(CRTE_DT) AS TPP_INIT_RVW_STRT_DT
						, MIN(CPLT_DT) AS TPP_INIT_RVW_END_DT
						
FROM PROD_NBR_VW.NB_WRK_ITEM_VW

GROUP BY 1

WHERE SRC_WRK_ITEM_ID IN (1000051, 2000622, 2000621) 
AND WRK_ITEM_TO_DT = '9999-12-31 00:00:00.000000'
AND NB_WRK_ITEM_VW.SRC_SYS_ID in (32,36)


) R

ON R.APPL_ID = A.APPL_ID


LEFT OUTER JOIN
(

SELECT 		APPL_ID
						, MIN(REQ_ORDR_DT) AS WR_INIT_RVW_STRT_DT
						, MIN(REQ_STUS_DT) AS WR_INIT_RVW_END_DT
						
FROM PROD_NBR_VW.NB_REQ_VW

WHERE REQ_CD = 'MBRS'
AND REQ_STUS_CD = 'REVIEWED'
AND REQ_TO_DT = '9999-12-31 00:00:00.000000' 
AND NB_REQ_VW.SRC_SYS_ID in (32,36)

GROUP BY 1

) S

ON S.APPL_ID = A.APPL_ID


LEFT OUTER JOIN 

( SELECT rd.APPL_ID 

, SUM( CASE WHEN rd.RIDER_CD='ALIR' AND TRIM( rd.FIELD_NAME) =  'Modal Amount'  THEN CAST(FIELD_DATA AS DECIMAL(17,2)  ) 
  ELSE 0.00
  END ) AS ALIR_ANNL
  
, SUM( CASE WHEN rd.RIDER_CD='ALIR' AND TRIM( rd.FIELD_NAME) = 'Unscheduled Amount' THEN CAST(FIELD_DATA AS DECIMAL(17,2)  )
  ELSE 0.00
  END )  AS ALIR_DMP           
  
, SUM( CASE WHEN rd.RIDER_CD='LISR' AND TRIM( rd.FIELD_NAME) =  'Modal Amount'  THEN CAST(FIELD_DATA AS DECIMAL(17,2)  )
  ELSE 0.00
  END ) AS LISR_ANNL
  
, SUM( CASE WHEN rd.RIDER_CD='LISR' AND TRIM( rd.FIELD_NAME) = 'Unscheduled Amount' THEN CAST(FIELD_DATA AS DECIMAL(17,2)  )
  ELSE 0.00
  END ) AS LISR_DMP         


 FROM  PROD_NBR_VW.NB_RIDER_INFO_VW  rd
 WHERE  rd.rider_info_to_dt ='9999-12-31 00:00:00.000000'
  AND  rd.SRC_SYS_ID = 36
  AND  TRIM(rd.RIDER_CD) IN ('ALIR' , 'LISR' )
  AND TRIM( rd.FIELD_NAME) IN ( 'Modal Amount' , 'Unscheduled Amount' ) 
    GROUP BY 1
    ) RIDER    
ON RIDER.APPL_ID = A.APPL_ID


/*


LEFT OUTER JOIN

(SELECT DISTINCT
   pdcr_uid
, SM_BD_FULL_NM SALES_UNIT_MANAGER
, sm_bd_ofc_id AS SALES_MANAGER_UNIT
, sm_bd_uid AS SALES_MANAGER_UID
, CAS_IND AS CAS_IND
FROM    
(
SELECT                                pdcr_uid
                                               ,sm_bd_ofc_id
                                            ,MAX(CASE WHEN row_num MOD 10 = 0 THEN sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 1 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 2 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 3 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 4 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 5 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 6 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 7 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 8 THEN ' / ' || sm_bd_full_nm EL
SE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 9 THEN ' / ' || sm_bd_full_nm ELSE '' END) AS sm_bd_full_nm
                                            ,CAS_IND
                                            ,MAX(CASE WHEN row_num MOD 10 = 0 THEN sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 1 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 2 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 3 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                           	MAX(CASE WHEN row_num MOD 10 = 4 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 5 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 6 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 7 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 8 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 9 THEN ' / ' || sm_bd_uid ELSE '' END) AS sm_bd_uid
FROM
(
SELECT								pdcr_uid
                                            ,sm_bd_ofc_id
                                            ,row_num / 10 AS row_num
                                            ,MAX(CASE WHEN row_num MOD 10 = 0 THEN sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 1 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 2 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 3 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                           	MAX(CASE WHEN row_num MOD 10 = 4 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 5 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 6 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 7 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 8 THEN ' / ' || sm_bd_full_nm ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 9 THEN ' / ' || sm_bd_full_nm ELSE '' END) AS sm_bd_full_nm
                                            ,CAS_IND
										    ,MAX(CASE WHEN row_num MOD 10 = 0 THEN sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 1 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 2 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 3 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                           	MAX(CASE WHEN row_num MOD 10 = 4 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 5 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 6 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 7 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 8 THEN ' / ' || sm_bd_uid ELSE '' END) ||
                                            MAX(CASE WHEN row_num MOD 10 = 9 THEN ' / ' || sm_bd_uid ELSE '' END) AS sm_bd_uid

FROM
(
SELECT                                a.uid AS pdcr_uid
                                                ,b.uid AS sm_bd_uid
                                                ,b.ofc_id AS sm_bd_ofc_id
                                                ,CAST(TRIM(BOTH FROM u.lst_nm) || ', ' || TRIM(BOTH FROM u.frst_nm) AS VARCHAR(100)) AS sm_bd_full_nm
                                                ,ROW_NUMBER() OVER (PARTITION BY a.ofc_id, a.uid ORDER BY u.lst_nm)-1 AS row_num
                                                ,u2.CAS_IND
FROM   PROD_PDCR_HIER_VW.hier_sup_grp_vw a
JOIN       PROD_PDCR_HIER_VW.hier_sup_grp_vw b   --get an overseer for a producer 
                ON a.unit = b.unit
                AND a.assoc_nm = 'member'
                AND b.assoc_nm = 'overseer'
                AND b.grp_type = ANY( 'SM Group' , 'BD Group' )
                AND a.grp_type = ANY( 'SM Group' , 'BD Group' )
                --and a.uid <> b.uid
                AND a.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND b.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND a.src_del_ind IS NULL
                AND b.src_del_ind IS NULL
LEFT OUTER JOIN PROD_PDCR_HIER_VW.hier_user_vw u --get  an overseer full name for a producer 
                ON b.uid = u.uid
                AND b.ofc_id = u.ofc_id
                AND TRIM(BOTH FROM u.usr_stus) = 'ACTIVE'
                AND b.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND u.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND u.src_del_ind IS NULL
                AND b.src_del_ind IS NULL
LEFT OUTER JOIN PROD_PDCR_HIER_VW.hier_user_vw u2  --get producer details 
                ON a.uid = u2.uid
                --ofc_id are different in hier_sup_grp table and hier_user table 
                --and a.ofc_id = u2.ofc_id
                AND TRIM(BOTH FROM u2.usr_stus) = 'ACTIVE'
                AND a.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND u2.rec_end_dt = '9999-12-31 00:00:00.000000'
                AND a.src_del_ind IS NULL
                AND u2.src_del_ind IS NULL
WHERE a.src_del_ind IS NULL

) Q1
GROUP BY 1,2,3,5
) Q2
GROUP BY 1,2,4
)A
) U

ON UPPER(U.PDCR_UID) = PRODUCER_ID AND SALES_MANAGER_UNIT = mrg_ent_nb

*/



/*		Hierarchy -- Get SM/BKD		*/

LEFT OUTER JOIN 
									(
											SELECT	AGY_LGCY_ID 
															, PRD_BPID
															, PRD_NM
															, MAX(CASE WHEN ROW_NUM MOD 10 = 0 THEN SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 1 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 2 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 3 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 4 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 5 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 6 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 7 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 8 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 9 THEN ' / ' || SM_BKD_NM ELSE '' END) AS SM_BKD_NM
															, MAX(CASE WHEN ROW_NUM MOD 10 = 0 THEN SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 1 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 2 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 3 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 4 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 5 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 6 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 7 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 8 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 9 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) AS SM_BKD_BP_ID
											FROM
											(
											
											SELECT	AGY_LGCY_ID 
															, PRD_BPID
															, PRD_NM
															, ROW_NUM / 10 AS ROW_NUM
															, MAX(CASE WHEN ROW_NUM MOD 10 = 0 THEN SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 1 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 2 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 3 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 4 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 5 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 6 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 7 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 8 THEN ' / ' || SM_BKD_NM ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 9 THEN ' / ' || SM_BKD_NM ELSE '' END) AS SM_BKD_NM
															, MAX(CASE WHEN ROW_NUM MOD 10 = 0 THEN SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 1 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 2 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 3 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 4 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 5 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 6 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 7 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 8 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) ||
															MAX(CASE WHEN ROW_NUM MOD 10 = 9 THEN ' / ' || SM_BKD_BP_ID ELSE '' END) AS SM_BKD_BP_ID
											
											FROM
											(
															
															SEL	 DISTINCT 
															
															AGY_LGCY_ID
															, SM_BKD_BP_ID
															, CAST( TRIM( SM_BKD_NM ) AS VARCHAR(100) ) AS SM_BKD_NM
															, PRD_NM
															, PRD_BPID
															, ROW_NUMBER() OVER (PARTITION BY AGY_LGCY_ID, PRD_BPID ORDER BY SM_BKD_NM )-1 AS ROW_NUM

															FROM (
											
																			SEL  DISTINCT
																			
																			TRIM( AGY_LGCY_ID ) AS AGY_LGCY_ID 
																			, 'AA' || TRIM ( SUBSTR( SM_BKD_BPID , 5 , 6 ) ) AS SM_BKD_BP_ID
																			, SM_BKD_NM 
																			, 'AA' || TRIM ( SUBSTR( PRD_BPID , 5 , 6 ) ) AS PRD_BPID
																			, PRD_NM
																			
																			FROM PROD_USIG_ACCESS_VW.SALES_HIERARCHY_VW 
																			
																			WHERE SM_BKD_BPID IS NOT NULL 
																			--AND	PRD_RLE IN ( 'PRD' , 'CRP' )
																			AND 	SM_BKD_STUS = 'ACTIVE'
																			AND	PRD_UNT_STUS = 'ACTIVE'
																			AND	PRD_UNT_REL_END_DT = '9999-12-31' -- for some reason even when the PRD_UNT_STUS is Active, there's PRD_UNT_REL_END_DT <> 9999-12-31
																			
																			GROUP BY 1,2,3,4,5
																			
																			
																		) A
											
											) Q1
											
											GROUP BY 1,2,3,4
											
											) Q2
											
											GROUP BY 1,2,3

									
									) HIERARCHY


ON 		UPPER(PRODUCER_ID) = HIERARCHY.PRD_BPID 
AND 	TRIM(HIERARCHY.AGY_LGCY_ID) = TRIM(mrg_ent_nb)

LEFT OUTER JOIN PROD_NBR_VW.NB_MAX_TRANS_DT_VW T
ON 1 = 1

);
