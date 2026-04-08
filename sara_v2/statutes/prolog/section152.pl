%§152. Dependent defined
s152(Dependent,Taxp,Taxy) :-
	\+ ( var(Dependent), var(Taxp) ),
    Dependent\==Taxp,
	\+ s152_b_1(Taxp,_,Taxy), % check that the taxpayer is eligible to have depedents
    s152_a(Dependent,Taxp,Taxy,_,_),
	\+ s152_b_2(Dependent,_,_,Taxy). % check that the dependent is eligible

%(a) In general

%For purposes of this subtitle, the term "dependent" means-
s152_a(Dependent,Taxp,Taxy,Start_relationship,End_relationship) :-
    (
        s152_a_1(Dependent,Taxp,Taxy);
        s152_a_2(Dependent,Taxp,Taxy,Start_relationship,End_relationship)
    ).

%(1) a qualifying child, or
s152_a_1(Dependent,Taxp,Taxy) :-
    s152_c(Dependent,Taxp,Taxy).

%(2) a qualifying relative.
s152_a_2(Dependent,Taxp,Taxy,Start_relationship,End_relationship) :-
    s152_d(Dependent,Taxp,Taxy,Start_relationship,End_relationship).

%(b) Exceptions

%For purposes of this section-
s152_b(Dependent,Taxp,Taxy) :-
    (
        s152_b_1(Taxp,_,Taxy);
        s152_b_2(Dependent,_,_,Taxy)
    ).

%(1) Dependents ineligible

%If an individual is a dependent of a taxpayer for any taxable year of such taxpayer beginning in a calendar year, such individual shall be treated as having no dependents for any taxable year of such individual beginning in such calendar year.
s152_b_1(Taxp,Otaxp,Taxy) :-
    s152(Taxp,Otaxp,Taxy).

%(2) Married dependents

%An individual shall not be treated as a dependent of a taxpayer under subsection (a) if such individual has made a joint return with the individual's spouse for the taxable year beginning in the calendar year in which the taxable year of the taxpayer begins.
s152_b_2(Dependent,S21,Spouse,Taxy) :-
    s7703(Dependent,Spouse,_,Taxy),
    joint_return_(S21),
    agent_(S21,Dependent),
    agent_(S21,Spouse),
    first_day_year(Taxy,First_day_year),
    start_(S21,First_day_year),
    last_day_year(Taxy,Last_day_year),
    end_(S21,Last_day_year).

%(c) Qualifying child

%For purposes of this section-
s152_c(Dependent,Taxp,Taxy) :-
    s152_c_1(Dependent,Taxp,Taxy).

%(1) In general

%The term "qualifying child" means, with respect to any taxpayer for any taxable year, an individual-
s152_c_1(Dependent,Taxp,Taxy) :-
    s152_c_1_A(Dependent,Taxp,Start_relationship,End_relationship),
    s152_c_1_B(Dependent,_,Taxp,Start_relationship,End_relationship,Taxy),
    s152_c_1_C(Dependent,Taxp,Taxy),
    s152_c_1_E(Dependent,_,Taxy).

%(A) who bears a relationship to the taxpayer described in paragraph (2),
s152_c_1_A(Dependent,Taxp,Start_relationship,End_relationship) :-
    s152_c_2(Dependent,Taxp,Start_relationship,End_day),
	(
		(
			death_(Death_taxpayer),
			agent_(Death_taxpayer,Taxp),
			start_(Death_taxpayer,Death_taxpayer_time)
		) -> ( End_t = Death_taxpayer_time ) ; ( End_t = End_day )
	),
	(
		(
			death_(Death_individual),
			agent_(Death_individual,Dependent),
			start_(Death_individual,Death_individual_time)
		) -> ( End_i = Death_individual_time ) ; ( End_i = End_day )
	),
	earliest([End_t,End_i,End_day],End_relationship).

