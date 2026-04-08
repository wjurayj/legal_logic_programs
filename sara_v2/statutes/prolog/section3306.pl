%§3306. Definitions

%(a) Employer
s3306_a(Employer,Caly) :-
	s3306_a_1(Employer,Caly);
	s3306_a_2(Employer,Caly);
	s3306_a_3(Employer,_,_,Caly).

%(1) In general

%The term "employer" means, with respect to any calendar year, any person who-
s3306_a_1(Employer,Caly) :-
	s3306_a_1_A(Employer,Caly,_);
	s3306_a_1_B(Employer,_,_,Caly).

%(A) during the calendar year or the preceding calendar year paid wages of $1,500 or more, or
s3306_a_1_is_wages(Person, Year, Remuneration, Wages) :-
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_),
	start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
    \+ purpose_(Service, "agricultural labor"),
	\+ purpose_(Service, "domestic service").

s3306_a_1_A(Employee,Caly,Wages) :-
	findall(
		Amount,
		(
			s3306_a_1_is_wages(Employee, Caly, Remuneration, Amount);
			(
				Pyear is Caly-1,
				s3306_a_1_is_wages(Employee, Pyear, Remuneration, Amount)
			)
		),
		Wages_list
	),
	sum_list(Wages_list,Wages),
	Wages>=1500.

%(B) on each of some 10 days during the calendar year or during the preceding calendar year, each day being in a different calendar week, employed at least one individual in employment for some portion of the day.
s3306_a_1_is_day_of_employment(Person, Employee, Day) :-
	s3306_c(Service,Person,Employee,Day,_),
    \+ purpose_(Service,"agricultural labor"),
    \+ purpose_(Service,"domestic service"),
    \+ type_(Service,"agricultural labor"),
    \+ type_(Service,"domestic service").

s3306_a_1_B(Employer,Workday,Employee,Caly) :-
    last_day_year(Caly,Last_day_year),
    Year1 is Caly-1,
    first_day_year(Year1,First_day_year1),
	findall(
		(Stamp,Day,Individual),
		(
			s3306_a_1_is_day_of_employment(Employer,Individual,Day),
            is_before(First_day_year1,Day),
            is_before(Day,Last_day_year),
            day_to_stamp(Day,Stamp)
		),
		Stamp_day_individual
	),
    findall(
        Stamp,
        member((Stamp,_,_),Stamp_day_individual),
        Emp_days
    ),
    list_to_set(Emp_days,Emp_days_set),
	length(Emp_days_set,Num_days),
	Num_days>=10,
    findall(
		Week,
		(
			member(Stamp,Emp_days),
			format_time(atom(Week), "%W", Stamp)
		),
		Weeks
	),
	list_to_set(Weeks,Weeks_set),
	length(Weeks_set,Num_weeks),
	Num_weeks>=10,
    findall(
        Day,
        member((_,Day,_),Stamp_day_individual),
        Workday
    ),
    findall(
        Individual,
        member((_,_,Individual),Stamp_day_individual),
        Employee
    ).

%For purposes of this paragraph, there shall not be taken into account any wages paid to, or employment of, an employee performing domestic services referred to in paragraph (3).

%(2) Agricultural labor

%In the case of agricultural labor, the term "employer" means, with respect to any calendar year, any person who-
s3306_a_2(Employer,Caly) :-
	s3306_a_2_A(Employer,Caly,_,_);
	s3306_a_2_B(Employer,_,_,_,_,Caly).

%(A) during any calendar quarter in the calendar year or the preceding calendar year paid wages of $20,000 or more for agricultural labor, or
s3306_a_2_is_wages(Person, Year, Remuneration, Wages, Service) :- 
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_),
    start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
    purpose_(Service, "agricultural labor").

s3306_a_2_A(Employer,Caly,Wages,Service) :-
	findall(
		(Amount,Service_),
		(
			s3306_a_2_is_wages(Employer, Caly, Epay, Amount, Service_);
			(
				Pyear is Caly-1,
				s3306_a_2_is_wages(Employer, Pyear, Epay, Amount, Service_)
			)
		),
		Amount_service
	),
    findall(
        Amount,
        member((Amount,_),Amount_service),
        Wageslist
    ),
    findall(
        Service_,
        member((_,Service_),Amount_service),
        Service
    ),
	sum_list(Wageslist,Wages),
	Wages>=20000.

