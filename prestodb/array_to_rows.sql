select item
  from (
    select ARRAY ['a', 'abcd', 'abc'] items
  )
  CROSS JOIN UNNEST(items) AS items(item);
