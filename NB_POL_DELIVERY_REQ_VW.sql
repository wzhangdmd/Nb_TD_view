
/*
Naresh Jasthi: 3/27/2015
View created to support policy delivery requirements cognos report. 

*/

REPLACE VIEW PROD_NBR_VW.NB_POL_DELIVERY_REQ_VW
AS LOCKING ROW FOR ACCESS 

(
select		
					Substr('000' , 1 ,3-char_length( trim(both from (cast(MRG_AGENCY_SRC_SYS_PRTY_ID as char(3)))) )) || trim(both from MRG_AGENCY_SRC_SYS_PRTY_ID) as MRG_AGENCY_SRC_SYS_PRTY_ID
					, b.MRG_ENT_NM
					,case when SOLICITING_AGT_TYP_CD = 'CAREER' then 'CAS' else 'CAB' end as SOLICITING_AGT_TYP_CD 
					,case when SOLICITING_AGT_TYP_CD = 'CAREER' then 'CAREER'  when SOLICITING_AGT_TYP_CD = 'BROKER' then 'BROKER' else 'Unknown' end as SOLICITING_AGT_TYP_DESC 
                    ,HLDG_KEY as HLDG_KEY
                    ,ISSUE_DATE
                    ,ISS_RPT_DT
					,case when trim(both from SOLICITING_AGT_FULL_NM) = ','  or  SOLICITING_AGT_FULL_NM is null then 'Unknown' else UPPER(SOLICITING_AGT_FULL_NM) end as SOLICITING_AGT_FULL_NM
					,case when trim(both from SOLICITING_AGT_SRC_SYS_PRTY_ID) = '' or SOLICITING_AGT_SRC_SYS_PRTY_ID is null then null else SOLICITING_AGT_SRC_SYS_PRTY_ID end as SOLICITING_AGT_SRC_SYS_PRTY_ID
					,CURR_STATUS_EVENT_DETAIL
					,UPPER(INS_LAST_NAME)||','||UPPER(INS_FIRST_NAME) as INS_FULL_NAME
					,PROD_ID
					,SRC_SYS
					,REQ_CD_DESC
from	PROD_NBR_VW.NB_RPT_VW join PROD_NBR_VW.MRG_ENT_VW b on NB_RPT_VW.MRG_AGENCY_SRC_SYS_PRTY_ID = b.MRG_ENT_NB
join 
(
select		APPL_ID
				,max(case when row_num mod 10 = 0 then REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 1 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 2 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 3 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 4 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 5 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 6 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 7 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 8 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 9 then ', ' || REQ_CD_DESC else '' end) as REQ_CD_DESC
from
(
select		APPL_ID
				,row_num / 10 as row_num
				,max(case when row_num mod 10 = 0 then REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 1 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 2 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 3 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 4 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 5 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 6 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 7 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 8 then ', ' || REQ_CD_DESC else '' end) ||
				max(case when row_num mod 10 = 9 then ', ' || REQ_CD_DESC else '' end) as REQ_CD_DESC

from
(
select		APPL_ID
				,trim(both from cast(trim(both from REQ_CD_DESC) as varchar(55))) as REQ_CD_DESC
				,row_number() over (partition by APPL_ID order by REQ_CD_DESC)-1 as row_num
FROM PROD_NBR_VW.NB_REQ_VW left outer join PROD_USIG_CMN_VW.REQ_CD_VW on NB_REQ_VW.REQ_CD=REQ_CD_VW.REQ_CD
where 
REQ_TO_DT='9999-12-31 00:00:00.000000'
and REQ_STUS_CD in ('Order','Required') AND ((REQ_CTG = 'DV') OR (NB_REQ_VW.REQ_CD in ('POLR','AMDT','IS','SRR3','LTCR','NAICIL')))
and extract(year from REQ_ORDR_DT) >= 2006
and src_sys_id=36
group by APPL_ID , REQ_CD_DESC
union
select		APPL_ID
				,trim(both from cast(trim(both from REQ_CD_DESC) as varchar(55))) as REQ_CD_DESC
				,row_number() over (partition by APPL_ID order by REQ_CD_DESC)-1 as row_num
FROM PROD_NBR_VW.NB_REQ_VW left outer join PROD_USIG_CMN_VW.REQ_CD_VW on NB_REQ_VW.REQ_CD=REQ_CD_VW.REQ_CD
where 
REQ_TO_DT='9999-12-31 00:00:00.000000'
and REQ_STUS_CD in ('Order','Required') AND ((REQ_CTG = 'DV') OR (NB_REQ_VW.REQ_CD in ('POLR','AMDT','IS','SRR3','LTCR','NAICIL')))
and  REQ_ORDR_DT is null
and src_sys_id=32
group by APPL_ID , REQ_CD_DESC
) Q1
group by 1,2
) Q2
group by 1
) G
on NB_RPT_VW.APPL_ID=G.APPL_ID
where 
SRC_SYS in ('TPP','WR') and
--extract(year from CURR_STATUS_EVENT_DT) >= 2006 and 
CURR_STATUS_EVENT_DETAIL in ('Reported','Issued Reportable')
);
