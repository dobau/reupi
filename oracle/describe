SELECT 
a.owner "owner", 
a.table_name "Tabela", 
a.column_name "Name", 
a.nullable "Null?",
concat(concat(concat(a.data_type,'('),a.data_length),')') "Type",
b.comments
FROM all_tab_columns a
left join all_col_comments b on (a.owner = b.owner and a.table_name = b.table_name and a.column_name = b.column_name)
WHERE upper(a.table_name)IN ('TABELA')
