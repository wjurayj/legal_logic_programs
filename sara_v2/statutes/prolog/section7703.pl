%§7703. Determination of marital status
s7703(Taxp,Spouse,Marriage,Taxy) :-
    (
        nonvar(Taxp);
        nonvar(Spouse)
    ),
    Taxp \== Spouse,
	s7703_a(Taxp,Spouse,Marriage,Taxy),
	\+ s7703_b(Taxp,Spouse,Taxy).

%(a) General rule
s7703_a(Taxp,Spouse,Marriage,Taxy) :-
	s7703_a_1(Taxp,Spouse,Marriage,_,Taxy),
	\+ s7703_a_2(Taxp,Spouse,Marriage,_,Taxy).

%(1) the determination of whether an individual is married shall be made as of the close of his taxable year; except that if his spouse dies during his taxable year such determination shall be made as of the time of such death; and
s7703_a_1(Taxp,Spouse,Marriage,S13B,Taxy) :-
	% useful constants
	last_day_year(Taxy,Last_day_year),
	first_day_year(Taxy,First_day_year),
	Taxy1 is Taxy+1,
	first_day_year(Taxy1,First_day_next_year),
	% main body
	marriage_(Marriage),
	agent_(Marriage,Taxp),
	agent_(Marriage,Spouse),
	Taxp\==Spouse,
    (
        (
            \+ start_(Marriage,_),
            Start_marriage = First_day_year
        );
        (
            start_(Marriage,Start_marriage)
        )
    ),
    is_before(Start_marriage,Last_day_year),
	( % if spouse died during taxable year
		(
			death_(Death_spouse),
			agent_(Death_spouse,Spouse),
			start_(Death_spouse,S13B),
			is_before(First_day_year,S13B),
			is_before(S13B,Last_day_year)
		) ->
		( % such determination shall be made as of the time of such death
			is_before(Start_marriage,S13B),
			(
				( % marriage was still ongoing at death
					\+ end_(Marriage,_)
				);
				( % or ended with death
					end_(Marriage,End_time),
					is_before(S13B,End_time)
				)
			)
		);
		( % otherwise, default behavior: check at end of year
			( % determining the end date of a marriage:
				( % if no end date,
					\+ end_(Marriage,_)
				) ->
				(
					( % if spouse died,
						death_(Spouse_dies),
						agent_(Spouse_dies,Spouse)
					) ->
					( % take death date as end time
						start_(Spouse_dies,End_time),
						is_before(First_day_next_year,End_time)
					);
					( % else marriage hasn't ended
						true
					)
				);
				( % else take end date
					end_(Marriage,End_time),
					is_before(First_day_next_year,End_time)
				)
			)
		)
	).

%(2) an individual legally separated from his spouse under a decree of divorce or of separate maintenance shall not be considered as married.
s7703_a_2(Taxp,Spouse,Marriage,S19,Taxy) :-
    marriage_(Marriage),
    agent_(Marriage,Taxp),
    agent_(Marriage,Spouse),
    Taxp\==Spouse,
	legal_separation_(S19),
	patient_(S19,Marriage),
	(
		agent_(S19,"decree of divorce");
		agent_(S19,"decree of separate maintenance")
	),
	start_(S19,Divorce_time),
	last_day_year(Taxy,Last_day_year),
	is_before(Divorce_time,Last_day_year).

%(b) Certain married individuals living apart

%For purposes of those provisions of this title which refer to this subsection, if-
s7703_b(Taxp,Spouse,Taxy) :-
	s7703_b_1(Taxp,Household,_,Taxy), 
	s7703_b_2(Taxp,Household,_,Taxy),
	s7703_b_3(Taxp,Spouse,Household,Taxy).