%(B) on each of some 10 days during the calendar year or during the preceding calendar year, each day being in a different calendar week, employed at least 5 individuals in employment in agricultural labor for some portion of the day.
s3306_a_2_is_day_of_employment(Person,Individuals,Agricultural_labor,Day) :-
	findall(
        (Employee,Service),
        (
            s3306_c(Service,Person,Employee,Day,_),
            (
                purpose_(Service,"agricultural labor");
                type_(Service,"agricultural labor")
            )
        ),
        Employee_x_service
    ),
    findall(
        Employee,
        member((Employee,_),Employee_x_service),
        Employees
    ),
    findall(
        Labor,
        member((_,Labor),Employee_x_service),
        Agricultural_labor
    ),
    list_to_set(Employees,Individuals),
	length(Individuals,Num_employees),
	Num_employees>=5.

s3306_a_2_B(Employer,Workday,Service,Employee,S33A,Caly) :-
    last_day_year(Caly,Last_day_year),
    Year1 is Caly-1,
    first_day_year(Year1,First_day_year1),
	findall(
		(Stamp,Day,Employees,Labor),
		(
            s3306_c(_,Employer,_,Day,_), % narrow down the list of days
			s3306_a_2_is_day_of_employment(Employer,Employees,Labor,Day), % check that 5+ people were employed
            is_before(First_day_year1,Day),
            is_before(Day,Last_day_year),
            day_to_stamp(Day,Stamp)
		),
		Stamp_day_employees_labor
	),
    findall(
        Stamp,
        member((Stamp,_,_,_),Stamp_day_employees_labor),
        Stamp_list
    ),
	list_to_set(Stamp_list,Days_stamp),
	length(Days_stamp,Num_days),
	Num_days>=10,
    findall(
		Week,
		(
			member(Stamp,Stamp_list),
			format_time(atom(Week), "%W", Stamp)
		),
		Weeks
	),
    list_to_set(Weeks,S33A),
	length(S33A,Num_weeks),
	Num_weeks>=10,
    findall(
        Employees,
        member((_,_,Employees,_),Stamp_day_employees_labor),
        Employee
    ),
    findall(
        Labor,
        member((_,_,_,Labor),Stamp_day_employees_labor),
        Service
    ),
    findall(
        Day,
        member((_,Day,_,_),Stamp_day_employees_labor),
        Days_list
    ),
    list_to_set(Days_list,Workday).

%(3) Domestic service

%In the case of domestic service in a private home, local college club, or local chapter of a college fraternity or sorority, the term "employer" means, with respect to any calendar year, any person who during any calendar quarter in the calendar year or the preceding calendar year paid wages in cash of $1,000 or more for such service.
s3306_a_3_is_wages(Person, Year, Remuneration, Service, Wages) :-
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_),
    start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
	(
		(
			\+ means_(Remuneration,_)
		);
		(
			means_(Remuneration,"cash")
		)
	),
	purpose_(Service, "domestic service").

s3306_a_3(Employer,Service,Wages,Caly) :-
	findall(
		(Amount,Service_),
        (
			s3306_a_3_is_wages(Employer, Caly, Epay, Service_, Amount);
			(
				Pyear is Caly-1,
				s3306_a_3_is_wages(Employer, Pyear, Epay, Service_, Amount)
			)
		),
		Amount_service
	),
    findall(
        Amount,
        member((Amount,_),Amount_service),
        Wages_list
    ),
    findall(
        Service_,
        member((_,Service_),Amount_service),
        Service
    ),
	sum_list(Wages_list,Wages),
	Wages>=1000.

%(4) Special rule

%A person treated as an employer under paragraph (3) shall not be treated as an employer with respect to wages paid for any service other than domestic service referred to in paragraph (3) unless such person is treated as an employer under paragraph (1) or (2) with respect to such other service.
% This will be satisfied automatically here since all 3 types of employer are kept separate.
s3306_a_4() :- true. % always true.

%(b) Wages

