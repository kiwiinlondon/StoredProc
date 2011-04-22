for %%f in (*.sql) do osql -E -S "SQL02" -d Keeley -i%%f
