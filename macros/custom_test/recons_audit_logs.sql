{% macro recons_audit_logs(src_relation, tgt_relation) -%}
  INSERT INTO DEMO_DB.AUDIT.RECONS_AUDIT_LOGS
  (src_table_name, tgt_table_name, src_row_count, tgt_row_count, loaded_at)
  SELECT 
      '{{ src_relation }}' AS src_table_name,
      '{{ tgt_relation }}' AS tgt_table_name,
      src.cnt AS src_row_count,
      tgt.cnt AS tgt_row_count,
      CURRENT_TIMESTAMP AS loaded_at
  FROM (
      SELECT COUNT(*) AS cnt FROM {{ src_relation }}
  ) src
  CROSS JOIN (
      SELECT COUNT(*) AS cnt FROM {{ tgt_relation }}
  ) tgt
{%- endmacro %}
