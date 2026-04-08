%§3301. Rate of tax

%There is hereby imposed on every employer (as defined in section 3306(a)) for each calendar year an excise tax, with respect to having individuals in his employ, equal to 6 percent of the total wages (as defined in section 3306(b)) paid by such employer during the calendar year with respect to employment (as defined in section 3306(c)).
s3301(Employer,Caly,Wages,Employee,Employment,Tax) :-
    first_day_year(Caly,First_day_year),
    last_day_year(Caly,Last_day_year),
    s3306_a(Employer,Caly),
    total_wages_employer(Employer,Wages,Employee,Employment,First_day_year,Last_day_year),
    Tax is round(0.06*Wages).

total_wages_employer(Employer,Total_wages,Individual_set,Service_list,Start_day,End_day) :-
    % some individual's wage is the sum of that person's wages, capped at $7000 (as per §3301(b)(1))
    findall(
        (Individual,Wages,Service),
        (
            s3306_b(Wages,Remuneration,Service,Employer,Individual,Employer,_,_),
            start_(Remuneration,Remuneration_time),
            is_before(Start_day,Remuneration_time),
            is_before(Remuneration_time,End_day)
        ),
        Individuals_x_wages
    ),
    findall(
        Individual,
        member((Individual,_,_),Individuals_x_wages),
        Individual_list
    ),
    list_to_set(Individual_list,Individual_set),
    findall(
        (Individual,Total_wage),
        (
            member(Individual, Individual_set),
            findall(
                Wage,
                member((Individual,Wage,_),Individuals_x_wages),
                Individual_wages
            ),
            sum_list(Individual_wages,Wage_sum),
            s3306_b_1(Wage_sum,Total_wage)
        ),
        Individuals_x_capped_wages
    ),
    findall(
        Wage,
        (
            member(Individual,Individual_set),
            member((Individual,Wage),Individuals_x_capped_wages)
        ),
        Capped_wages
    ),
    sum_list(Capped_wages,Total_wages),
    findall(
        Service,
        member((_,_,Service),Individuals_x_wages),
        Service_list
    ).