%(B) who has the same principal place of abode as the taxpayer for more than one-half of such taxable year,
s152_c_1_B(Dependent,S38,Taxp,Start_relationship,End_relationship,Taxy) :-
    residence_(Residence_individual),
    agent_(Residence_individual,Dependent),
    patient_(Residence_individual,S38),
    % get first day the Dependent lived at Place_of_abode; if unspecified, take first day of Taxy
	(
		\+ start_(Residence_individual,_)
	->
		first_day_year(Taxy,Start_individual)
	;
		start_(Residence_individual,Start_individual)
	),
    % get last day the Dependent lived at Place_of_abode; if ongoing, take last day of Taxy
	(
		\+ end_(Residence_individual,_)
	->
		last_day_year(Taxy,End_individual)
	;
		end_(Residence_individual,End_individual)
	),
    residence_(Residence_taxpayer),
    agent_(Residence_taxpayer,Taxp),
    patient_(Residence_taxpayer,S38),
    % get first day the Taxp lived at Place_of_abode; if unspecified, take first day of Taxy
	(
		\+ start_(Residence_taxpayer,_)
	->
		first_day_year(Taxy,Start_taxpayer)
	;
		start_(Residence_taxpayer,Start_taxpayer)
	),
    % get last day the Taxp lived at Place_of_abode; if ongoing, take last day of Taxy
	(
		\+ end_(Residence_taxpayer,_)
	->
		last_day_year(Taxy,End_taxpayer)
	;
		end_(Residence_taxpayer,End_taxpayer)
	),
	% now compute overlap of Taxy, time when Taxp resided at Place_of_abode, and Dependent resided at Place_of_abode
    last_day_year(Taxy,Last_day_of_year),
    earliest([End_individual,End_taxpayer,Last_day_of_year,End_relationship],End_day),
    first_day_year(Taxy,First_day_of_year),
    latest([Start_individual,Start_taxpayer,First_day_of_year,Start_relationship],Start_day),
    duration(First_day_of_year,Last_day_of_year,Taxy_duration),
    Half_year_duration is Taxy_duration / 2,
    duration(Start_day,End_day,Duration),
	Duration >= Half_year_duration.

%(C) who meets the age requirements of paragraph (3), and
s152_c_1_C(Dependent,Taxp,Taxy) :-
    s152_c_3(Dependent,Taxp,Taxy).

%(E) who has not filed a joint return (other than only for a claim of refund) with the individual's spouse for the taxable year beginning in the calendar year in which the taxable year of the taxpayer begins.
s152_c_1_E(Dependent,Spouse,Taxy) :-
    \+ (
        s7703(Dependent,Spouse,_,Taxy),
        joint_return_(Joint_return),
        agent_(Joint_return,Dependent),
        agent_(Joint_return,Spouse),
        first_day_year(Taxy,First_day_year),
        start_(Joint_return,First_day_year),
        last_day_year(Taxy,Last_day_year),
        end_(Joint_return,Last_day_year)
    ).

%(2) Relationship

%For purposes of paragraph (1)(A), an individual bears a relationship to the taxpayer described in this paragraph if such individual is-
s152_c_2(Dependent,Taxp,Start_relationship,End_relationship) :-
    s152_c_2_A(Dependent,Taxp,_,Start_relationship,End_relationship);
    s152_c_2_B(Dependent,Taxp,_,Start_relationship,End_relationship).

%(A) a child of the taxpayer or a descendant of such a child, or
s152_c_2_A(Dependent,Taxp,Childc2a,Start_relationship,End_relationship) :-
	is_child_of(Childc2a,Taxp,Start_child,End_child),
	(
		(
			Dependent=Childc2a,
			Start_relationship=Start_child,
			End_relationship=End_child
		);
		(
			Dependent \== Childc2a,
	        is_descendent_of(Dependent,Childc2a,Start_relationship,End_relationship)
		)
	).

%(B) a brother, sister, stepbrother, or stepsister of the taxpayer or a descendant of any such relative.
s152_c_2_B(S65,Taxp,Bsssc2b,Start_relationship,End_relationship) :-
	( % a brother, sister, stepbrother, or stepsister of the taxpayer
		is_sibling_of(Bsssc2b,Taxp,Start_relationship,End_relationship);
		is_stepsibling_of(Bsssc2b,Taxp,Start_relationship,End_relationship)
	),
    (
        S65 == Bsssc2b;
        % or a descendant of any such relative
		is_descendent_of(S65,Bsssc2b,Start_relationship,End_relationship)
    ).

%(3) Age requirements

