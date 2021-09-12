REPLACE VIEW PROD_NBR_VW.NB_SUBMIT_APPL_DTL_AWF_VW
AS LOCKING ROW FOR ACCESS 
(

SELECT                  
														  SMBD.COMP_MRG_AGY_SRC_SYS_PRTY_ID AS MRG_AGENCY_SRC_SYS_PRTY_ID
														 , SMBD.COMP_MRG_ENT_NM AS  MRG_ENT_NM
														 , PROD_TYP_NME AS ORGANIZATION_BUSINESS_TYPE_CD
														 , NB_APPL_VW.HLDG_KEY_PFX||TRIM(LEADING '0' FROM NB_APPL_VW.HLDG_KEY) AS HLDG_KEY
													     , SMBD.SOLICITING_AGT_FULL_NM
														, SMBD.SOLICITING_AGT_SRC_SYS_PRTY_ID AS SOLICITING_AGT_SRC_SYS_PRTY_ID
														, SMBD.SOLICITING_AGT_TYP_CD AS SOLICITING_AGT_TYP_CD
														, case when SMBD.SOLICITING_AGT_TYP_CD ='CAB' then 'BROKER' else 'CAREER' end SOLICITING_AGT_TYP_DESC
														, cast(APPL_SUBM_DT as date) AS SUBMISSION_DATE
														, cast(NB_APPL_VW.AGMT_STUS_DT as date) AS CURR_STATUS_EVENT_DT
														, cast((case 
																			when AGMT_STUS_CD = 'SB'  then 'Pending' 
																			when AGMT_STUS_CD = 'PE' then 'Pending' 
																			when AGMT_STUS_CD='AP' then 'Approved' 
																			when AGMT_STUS_CD='IS' then 'Reported' 
																			when AGMT_STUS_CD='WT' then 'Incomplete/Withdrawn' 
																			end) as varchar(30)) CURR_STATUS_EVENT_DETAIL
														, PPD_IND PREPAID_PREMIUM_IND
														, coalesce(NULLIFZERO(REPL.EXPTD_AMT),NB_APPL_VW.TOT_RISK_AMT) AS WEIGHTED_ANNUAL_PREM_AMT
														, (coalesce(NULLIFZERO(REPL.EXPTD_AMT),NB_APPL_VW.TOT_RISK_AMT)*0.03) AS ESTIMATED_FYC
														, coalesce(NULLIFZERO(REPL.EXPTD_AMT),NB_APPL_VW.TOT_RISK_AMT) AS ANNL_PREM
														, 0 COV_ADL_PREM
														, 0 APPL_1035_AS_PREM
														, UPPER(INS_LAST_NAME) AS INS_LAST_NAME
 													    , UPPER(INS_FIRST_NAME) AS INS_FIRST_NAME
														, case when CHAR_LENGTH(TRIM(BOTH ' ' FROM INS_FIRST_NAME))>1  THEN UPPER(INS_LAST_NAME)|| ', ' ||UPPER(INS_FIRST_NAME) ELSE  UPPER(INS_LAST_NAME) end as INS_FULL_NAME
														, PROD_TYP_NME  PRODUCT_TYPE
														, '' PROD_ID
														, SMBD.SOL_SM_BKD_NM AS SALES_UNIT_MANAGER
														, SMBD.SOL_SM_BKD_SRC_SYS_PRTY_ID AS  SALES_MANAGER_UID
														, NB_REPL_VW.SRC_REPL_TYP as REPL_TYP_DESC
														,'' REPLACEMENT_INSURANCE_IND
														,0 REPLACEMENT_CNT
														,cast(null as varchar(20)) as SIGN_METH
														,0 ESIGN_CNT
														,0 EZAPP_CNT
														,cast(null as char(1)) GRADED_PREMIUM
														, GRP_NB AS GROUP_SRC_SYS_PRTY_ID
                                                        ,''GROUP_FULL_NM
                                                    	, 'ANN' SRC_SYS
                                                    	,COALESCE(EXP_L.EXP_LVL,'') as EXP_LVL
                                                    	,SMBD.COMP_SOL_AGT_SRC_SYS_PRTY_ID AS COMP_SOL_AGT_SRC_SYS_PRTY_ID
                                                    	, SMBD.COMP_SOL_AGT_FULL_NM     AS COMP_SOL_AGT_FULL_NM
                                                    	, SMBD.COMP_SOL_AGT_TYP_CD AS COMP_SOL_AGT_TYP_CD
                                                    	, SMBD.UNIT_STRT_DT AS UNIT_STRT_DT
                                                    	, SMBD.UNIT_END_DT AS UNIT_END_DT
                                                    	, SMBD.COMP_SM_BKD_SRC_SYS_PRTY_ID AS SM_BKD_SRC_SYS_PRTY_ID
                                                    	, SMBD.COMP_SM_BKD_NM AS SM_BKD_NM
                                                    	, SMBD.SPLIT_STRT_DT AS SPLIT_STRT_DT
                                                    	, SMBD.SPLIT_END_DT AS SPLIT_END_DT
                                                    	, SMBD.SM_SPLIT_PCT AS SM_SPLIT_PCT
                                                    	, cast(100 as decimal(17,2)) AS COMP_PCT
                                                    	, CAST( WEIGHTED_ANNUAL_PREM_AMT *  ( COALESCE( COMP_PCT , 100 ) / 100 ) * ( COALESCE(  SMBD.SM_SPLIT_PCT , 100 ) / 100 ) AS DEC(18,2) ) AS COMP_WEIGHTED_ANNUAL_PREM_AMT
                                                    	, CAST( ESTIMATED_FYC *  ( COALESCE( COMP_PCT , 100 ) / 100 ) * ( COALESCE(  SMBD.SM_SPLIT_PCT , 100 ) / 100 ) AS DEC(18,2) ) AS COMP_ESTIMATED_FYC
                                                    	, CAST( ANNL_PREM *  ( COALESCE( COMP_PCT , 100 ) / 100 ) * ( COALESCE(  SMBD.SM_SPLIT_PCT , 100 ) / 100 ) AS DEC(18,2) ) AS COMP_ANNUAL_PREMIUM
                                                        , NB_APPL_VW.APPL_TYP AS APPLICATION_TYPE
FROM PROD_NBR_VW.NB_APPL_VW  NB_APPL_VW

INNER JOIN 
(
SELECT APPL_ID, SUM(CHECK_AMT) CHECK_AMT FROM PROD_NBR_VW.NB_WRK_ITEM_VW 
where SRC_SYS_ID=82 
and WRK_ITEM_TO_DT='9999-12-31 00:00:00.00000'
--and STUS_RSN_CD in ('AP','PE','SB','IS')
--and trim(CNTNT_MNG_WRK_ITEM_TYP) in ('APP1035X','APPCASH','APPLICATION','APPLIQ','APPREPL','APPTRANS','STPAPP1035X','STPAPPEXCH','STPAPPLICATION','STPAPPLIQ','STPAPPREPL')
GROUP BY APPL_ID
) WRK_ITEM ON NB_APPL_VW.APPL_ID=WRK_ITEM.APPL_ID

LEFT OUTER JOIN  PROD_NBR_VW.NB_REPL_VW 
on NB_APPL_VW.APPL_ID=NB_REPL_VW.APPL_ID 
and NB_REPL_VW.SRC_SYS_ID=82 
and NB_REPL_VW.REPL_TO_DT='9999-12-31 00:00:00.00000'

LEFT OUTER JOIN 
(
SELECT 
TRIM(LEADING '0' FROM REPL_REF_NR) REPL_REF_NR, SUM(EXPTD_AMT) EXPTD_AMT
FROM PROD_NBR_VW.NB_REPL_XTRA_XCH_INFO_VW 
WHERE 
REPL_XTRA_XCH_TO_DT='9999-12-31 00:00:00.00000'
AND SRC_SYS_ID=86
GROUP BY REPL_REF_NR
) REPL on TRIM(LEADING '0' FROM NB_APPL_VW.HLDG_KEY)=REPL.REPL_REF_NR

                                    
LEFT OUTER JOIN PROD_USIG_CMN_VW.PRODUCT_TRANSLATOR_VW 
                                    ON       PROD_TYP_CDE = NB_APPL_VW.PROD_CD

LEFT OUTER JOIN
(
SELECT		  APPL_ID
                        , PRTY.LST_NM AS INS_LAST_NAME
                        , PRTY.FRST_NM AS INS_FIRST_NAME
FROM PROD_NBR_VW.NB_APPL_PRTY_VW  PRTY  
JOIN PROD_NBR_VW.NB_PRTY_APPL_RLE_VW PRTY_APPL_RLE_VW
ON PRTY.PRTY_ID = PRTY_APPL_RLE_VW.PRTY_ID 
WHERE 
PRTY.PRTY_DATA_TO_DT = '9999-12-31 00:00:00.000000'
AND PRTY_APPL_RLE_VW.PRTY_APPL_TO_DT = '9999-12-31 00:00:00.000000'  
AND PRTY.SRC_SYS_ID=82
) B ON NB_APPL_VW.APPL_ID=B.APPL_ID

LEFT OUTER JOIN PROD_NBR_VW.NB_PRTY_CASE_OWN_VW on NB_APPL_VW.APPL_ID=NB_PRTY_CASE_OWN_VW.APPL_ID
AND NB_PRTY_CASE_OWN_VW.CASE_OWN_TO_DT =  '9999-12-31 00:00:00.000000'
AND NB_PRTY_CASE_OWN_VW.SRC_SYS_ID=82



LEFT OUTER JOIN PROD_NBR_VW.NB_SOL_COMP_SMBD_VW SMBD
 ON NB_APPL_VW.HLDG_KEY_PFX||TRIM(LEADING '0' FROM NB_APPL_VW.HLDG_KEY)  = SMBD.HLDG_KEY
 AND SMBD.SRC_SYS = 'AWF'


LEFT OUTER JOIN 
(
select 
'AA' || TRIM ( SUBSTR(BUSINESS_PARTNER_ID , 5 , 6 ) ) BUSINESS_PARTNER_ID,
case 
when CMN.PRD_BPID is not null then 'Contract B'
when CAS_IND='N' then ''
when PRTY_STUS='TMP' then 'Termed' 
when (CURRENT_DATE-FT_ST_DT)<=1460 then '1-4'
when (CURRENT_DATE-FT_ST_DT)>=1461 then '5+'
end EXP_LVL
from PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW LEFT OUTER JOIN 
(
select DISTINCT PRD_BPID
from PROD_USIG_ACCESS_VW.SALES_HIERARCHY_VW
where 
PRD_STD_CONTR_TYP='Z210'
and PRD_STUS='ACTIVE'
) CMN
on BUSINESS_PARTNER_ID=CMN.PRD_BPID
where 
FT_ST_DT<>'0001-01-01'
) EXP_L 
ON SMBD.COMP_SOL_AGT_SRC_SYS_PRTY_ID=EXP_L.BUSINESS_PARTNER_ID



WHERE		APPL_DATA_TO_DT = '9999-12-31 00:00:00.000000'
        AND 	   EXTRACT(YEAR FROM cast(APPL_SUBM_DT as date) )  >= EXTRACT(YEAR FROM CURRENT_DATE)-2
        AND 	   NB_APPL_VW.SRC_SYS_ID=82
        
       
--	Remove duplicate relationships - choose the latest relationship when Producer has more than one to a Unit

QUALIFY ( ROW_NUMBER() OVER ( PARTITION BY   NB_APPL_VW.HLDG_KEY_PFX||TRIM(LEADING '0' FROM NB_APPL_VW.HLDG_KEY) 
																							, SMBD.SOL_MRG_AGY_SRC_SYS_PRTY_ID
																							, SMBD.COMP_SOL_AGT_SRC_SYS_PRTY_ID
																							, SMBD.COMP_MRG_AGY_SRC_SYS_PRTY_ID
																							, SMBD.SOLICITING_AGT_TYP_CD  
																							, SMBD.COMP_SOL_AGT_TYP_CD  
																							, SMBD.COMP_SM_BKD_SRC_SYS_PRTY_ID
																							ORDER BY  CASE WHEN  SMBD.COMP_SOL_AGT_TYP_CD='CAS' THEN 1 ELSE 2 END  )   = 1 )

);
