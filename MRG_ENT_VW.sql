REPLACE VIEW PROD_NBR_VW.MRG_ENT_VW
AS LOCKING ROW FOR ACCESS 
(
SELECT	DISTINCT 	cast(MRG_ENT_NB as char(3)) as MRG_ENT_NB
										,MRG_ENT_NM
FROM	PROD_NATL_SALES_SUM_VW.ENT_VW
WHERE 
--DSTRB_CH_CD = 'CAS' 				and  /* Changed as per Life Iteration-2 requriements */
MRG_ENT_NB <> '000'
)
;