%For purposes of this chapter, the term "wages" means all remuneration for employment, including the cash value of all remuneration (including benefits) paid in any medium other than cash; except that such term shall not include-
s3306_b(Wages,Remuneration,Employment,Payer,Payee,Employer,Employee,Medium) :-
	payment_(Remuneration),
    (
        (\+ means_(Remuneration,_));
        means_(Remuneration,Medium)
    ),
    agent_(Remuneration,Payer),
    (
        (
            patient_(Remuneration,Payee),
            \+ plan_(Payee)
        );
        (
            patient_(Remuneration,Plan),
            plan_(Plan),
            beneficiary_(Plan,Payee)
        )
    ),
	service_(Employment),
    agent_(Employment,Employee),
    patient_(Employment,Employer),
	purpose_(Remuneration,Employment),
    end_(Employment,End_service),
	split_string(End_service,"-","",[Year_s,_,_]),
	atom_number(Year_s,Year),
	s3306_c(Employment,_,_,_,Year),
	amount_(Remuneration,Wages_before),
    s3306_b_1(Wages_before,Wages),
	\+ s3306_b_2(Remuneration,Employment,Payer,Payee,_,Plan),
    \+ s3306_b_7(Remuneration,Employment,Payer,Payee,_,_),
	\+ s3306_b_10(Remuneration,Employment,Payer,Payee,_,Plan),
	\+ s3306_b_11(Remuneration,Employment,_),
    \+ s3306_b_15(Remuneration,Employer,Payee,Employee,_).

%(1) that part of the remuneration which, after remuneration (other than remuneration referred to in the succeeding paragraphs of this subsection) equal to $7,000 with respect to employment has been paid to an individual by an employer during any calendar year, is paid to such individual by such employer during such calendar year;
s3306_b_1(Remuneration,Remuneration2) :-
    Remuneration2 is min(7000,Remuneration).

%(2) the amount of any payment (including any amount paid by an employer for insurance or annuities, or into a fund, to provide for any such payment) made to, or on behalf of, an employee or any of his dependents under a plan or system established by an employer which makes provision for his employees generally (or for his employees generally and their dependents) or for a class or classes of his employees (or for a class or classes of his employees and their dependents), on account of-
s3306_b_2(Remuneration,Service,Employer,Employee,Payee,Plan) :-
	s3306_c(Service,Employer,Employee,_,_),
	payment_(Remuneration),
	agent_(Remuneration,Employer),
	plan_(Plan), % existence of the plan
	beneficiary_(Plan,Payee),
	(
		Employee==Payee;
        s152(Payee,Employee,_)
	),
	(
		s3306_b_2_A(Plan);
		s3306_b_2_C(Plan)
	),
	(   % payment into a fund
		patient_(Remuneration,Plan);
		% payment using the fund
		(
			means_(Remuneration,Plan),
			patient_(Remuneration,Payee)
		)
	).

%(A) sickness or accident disability, or
s3306_b_2_A(Plan) :-
	purpose_(Plan,"make provisions for employees in case of sickness");
	purpose_(Plan,"make provisions for employees in case of accident disability").

%(C) death;
s3306_b_2_C(Plan) :-
	purpose_(Plan,"make provisions for employees in case of death").

%(7) remuneration paid in any medium other than cash to an employee for service not in the course of the employer's trade or business;
s3306_b_7(Remuneration,Service,Employer,Employee,Medium,S92) :-
	s3306_c(Service,Employer,Employee,_,_),
	means_(Remuneration,Medium),
	Medium\=="cash",
    business_(Employers_business),
	agent_(Employers_business,Employer),
	type_(Employers_business,S92),
    type_(Service,Type_service),
	S92 \== Type_service.

%(10) any payment or series of payments by an employer to an employee or any of his dependents which is paid-
s3306_b_10(Remuneration,Service,Employer,Employee,Payee,Plan) :-
	s3306_c(Service,Employer,Employee,_,_),
    start_(Remuneration,Remuneration_day),
	split_string(Remuneration_day,"-","",[Year,_,_]),
	atom_number(Year,Year_int),
	agent_(Remuneration,Employer),
	patient_(Remuneration,Payee),
	(
		Employee==Payee;
		(
			s152(Employee,Any_of_his_dependents,Year_int),
			Any_of_his_dependents==Payee
		)
	),
	s3306_b_10_A(Remuneration,Service,Employee,Employer,_,_),
    s3306_b_10_B(Employer,Remuneration,Plan).