%(1) an individual who is married (within the meaning of subsection (a)) and who files a separate return maintains as his home a household which constitutes for more than one-half of the taxable year the principal place of abode of a child with respect to whom such individual is entitled to a deduction for the taxable year under section 151,
s7703_b_1(Taxp,Household,Dependent,Taxy) :-
	first_day_year(Taxy,First_day_year),
	last_day_year(Taxy,Last_day_year),
	\+ (
		joint_return_(Joint_return),
		agent_(Joint_return,Taxp),
		start_(Joint_return,First_day_year),
		end_(Joint_return,Last_day_year)
	),
	residence_(Taxp_residence),
	agent_(Taxp_residence,Taxp),
	patient_(Taxp_residence,Household),
	residence_(Child_lives_at_home),
	agent_(Child_lives_at_home,Dependent),
	patient_(Child_lives_at_home,Household),
	start_(Child_lives_at_home,Start_time),
    latest([Start_time,First_day_year],Start),
    (
        (
            \+ end_(Child_lives_at_home,_)
        );
        end_(Child_lives_at_home,End_time)
    ),
    earliest([End_time,Last_day_year],End),
	% now compute time stamp of end minus time stamp of beginning and compare with time stamps of 1/2 of the year 0.
    duration(Start,End,Duration),
    duration(First_day_year,Last_day_year,Taxy_duration),
    Half_year_duration is Taxy_duration / 2,
	Duration >= Half_year_duration,
    s152_a_1(Dependent,Taxp,Taxy).

%(2) such individual furnishes over one-half of the cost of maintaining such household during the taxable year, and
s7703_b_2(Taxp,Household,Cost,Taxy) :-
    findall(
		Payment_amount,
		(
			payment_(Payment),
			residence_(Residence),
			agent_(Payment,Taxp),
			patient_(Residence,Household),
			(
                purpose_(Payment,Residence);
                purpose_(Payment,Household)
            ),
			amount_(Payment,Payment_amount),
			start_(Payment,Payment_time), % assuming it's a single day
			split_string(Payment_time,"-","",[Taxy_payment,_,_]),
			atom_number(Taxy_payment,Taxy_payment_int),
			Taxy==Taxy_payment_int
		),
		Payments_by_individual
	),
	findall(
		Payment_amount,
		(
			payment_(Payment),
			residence_(Residence),
			patient_(Residence,Household),
			(
                purpose_(Payment,Residence);
                purpose_(Payment,Household)
            ),
			amount_(Payment,Payment_amount),
			start_(Payment,Payment_time), % assuming it's a single day
			split_string(Payment_time,"-","",[Taxy_payment,_,_]),
			atom_number(Taxy_payment,Taxy_payment_int),
			Taxy==Taxy_payment_int
		),
		Payments_all
	),
	sum_list(Payments_by_individual,Payment_by_individual),
	sum_list(Payments_all,Cost),
	Cost>0,
	Ratio is Payment_by_individual / Cost,
	Ratio>=rational(0.5).

%(3) during the last 6 months of the taxable year, such individual's spouse is not a member of such household, such individual shall not be considered as married.
s7703_b_3_is_member_of_household(Spouse,Household,Day) :-
    residence_(Spouse_lives_in_household),
    agent_(Spouse_lives_in_household,Spouse),
	patient_(Spouse_lives_in_household,Household),
    start_(Spouse_lives_in_household,Time_start),
    is_before(Time_start,Day),
	(
		(
			\+ end_(Spouse_lives_in_household,_)
		);
		(
			end_(Spouse_lives_in_household,Time_end),
			is_before(Day,Time_end)
		)
	).
    
s7703_b_3(Taxp,Spouse,Household,Taxy) :-
    s7703_a(Taxp,Spouse,_,Taxy),
    findall(
        Day_offset,
        (
            between(2,185,Day_offset),
            date_time_stamp(date(Taxy,7,Day_offset,0,0,0,0,-,-), Stamp),
            format_time(atom(Day), "%Y-%m-%d", Stamp),
            s7703_b_3_is_member_of_household(Spouse,Household,Day)
        ),
        Days_membership
    ),
    length(Days_membership,Num_days),
    Num_days==0.

