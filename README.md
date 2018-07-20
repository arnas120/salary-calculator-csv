# Salary calculator Matlab

The following business logic is in place: 
 
● Staff get their basic monthly pay (salary), plus a bonus

● Basic pay is paid on the last working day of the month (Mon-Fri). So if the last day of January is the 31st, and this is a Saturday, the payment date is Friday the 30th. The same logic applies to Sunday. 

● On the 12th of every month bonuses are paid for the previous month, unless that day is a weekend. In that case, they are paid the first Tuesday after the 12th 
 
Requirements 
 
The application should be CLI (command line) based and output a csv file. 
 
The CSV file should contain the payment dates for the next 12 months. The CSV should contain a column for the month name, a column that contains the base payment date for that month, and a column that contains the bonus payment date. 