%(A) upon or after the termination of an employee's employment relationship because of (i) death, or (ii) retirement for disability, and
s3306_b_10_A(Remuneration,Employment,Employee,Employer,S101,S105) :-
	start_(Remuneration,Start_remuneration),
	termination_(S101),
    agent_(S101,Employer),
	patient_(S101,Employment),
	(start_(S101,Start_termination); end_(Employment,Start_termination)),
    is_before(Start_termination,Start_remuneration),
	reason_(S101,S105),
	(disability_(S105); death_(S105)),
	agent_(S105,Employee).

%(B) under a plan established by the employer which makes provision for his employees generally or a class or classes of his employees (or for such employees or class or classes of employees and their dependents),
s3306_b_10_B(Employer,Remuneration,Plan) :-
	means_(Remuneration,Plan),
	plan_(Plan),
	agent_(Plan,Employer),
    purpose_(Plan,"make provisions for employees or dependents").

%other than any such payment or series of payments which would have been paid if the employee's employment relationship had not been so terminated;

%(11) remuneration for agricultural labor paid in any medium other than cash;
s3306_b_11(Remuneration,Service,Medium) :-
    service_(Service),
	purpose_(Service,"agricultural labor"),
	patient_(Service,Employer),
	agent_(Service,Employee),
    agent_(Remuneration,Employer),
	patient_(Remuneration,Employee),
	purpose_(Remuneration,Service),
	means_(Remuneration,Medium),
    Medium\=="cash".

%(15) any payment made by an employer to a survivor or the estate of a former employee after the calendar year in which such employee died;
s3306_b_15(Remuneration,Employer,Payee,Employee,Caly) :-
    s3306_c(_,Employer,Employee,_,_),
	agent_(Remuneration,Employer),
	patient_(Remuneration,Payee),
	start_(Remuneration,Start_remuneration),
	death_(Edeath),
	agent_(Edeath,Employee),
	start_(Edeath,Time_death),
    marriage_(Emar),
	agent_(Emar,Employee),
	agent_(Emar,Payee),
	(\+ end_(Emar,_); end_(Emar,Time_death)),
    split_string(Start_remuneration,"-","",[Year_remuneration,_,_]),
	split_string(Time_death,"-","",[Caly,_,_]),
	Year_remuneration@>Caly.

%(c) Employment

%For purposes of this chapter, the term "employment" means any service, of whatever nature,

s3306_c(Service,Employer,Employee,Workday,Caly) :-
	service_(Service),
    (
        (
            var(Workday)
        );
        (
            nonvar(Workday),
            split_string(Workday,"-","",[Day_y,_,_]),
            atom_number(Day_y,Caly)
        )
    ),
    ( 
        s3306_c_A(Service,Employer,Employee);
        s3306_c_B(Service,Employer,Employee,_)
	),
	\+ s3306_c_1(Service,Caly),
	\+ s3306_c_2(Service,_,Caly), 
	\+ s3306_c_5(Service,Employer,Employee,Workday),
	\+ s3306_c_6(Service),
	\+ s3306_c_7(Service,_),
	\+ s3306_c_10(Service,Employer,Employee,Workday),
	\+ s3306_c_11(Service,Employer),
	\+ s3306_c_13(Service,Employer,Employee,Workday),
	\+ s3306_c_16(Service,Employer),
	\+ s3306_c_21(Service,Employee,_,Workday).

%(A) performed by an employee for the person employing him, irrespective of the citizenship or residence of either, within the United States, and
s3306_c_A(Service,Employer,Employee) :-
	agent_(Service,Employee),
	patient_(Service,Employer), 
    (
        location_(Service,Geographical_location);
        ( % by default, assume it's in the US
            \+ location_(Service,_),
            Geographical_location = "USA"
        )
    ),
    (
        (
            country_(Geographical_location,Country),
            Country=="USA"
        );
        (
            \+ country_(Geographical_location,_),
            Geographical_location=="USA"
        )
    ).

