


# tail -195 airplane_sales.csv > airplane_sales_trim.csv
# tail -195 airplane_specs.csv > airplane_specs_trim.csv
# tail -195 airplane_perf.csv > airplane_perf_trim.csv
#
#
# sort airplane_sales_trim.csv > airplane_sales_sort.csv
# sort airplane_specs_trim.csv > airplane_specs_sort.csv
# sort airplane_perf_trim.csv > airplane_perf_sort.csv
#
# cat (head -1 airplane_sales.csv) airplane_sales_trim.csv
#
#
#

sort airplane_sales.csv > airplane_sales_sort.csv
sort airplane_specs.csv > airplane_specs_sort.csv
sort airplane_perf.csv > airplane_perf_sort.csv

python3 assignment_09.py > A9_python.out



Rscript assignment_09.R > A9_R.out
