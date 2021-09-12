REPLACE VIEW PROD_NBR_VW.NB_SUBMIT_APPL_DTL_VW
AS LOCKING ROW FOR ACCESS 
(
SELECT		SUBSTR('000' , 1 ,3-CHAR_LENGTH( TRIM(BOTH FROM (CAST( a.MRG_AGENCY_SRC_SYS_PRTY_ID AS CHAR(3)))) )) || TRIM(BOTH FROM a.MRG_AGENCY_SRC_SYS_PRTY_ID) AS MRG_AGENCY_SRC_SYS_PRTY_ID
					, b.MRG_ENT_NM
					, a.ORGANIZATION_BUSINESS_TYPE_CD AS ORGANIZATION_BUSINESS_TYPE_CD
					, a.HLDG_KEY
					, CASE WHEN char_length( trim(   PDCR.FIRST_NM   ) ) = 0 AND  char_length( trim(  PDCR.LST_NM )) =  0 THEN  PDCR.FULL_NM 
								 ELSE  PDCR.LST_NM || ', ' || PDCR.FIRST_NM
									END  SOLICITING_AGT_FULL_NM
					, CASE	WHEN TRIM(BOTH FROM a.SOLICITING_AGT_SRC_SYS_PRTY_ID) = '' OR a.SOLICITING_AGT_SRC_SYS_PRTY_ID IS NULL THEN NULL ELSE a.SOLICITING_AGT_SRC_SYS_PRTY_ID END AS SOLICITING_AGT_SRC_SYS_PRTY_ID
					, CASE WHEN a.SOLICITING_AGT_TYP_CD = 'CAREER' THEN 'CAS' ELSE 'CAB' END AS SOLICITING_AGT_TYP_CD 
					, CASE WHEN a.SOLICITING_AGT_TYP_CD = 'CAREER' THEN 'CAREER'  WHEN a.SOLICITING_AGT_TYP_CD = 'BROKER' THEN 'BROKER' ELSE 'Unknown' END AS SOLICITING_AGT_TYP_DESC 
					, CAST( a.SUBMISSION_DATE AS DATE)  AS SUBMISSION_DATE
					, a.CURR_STATUS_EVENT_DT AS CURR_STATUS_EVENT_DT
					, CASE WHEN a.SRC_SYS = 'WR' THEN 
					           CASE TRIM(a.CURR_STATUS_EVENT_DETAIL)  
					                 WHEN 'Application Submitted' THEN 'Pending' 
					                 WHEN 'Resubmit' THEN 'Pending'
					                 WHEN 'Approved Pending Issue' THEN 'Approved'
					                 WHEN 'Pending Requirements' THEN 'Pending'
					                 WHEN 'Issued Reportable' THEN 'Issued'
					                 WHEN 'Reported' THEN 'Reported'
					                 WHEN 'Completed' THEN 'Incomplete/Withdrawn'					                 
					                 WHEN 'Not Tkn Pre-Issue' THEN  'Not Taken'
					                 WHEN 'Not Tkn Return' THEN  'Not Taken'
					                 WHEN 'Withdrawn' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Incomp Pre-Issue' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Dropped' THEN  'Incomplete/Withdrawn'
					                 WHEN 'Declined' THEN  'Declined'
					                 WHEN 'Survey' THEN 'Survey'
					                 WHEN 'Deleted' THEN 'Incomplete/Withdrawn'					                 
					           END 
					           WHEN  a.SRC_SYS = 'TPP'  THEN
					           CASE TRIM(a.CURR_STATUS_EVENT_DETAIL)  
					                 WHEN 'Application Submitted' THEN 'Pending'
					                 WHEN 'App Recd Incomplete' THEN 'Pending'
					                 WHEN 'Approved Pending Issue' THEN 'Approved'
					                 WHEN 'Approved Pending Offer' THEN  'Approved'
					                 WHEN 'Apvd Pend Issue Reqts' THEN 'Approved'
					                 WHEN 'Pending Requirements' THEN 'Pending'
					                 WHEN 'Pending UW Decision' THEN 'Pending'					                
                                     WHEN 'Issued Reportable' THEN  'Issued'					                 					                 
					                 WHEN 'Issued Not Reportable' THEN 'Issued'
					                 WHEN 'Reported' THEN 'Reported'
					                 WHEN 'Free Look' THEN 'Reported'
					                 WHEN 'Not Taken' THEN 'Not Taken'
					                 WHEN 'Incomplete' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Withdrawn' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Declined' THEN 'Declined'		
					                 WHEN 'Dropped' THEN 'Incomplete/Withdrawn'		
					                 WHEN 'System Transfer' THEN 'System Transfer'	                 
					           END  		
					           WHEN  a.SRC_SYS = 'DIPMS'  THEN
					           CASE COALESCE ( TRIM(a.CURR_STATUS_EVENT_DETAIL) ,  'Unk')
					                 WHEN 'Application Submitted' THEN 'Pending'
					                 WHEN 'Await' THEN 'Pending'
					                 WHEN 'Approved Pending Issue' THEN 'Approved'
					                 WHEN 'Completed' THEN 'Reported'								                                 
                                      WHEN 'Issued Reportable' THEN  'Issued'			        
					                 WHEN 'Reported' THEN 'Reported'
					                 WHEN 'Not Taken, Not Paid' THEN 'Not Taken'
					                 WHEN 'Not Tkn Return' THEN  'Not Taken'					                 
					                 WHEN 'Incomplete' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Incomplete - Closed' THEN 'Incomplete/Withdrawn'					                 
					                 WHEN 'Withdrawn' THEN 'Incomplete/Withdrawn'
					                 WHEN 'Declined' THEN 'Declined'
					                 WHEN 'Incomp Pre-Issue' THEN  'Declined/Withdrawn'
					                 WHEN 'Audit Failed' THEN 'Pending'
					                 WHEN 'Postponed' THEN 'Incomplete/Withdrawn'	    	
					                 WHEN 'Paused' THEN  'Incomplete/Withdrawn'	    
					                 WHEN 'Unk' THEN 'Unknown'   
					           END  				                 
					     END  AS CURR_STATUS_EVENT_DETAIL
					, a.PREPAID_PREMIUM_IND AS PREPAID_PREMIUM_IND
					, a.WEIGHTED_ANNUAL_PREM_AMT AS WEIGHTED_ANNUAL_PREM_AMT
					, a.ESTIMATED_FYC AS ESTIMATED_FYC
					, a.ANNL_PREM
					, a.COV_ADL_PREM
					, a.APPL_1035_AS_PREM
					, UPPER(a.INS_LAST_NAME) INS_LAST_NAME
					, UPPER(a.INS_FIRST_NAME) INS_FIRST_NAME
					, case when CHAR_LENGTH(TRIM(BOTH ' ' FROM a.INS_FIRST_NAME))>=1  THEN UPPER(a.INS_LAST_NAME)|| ', ' ||UPPER(a.INS_FIRST_NAME) ELSE  UPPER(a.INS_LAST_NAME) end as INS_FULL_NAME
					, a.PRODUCT_TYPE
					, a.PROD_ID
					, (case when a.SALES_UNIT_MANAGER is null then 'UN-ASSIGNED' else a.SALES_UNIT_MANAGER  end) SALES_UNIT_MANAGER 
					, (case when a.SALES_MANAGER_UID is null then 'UN-ASSIGNED' else a.SALES_MANAGER_UID end) SALES_MANAGER_UID
					, a.REPL_TYP_DESC
					, a.REPLACEMENT_INSURANCE_IND
					, (case when a.REPL_TYP_DESC='Not a Replacement' then 0 else 1 end) REPLACEMENT_CNT
					, SIGN_METH
					,(case when EZAPP_IND='Y' and  SIGN_METH='e-signed' then 1 else 0 end) ESIGN_CNT
					,(case when EZAPP_IND='Y' then 1 else 0 end) EZAPP_CNT
					,(case when GRADED_PREMIUM_POLICY='N' then 'NO'  when GRADED_PREMIUM_POLICY='Y'  then 'YES' else GRADED_PREMIUM_POLICY end) GRADED_PREMIUM
					,GROUP_SRC_SYS_PRTY_ID
					,GROUP_FULL_NM
					,SRC_SYS
					,EXP_L.EXP_LVL
					,case when LTC.APPL_ID is not null then 'Y' else 'N' end LTC_IND
					,A.APPLICATION_TYPE_CD AS APPLICATION_TYPE
FROM	PROD_NBR_VW.NB_RPT_VW a

LEFT OUTER JOIN PROD_NBR_VW.MRG_ENT_VW b
  ON a.MRG_AGENCY_SRC_SYS_PRTY_ID = b.MRG_ENT_NB

LEFT OUTER JOIN 
(
select distinct APPL_ID from PROD_NBR_VW.NB_COV_RISK_VW
where SRC_SYS_ID=36
and COV_RISK_TO_DT='9999-12-31 00:00:00.00000'
and PROD_CD='LTCR'
) LTC
ON a.APPL_ID=LTC.APPL_ID

LEFT OUTER JOIN PROD_USIG_STND_VW.PDCR_DEMOGRAPHICS_VW PDCR on a.SOLICITING_AGT_SRC_SYS_PRTY_ID='AA' || TRIM(SUBSTR(PDCR.BUSINESS_PARTNER_ID,5,6))

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
) EXP_L ON a.SOLICITING_AGT_SRC_SYS_PRTY_ID=EXP_L.BUSINESS_PARTNER_ID
           
WHERE EXTRACT(YEAR FROM SUBMISSION_DATE )  >= EXTRACT(YEAR FROM CURRENT_DATE)-2
);