%(B) performed outside the United States (except in a contiguous country with which the United States has an agreement relating to unemployment compensation) by a citizen of the United States as an employee of an American employer, except-
s3306_c_B(Service,Employer,Employee,Location) :-
	agent_(Service, Employee),
	patient_(Service, Employer),
	(
        (
            country_(Location,Country),
            Country\=="USA"
        );
        (
            \+ country_(Location,_),
            Location\=="USA"
        )
    ),
	\+ (
		unemployment_compensation_agreement_(Agreement),
		agent_(Agreement,"USA"),
		agent_(Agreement,Location)
	),
    american_employer_(Employer_is_american_employer),
    agent_(Employer_is_american_employer, Employer),
	citizenship_(Employee_is_american),
	agent_(Employee_is_american,Employee),
    patient_(Employee_is_american,"USA").

%(1) agricultural labor unless-
s3306_c_1(Service,Caly) :-
	(
		purpose_(Service,"agricultural labor");
        type_(Service,"agricultural labor")
	),
	\+ (
		s3306_c_1_A(Service,_,Caly),
		s3306_c_1_B(Service,_)
	).

%(A) such labor is performed for a person who-
s3306_c_1_A(Service,Employer,Caly) :-
    service_(Service),
	patient_(Service,Employer),
    nonvar(Caly),
	(
		s3306_c_1_A_i(Employer,_,_,_,Caly);
		s3306_c_1_A_ii(Employer,_,_,_,_,Caly)
	).

%(i) during the calendar year or the preceding calendar year paid remuneration in cash of $20,000 or more to individuals employed in agricultural labor (including labor performed by an alien referred to in subparagraph (B)), or
s3306_c_1_A_i(Employer,Remuneration,Employee,Service,Caly) :-
    last_day_year(Caly,Last_day_year),
    Year1 is Caly-1,
    first_day_year(Year1,First_day_year),
    findall(
        (Amount,Employee_,Service_),
        (
            payment_(Payment),
            agent_(Payment,Employer),
            patient_(Payment,Employee_),
            service_(Service_),
            agent_(Service_,Employee_),
            patient_(Service_,Employer),
            (
                purpose_(Service_,"agricultural labor");
                type_(Service_,"agricultural labor")
            ),
            purpose_(Payment,Service_),
            amount_(Payment,Amount),
            start_(Payment,Payment_time),
            is_before(First_day_year,Payment_time),
            is_before(Payment_time,Last_day_year),
            (
                (
                    \+ means_(Payment,_)
                );
                means_(Payment,"cash")
            )
        ),
        Amounts_employee_service
    ),
    findall(
        Amount,
        member((Amount,_,_),Amounts_employee_service),
        Amounts
    ),
    sum_list(Amounts,Remuneration),
    Remuneration >= 20000,
    findall(
        Individual,
        member((_,Individual,_),Amounts_employee_service),
        Employee
    ),
    findall(
        Service_,
        member((_,_,Service_),Amounts_employee_service),
        Service
    ).

%(ii) on each of some 10 days during the calendar year or the preceding calendar year, each day being in a different calendar week, employed in agricultural labor (including labor performed by an alien referred to in subparagraph (B)) for some portion of the day (whether or not at the same moment of time) 5 or more individuals; and
s3306_c_1_A_ii(Employer,Workday,Service,Employee,S156,Caly) :-
	s3306_a_2_B(Employer,Workday,Service,Employee,S156,Caly).

%(B) such labor is not agricultural labor performed by an individual who is an alien admitted to the United States to perform agricultural labor.
s3306_c_1_B(Service,Employee) :-
	\+ (
	    (
			type_(Service,"agricultural labor");
			purpose_(Service,"agricultural labor")
		),
		citizenship_(Employee_citizenship),
		agent_(Employee_citizenship,Employee),
		patient_(Employee_citizenship,Country),
		Country \== "USA",
		migration_(Employee_migration),
		agent_(Employee_migration,Employee),
		destination_(Employee_migration,"USA"),
		purpose_(Employee_migration,"agricultural labor")
	).