%For purposes of paragraph (1)(C), an individual meets the requirements of this paragraph if such individual is younger than the taxpayer claiming such individual as a qualifying child and is less than 25 years old at the end of the taxable year.
s152_c_3(Dependent,Taxp,Taxy) :-
    % if Dependent is a descendant of Taxpayer and no dates of birth are specified, I'm going
    % to assume the predicate holds (although there could be exceptions, e.g. adoption).
    % This is to avoid making rules fail just because we didn't specify dates of birth.
    (
        (
            birth_(Individual_is_born),
            agent_(Individual_is_born,Dependent),
            start_(Individual_is_born,Individual_dob),
            birth_(Taxpayer_is_born),
            agent_(Taxpayer_is_born,Taxp),
            start_(Taxpayer_is_born,Taxpayer_dob),
            is_before(Taxpayer_dob,Individual_dob)
        );
        (
            \+ (
                birth_(Someone_is_born),
                (
                    agent_(Someone_is_born,Dependent);
                    agent_(Someone_is_born,Dependent)
                )
            ),
            is_descendent_of(Dependent,Taxp,_,_)
        )
    ),
	% is less than 25 years old at the end of the taxable year.
	(
		birth_(Individual_is_born);
		son_(Individual_is_born);
		daughter_(Individual_is_born)
	),
	agent_(Individual_is_born,Dependent),
	start_(Individual_is_born,Individual_dob),
	last_day_year(Taxy,Last_day_year),
	duration(Individual_dob,Last_day_year,Age_individual),
	Taxy_25 is Taxy+25,
	last_day_year(Taxy_25,Last_day_year_25),
	duration(Last_day_year,Last_day_year_25,Duration_25_years),
	Age_individual =< Duration_25_years.

%(d) Qualifying relative

%For purposes of this section-
s152_d(Dependent,Taxp,Taxy,Start_relationship,End_relationship) :-
    s152_d_1(Dependent,Taxp,Taxy,Start_relationship,End_relationship).

%(1) In general

%The term "qualifying relative" means, with respect to any taxpayer for any taxable year, an individual-
s152_d_1(Dependent,Taxp,Taxy,Start_relationship,End_relationship) :-
    s152_d_1_A(Dependent,Taxp,Taxy,Start_relationship,End_relationship),
    s152_d_1_B(Dependent,Taxy),
    s152_d_1_D(Dependent,Taxy).

%(A) who bears a relationship to the taxpayer described in paragraph (2),
s152_d_1_A(Dependent,Taxp,Taxy,Start_relationship,End_relationship) :-
    s152_d_2(Dependent,Taxp,Taxy,Start_relationship,End_day),
	(
		(
			death_(Death_taxpayer),
			agent_(Death_taxpayer,Taxp),
			start_(Death_taxpayer,Death_taxpayer_time)
		) -> ( End_t = Death_taxpayer_time ) ; ( End_t = End_day )
	),
	(
		(
			death_(Death_individual),
			agent_(Death_individual,Dependent),
			start_(Death_individual,Death_individual_time)
		) -> ( End_i = Death_individual_time ) ; ( End_i = End_day )
	),
	earliest([End_t,End_i,End_day],End_relationship).


%(B) who has no income for the calendar year in which such taxable year begins, and
s152_d_1_B(Dependent,Taxy) :-
    gross_income(Dependent,Taxy,Gross_income),
    Gross_income == 0.

%(D) who is not a qualifying child of such taxpayer or of any other taxpayer for any taxable year beginning in the calendar year in which such taxable year begins.
s152_d_1_D(Dependent,Taxy) :-
    \+ s152_c(Dependent,_,Taxy).

%(2) Relationship
s152_d_2(Dependent,Taxp,Taxy,Start_day,End_day) :-
    (
        s152_d_2_A(Dependent,Taxp,Start_day,End_day);
        s152_d_2_B(Dependent,Taxp,Start_day,End_day);
        s152_d_2_C(Dependent,Taxp,Start_day,End_day);
        s152_d_2_D(Dependent,Taxp,Start_day,End_day);
        s152_d_2_E(Dependent,Taxp,_,Start_day,End_day);
        s152_d_2_F(Dependent,Taxp,_,Start_day,End_day);
        s152_d_2_G(Dependent,Taxp,Start_day,End_day);
        s152_d_2_H(Dependent,Taxp,Taxy,_,Start_day,End_day)
    ).

