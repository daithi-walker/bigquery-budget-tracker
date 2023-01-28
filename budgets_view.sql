select  spby.spend_date
,       spby.program
,       spby.spend
,       SUM(spby.spend) OVER (PARTITION BY spby.program, DATE_TRUNC(spby.spend_date, MONTH) ORDER BY spby.program, spby.spend_date ASC) AS monthly_spend_running_total_by_program
,       SUM(spby.spend) OVER (PARTITION BY spby.program, DATE_TRUNC(spby.spend_date, MONTH) ORDER BY spby.program, DATE_TRUNC(spby.spend_date, MONTH) ASC) AS monthly_spend_total_by_program
,       SUM(spby.spend) OVER (PARTITION BY spby.spend_date ORDER BY spby.spend_date ASC) AS daily_spend_total_by_program
,       SUM(spby.spend) OVER (PARTITION BY DATE_TRUNC(spby.spend_date, MONTH) ORDER BY spby.spend_date ASC) AS monthly_spend_running_total_all_programs
,       pb.budget_daily_by_program
,       pb.budget_monthly_running_total_by_program
,       pb.budget_monthly_by_program
,       pb.budget_daily_all_programs
,       pb.budget_monthly_running_total_all_programs
,       pb.budget_monthly_all_programs
FROM    `budgets.daily_spend_by_program` spby
LEFT JOIN `budgets.daily_budgets` pb
ON      pb.budget_date = spby.spend_date
AND     pb.program = spby.program
WHERE 1=1
ORDER BY spby.program, spby.spend_date