%(2) domestic service in a private home, local college club, or local chapter of a college fraternity or sorority unless performed for a person who paid cash remuneration of $1,000 or more to individuals employed in such domestic service in any calendar quarter in the calendar year or the preceding calendar year;
s3306_c_2(Service,Location,Caly) :-
	(
		type_(Service,"domestic service");
		purpose_(Service,"domestic service")
	),
    patient_(Service,Person),
    location_(Service,Location),
	(
		Location=="private home";
		Location=="local college club";
		Location=="local chapter of a college fraternity";
		Location=="local chapter of a college sorority"
	),
	\+ s3306_a_3(Person,_,_,Caly).

% (5) 
s3306_c_5(Service,Employer,Employee,Workday) :-
    s3306_c_5_A(Service,Employee,Employer,Workday);
    s3306_c_5_B(Service,Employee,Employer,Workday).

% (A) service performed by an individual in the employ of his son, daughter, or spouse;
s3306_c_5_A(Service,Employee,Employer,Workday) :-
	service_(Service),
	agent_(Service,Employee),
	patient_(Service,Employer),
    (
        (
            is_child_of(Employer,Employee,_,_)
        );
        (
            marriage_(Marriage),
            agent_(Marriage,Employer),
            agent_(Marriage,Employee),
            Employer\==Employee,
            start_(Marriage,Time_start),
            is_before(Time_start,Workday),
            (
                (
                    \+ end_(Marriage,_)
                );
                (
                    end_(Marriage,Time_end),
                    is_before(Workday,Time_end)
                )
            )
        )
    ).

% (B) service performed by a child under the age of 21 in the employ of his father or mother;
s3306_c_5_B(Service,Employee,Employer,Workday) :-
    service_(Service),
	agent_(Service,Employee),
    patient_(Service,Employer),
    (
        is_child_of(Employee,Employer,_,_),
        birth_(Birth_employee),
        agent_(Birth_employee,Employee),
        start_(Birth_employee,Date_of_birth),
        split_string(Date_of_birth,"-","",[Dob_y,Dob_m,Dob_d]),
        Day_offset is Dob_d+7671,
        date_time_stamp(date(Dob_y,Dob_m,Day_offset,0,0,0,0,-,-), Stamp_21),
        split_string(Workday,"-","",[Year,Month,Day1]),
        date_time_stamp(date(Year,Month,Day1,0,0,0,0,-,-), Stamp_day),
        Stamp_21>Stamp_day
    ).

%(6) service performed in the employ of the United States Government
s3306_c_6(Service) :-
	patient_(Service,Employer),
	Employer=="United States Government".

%(7) service performed in the employ of a State, or any political subdivision thereof.
s3306_c_7(Service,Employer) :-
	patient_(Service,Employer),
	atom_prefix(Employer,"State of ").

%(10)
s3306_c_10(Service,Employer,Employee,Workday) :-
	s3306_c_10_A(Service,Employer,Employee,Workday);
	s3306_c_10_B(Service,Employer,Employee,Workday).

%(A) service performed in the employ of a school, college, or university, if such service is performed
s3306_c_10_A(Service,Employer,Employee,Workday) :-
	patient_(Service,Employer),
    agent_(Service,Employee),
	educational_institution_(Employer_is_an_educational_institution),
	agent_(Employer_is_an_educational_institution,Employer),
    s3306_c_10_A_i(Student,Employer,Workday),
	(
		Employee==Student;
		s3306_c_10_A_ii(Employee,Student,Workday)
	).

%(i) by a student who is enrolled and is regularly attending classes at such school, college, or university, or
s3306_c_10_A_i(Student,Employer,Workday) :-
	enrollment_(Student_is_enrolled),
	agent_(Student_is_enrolled,Student),
	patient_(Student_is_enrolled,Employer),
	start_(Student_is_enrolled,Start_enrollment),
	attending_classes_(Student_attends_classes),
	agent_(Student_attends_classes,Student),
	location_(Student_attends_classes,Employer),
	start_(Student_attends_classes,Start_attendance),
	is_before(Start_enrollment,Workday),
	is_before(Start_attendance,Workday),
	(
		(
			\+ end_(Student_is_enrolled,_)
		);
		(
			end_(Student_is_enrolled,Stop_enrollment),
			is_before(Workday,Stop_enrollment)
		)
	),
	(
		(
			\+ end_(Student_attends_classes,_)
		);
		(
			end_(Student_attends_classes,Stop_attendance),
			is_before(Workday,Stop_attendance)
		)
	).