%For purposes of paragraph (1)(A), an individual bears a relationship to the taxpayer described in this paragraph if the individual is any of the following with respect to the taxpayer:

%(A) A child or a descendant of a child.
s152_d_2_A(Dependent,Taxp,Start_day,End_day) :-
	is_child_of(Child,Taxp,Start_child,End_child),
	(
		(
			Dependent=Child,
			Start_day=Start_child,
			End_day=End_child
		);
		(
			Dependent \== Child,
	        is_descendent_of(Dependent,Child,Start_day,End_day)
		)
	).

%(B) A brother, sister, stepbrother, or stepsister.
s152_d_2_B(Dependent,Taxp,Start_day,End_day) :-
    (
        is_sibling_of(Dependent,Taxp,Start_day,End_day);
        is_stepsibling_of(Dependent,Taxp,Start_day,End_day)
    ).

%(C) The father or mother, or an ancestor of either.
s152_d_2_C(S113,Taxp,Start_day,End_day) :-
	is_descendent_of(Taxp,S113,Start_day,End_day).

%(D) A stepfather or stepmother.
s152_d_2_D(Dependent,Taxp,Start_day,End_day) :-
    is_stepparent_of(Dependent,Taxp,Start_day,End_day).

%(E) A son or daughter of a brother or sister of the taxpayer.
s152_d_2_E(Dependent,Taxp,S121,Start_day,End_day) :-
    is_sibling_of(Taxp,S121,Start_day_sibling,End_day_sibling),
    is_child_of(Dependent,S121,Start_day_child,End_day_child),
    latest([Start_day_sibling,Start_day_child],Start_day),
    earliest([End_day_sibling,End_day_child],End_day).

%(F) A brother or sister of the father or mother of the taxpayer.
s152_d_2_F(Dependent,Taxp,S125,Start_day,End_day) :-
    is_child_of(Taxp,S125,Start_day_child,End_day_child),
    is_sibling_of(S125,Dependent,Start_day_sibling,End_day_sibling),
    latest([Start_day_sibling,Start_day_child],Start_day),
    earliest([End_day_sibling,End_day_child],End_day).

%(G) A son-in-law, daughter-in-law, father-in-law, mother-in-law, brother-in-law, or sister-in-law.
s152_d_2_G(Dependent,Taxp,Start_day,End_day) :-
    (
        is_child_in_law_of(Dependent,Taxp,Start_day,End_day);
        is_parent_in_law_of(Dependent,Taxp,Start_day,End_day);
        is_sibling_in_law_of(Dependent,Taxp,Start_day,End_day)
    ).

%(H) An individual (other than an individual who at any time during the taxable year was the spouse, determined without regard to section 7703, of the taxpayer) who, for the taxable year of the taxpayer, has the same principal place of abode as the taxpayer and is a member of the taxpayer's household.
s152_d_2_H(Dependent,Taxp,Taxy,S143,Start_day,End_day) :-
    Dependent \== Taxp,
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    \+ (
        marriage_(Marriage),
        agent_(Marriage,Dependent),
        agent_(Marriage,Taxp),
        start_(Marriage,Start),
        is_before(Start,Last_day_year),
        (
			end_(Marriage,End)
		->
			is_before(First_day_year,End)
		;
			\+ end_(Marriage,_)
		)
    ),
    residence_(Taxpayer_residence),
    agent_(Taxpayer_residence,Taxp),
    patient_(Taxpayer_residence,S145),
    start_(Taxpayer_residence,Start_taxpayer_residence),
    is_before(Start_taxpayer_residence,First_day_year),
	(
		end_(Taxpayer_residence,End_taxpayer_residence)
	->
		is_before(Last_day_year,End_taxpayer_residence)
	;
		\+ end_(Taxpayer_residence,_)
	),
    residence_(Individual_residence),
    agent_(Individual_residence,Dependent),
    patient_(Individual_residence,S143),
    start_(Individual_residence,Start_individual_residence),
    is_before(Start_individual_residence,First_day_year),
	(
		end_(Individual_residence,End_individual_residence)
	->
		is_before(Last_day_year,End_individual_residence)
	;
		\+ end_(Individual_residence,_)
	),
    latest([Start_taxpayer_residence,Start_individual_residence],Start_day),
    earliest([End_taxpayer_residence,End_individual_residence],End_day),
	S145==S143.
