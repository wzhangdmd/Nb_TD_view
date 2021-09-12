

REPLACE VIEW PROD_NBR_VW.NB_BINGO_DTL_VW
AS LOCKING ROW FOR ACCESS 
(
SELECT	 distinct SUBSTR('000' , 1 ,3-CHAR_LENGTH( TRIM(BOTH FROM (CAST(MRG_AGENCY_SRC_SYS_PRTY_ID AS CHAR(3)))) )) || TRIM(BOTH FROM MRG_AGENCY_SRC_SYS_PRTY_ID) AS MRG_AGENCY_SRC_SYS_PRTY_ID
										,CASE WHEN SOLICITING_AGT_TYP_CD = 'CAREER' THEN 'CAS' ELSE 'CAB' END AS SOLICITING_AGT_TYP_CD
										,trim(SOLICITING_AGT_SRC_SYS_PRTY_ID) SOLICITING_AGT_SRC_SYS_PRTY_ID
										,SOLICITING_AGT_FULL_NM
										,INS_LAST_NAME
										,HLDG_KEY AS HLDG_KEY
										,BINGO_IND
										,cast(BINGO_REVIEW_DATE  as date) AS BINGO_REVIEW_DATE
										,cast(SUBMISSION_DATE as date) as SUBMISSION_DATE
										,ISSUE_DATE as ISSUE_DATE
									    ,ISSUE_DATE-(case when CARRIER_INPUT_DATE is null then cast(SUBMISSION_DATE as date) else cast(CARRIER_INPUT_DATE as date) end) as SUBMIT_ISSUE
									    ,CURR_STATUS_EVENT_DETAIL
									    ,cast(CM_BINGO_RVW_DT as date) as CM_BINGO_RVW_DT
									    ,cast(UW_BINGO_RVW_DT as date) as UW_BINGO_RVW_DT
									    ,CM_BINGO_IND
									    ,UW_BINGO_IND
									    ,A.CM_NIGO_REASON
									    ,B.UW_NIGO_REASON
									    ,trim(ALL_UW_NIGO_REASON) as ALL_UW_NIGO_REASON
									    ,trim(ALL_CM_NIGO_REASON) as ALL_CM_NIGO_REASON
									    ,C.MRG_ENT_NM
									    ,TRIM(UPPER (RPT.INS_LAST_NAME) || CASE WHEN RPT.INS_LAST_NAME IS NULL OR  RPT.INS_LAST_NAME=' '  THEN ' ' ELSE ', ' END  || UPPER (RPT.INS_FIRST_NAME ) ) AS INS_FULL_NM
					FROM	PROD_NBR_VW.NB_RPT_VW RPT
					LEFT OUTER JOIN    /* Code for UW NIGO Reasons */
					(
						SELECT 
                                APPL_ID
                                ,(max(case when row_num mod 10 = 0 then       UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 1 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 2 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 3 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 4 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 5 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 6 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 7 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 8 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 9 then '; ' || UW_NIGO_REASON else '' end) ) as ALL_UW_NIGO_REASON
						FROM
						(
						select   
                                APPL_ID
                                ,row_num/10 as row_num
                                ,cast(max(case when row_num mod 10 = 0 then UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 1 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 2 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 3 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 4 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 5 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 6 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 7 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 8 then '; ' || UW_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 9 then '; ' || UW_NIGO_REASON else '' end) as varchar(1000) ) as UW_NIGO_REASON
              			  from
                                (
		                                SEL 
		                                APPL_ID, 
		                                 trim(case when BINGO_RSN_CD_DESC in ('Unknown','In Good Order') then '' else BINGO_RSN_CD_DESC end)  as UW_NIGO_REASON,
		                                row_number() over (partition by APPL_ID order by BINGO_RSN_CD_DESC)-1 as row_num
		                                FROM PROD_NBR_VW.NB_BINGO_VW BINGO 
		                                 LEFT OUTER JOIN PROD_USIG_CMN_VW.BINGO_RSN_CD_VW RSN
		                                on BINGO.BINGO_RSN_CD=RSN.BINGO_RSN_CD
		                                where BINGO_TO_DT='9999-12-31 00:00:00.000000'
		                                and ROLE_TYP='UW'
		                                and SRC_SYS_ID in (32,36)
		                                group by 1,2, BINGO_RSN_CD_DESC
                                ) UW_T GROUP BY 1,2
						) UW_T1 GROUP BY 1
						) UW on  RPT.APPL_ID=UW.APPL_ID
					LEFT OUTER JOIN  /* Code for CM NIGO Reasons */
					 (
						SELECT 
                                APPL_ID
                                ,(max(case when row_num mod 10 = 0 then       CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 1 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 2 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 3 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 4 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 5 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 6 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 7 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 8 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 9 then '; ' || CM_NIGO_REASON else '' end) ) as ALL_CM_NIGO_REASON
						FROM
						(
						select   
                                APPL_ID
                                ,row_num/10 as row_num
                                ,cast(max(case when row_num mod 10 = 0 then CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 1 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 2 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 3 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 4 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 5 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 6 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 7 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 8 then '; ' || CM_NIGO_REASON else '' end) ||
                                max(case when row_num mod 10 = 9 then '; ' || CM_NIGO_REASON else '' end) as varchar(1000) ) as CM_NIGO_REASON
                		from
                                (
		                                
		                                SEL 
		                                APPL_ID, 
		                                 trim(case when BINGO_RSN_CD_DESC in ('Unknown','In Good Order') then '' else BINGO_RSN_CD_DESC end)  as CM_NIGO_REASON,
		                                row_number() over (partition by APPL_ID order by BINGO_RSN_CD_DESC)-1 as row_num
		                                FROM PROD_NBR_VW.NB_BINGO_VW BINGO 
		                                 LEFT OUTER JOIN PROD_USIG_CMN_VW.BINGO_RSN_CD_VW RSN
		                                on BINGO.BINGO_RSN_CD=RSN.BINGO_RSN_CD
		                                where BINGO_TO_DT='9999-12-31 00:00:00.000000'
		                                and ROLE_TYP='CM'
		                                and SRC_SYS_ID in (32,36)
		                                group by 1,2, BINGO_RSN_CD_DESC
                                ) CM_T GROUP BY 1,2
						) CM_T1 GROUP BY 1
						  ) CM1 on RPT.APPL_ID=CM1.APPL_ID
	LEFT OUTER JOIN (
								SEL APPL_ID,  trim(case when BINGO_RSN_CD_DESC in ('Unknown','In Good Order') then '' else BINGO_RSN_CD_DESC end) as CM_NIGO_REASON
                                FROM PROD_NBR_VW.NB_BINGO_VW BINGO 
                                 LEFT OUTER JOIN PROD_USIG_CMN_VW.BINGO_RSN_CD_VW RSN
                                on BINGO.BINGO_RSN_CD=RSN.BINGO_RSN_CD
                                where BINGO_TO_DT='9999-12-31 00:00:00.000000'
                                and ROLE_TYP='CM'
                                and SRC_SYS_ID in (32,36)
                                 ) A ON RPT.APPL_ID=A.APPL_ID
	 LEFT OUTER JOIN (
								SEL APPL_ID,   trim(case when BINGO_RSN_CD_DESC in ('Unknown','In Good Order') then '' else BINGO_RSN_CD_DESC end)  as UW_NIGO_REASON
                                FROM PROD_NBR_VW.NB_BINGO_VW BINGO 
                                 LEFT OUTER JOIN PROD_USIG_CMN_VW.BINGO_RSN_CD_VW RSN
                                on BINGO.BINGO_RSN_CD=RSN.BINGO_RSN_CD
                                where BINGO_TO_DT='9999-12-31 00:00:00.000000'
                                and ROLE_TYP='UW' 
                                and SRC_SYS_ID in (32,36)
                                ) B ON RPT.APPL_ID=B.APPL_ID
    JOIN  PROD_NBR_VW.MRG_ENT_VW C on RPT.MRG_AGENCY_SRC_SYS_PRTY_ID = C.MRG_ENT_NB
WHERE EXTRACT(YEAR FROM BINGO_REVIEW_DATE) >= EXTRACT(YEAR FROM CURRENT_DATE)-2
				AND SRC_SYS in ('TPP','WR')
      			AND BINGO_IND IN  ('BINGO' , 'NIGO')
      			AND CM_BINGO_IND is not null
      			AND UW_BINGO_IND is not null
      			AND CM_BINGO_RVW_DT is not null
      			AND UW_BINGO_RVW_DT is not null
      			);