%(ii) by the spouse of such a student, or
s3306_c_10_A_ii(Spouse,Student,Workday) :-
    split_string(Workday,"-","",[YS,_,_]),
    atom_number(YS,Year),
    s7703(Student,Spouse,Marriage,Year),
	(
		(
			\+ start_(Marriage,_)
		);
		(
			start_(Marriage,Start_marriage),
			is_before(Start_marriage,Workday)
		)
	),
	(
		(
			\+ end_(Marriage,_)
		);
		(
			end_(Marriage,End_marriage),
			is_before(Workday,End_marriage)
		)
	),
	s3306_c_10_A_i(Spouse,_,Workday).

%(B) service performed in the employ of a hospital, if such service is performed by a patient of such hospital;
s3306_c_10_B(Service,Employer,Employee,Workday) :-
    service_(Service),
	patient_(Service,Employer),
	agent_(Service,Employee),
	hospital_(Employer_is_hospital),
	agent_(Employer_is_hospital,Employer),
	medical_patient_(Employee_is_medical_patient),
	agent_(Employee_is_medical_patient,Employee),
	patient_(Employee_is_medical_patient,Employer),
	start_(Employee_is_medical_patient,Start_patient),
	is_before(Start_patient,Workday),
	(
		(
			\+ end_(Employee_is_medical_patient,_)
		);
		(
			end_(Employee_is_medical_patient,End_patient),
			is_before(Workday,End_patient)
		)
	).

%(11) service performed in the employ of a foreign government (including service as a consular or other officer or employee or a nondiplomatic representative);
s3306_c_11(Service,Employer) :-
    service_(Service),
	patient_(Service,Employer),
	sub_atom(Employer,_,11,0,Suffix),
	Suffix==' Government',
	Employer\=="United States Government".

%(13) service performed as a student nurse in the employ of a hospital or a nurses' training school by an individual who is enrolled and is regularly attending classes in a nurses' training school;
s3306_c_13(Service,Employer,Employee,Workday) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	(
        nurses_training_school_(Employer_is_hospital_or_nurses_training_school);
        hospital_(Employer_is_hospital_or_nurses_training_school)
    ),
	agent_(Employer_is_hospital_or_nurses_training_school,Employer),
    nurses_training_school_(Isa_nurses_training_school),
    agent_(Isa_nurses_training_school,Nurses_training_school),
	enrollment_(Student_is_enrolled),
	agent_(Student_is_enrolled,Employee),
	patient_(Student_is_enrolled,Nurses_training_school),
	start_(Student_is_enrolled,Start_enrollment),
	attending_classes_(Student_attends_classes),
	agent_(Student_attends_classes,Employee),
	location_(Student_attends_classes,Nurses_training_school),
	start_(Student_attends_classes,Start_attendance),
	is_before(Start_enrollment,Workday),
	is_before(Start_attendance,Workday),
	(
		(
			\+ end_(Student_is_enrolled,_)
		);
		(
			end_(Student_is_enrolled,Stop_enrollment),
			is_before(Workday,Stop_enrollment)
		)
	),
	(
		(
			\+ end_(Student_attends_classes,_)
		);
		(
			end_(Student_attends_classes,Stop_attendance),
			is_before(Workday,Stop_attendance)
		)
	).

%(16) service performed in the employ of an international organization;
s3306_c_16(Service,Employer) :-
    service_(Service),
	patient_(Service,Employer),
	international_organization_(Employer_is_international_organization),
	agent_(Employer_is_international_organization,Employer).

%(21) service performed by a person committed to a penal institution.
s3306_c_21(Service,Employee,S235,Workday) :-
	agent_(Service,Employee),
	penal_institution_(Jail_is_a_penal_institution),
	agent_(Jail_is_a_penal_institution,S235),
	incarceration_(Person_goes_to_jail),
	agent_(Person_goes_to_jail,Employee),
	patient_(Person_goes_to_jail,S235),
	start_(Person_goes_to_jail,Start_incarceration),
	is_before(Start_incarceration,Workday),
	(
		(
			\+ end_(Person_goes_to_jail,_)
		);
		(
			end_(Person_goes_to_jail,End_incarceration),
			is_before(Workday,End_incarceration)
		)
	).
