%§2. Definitions and special rules

%(a) Definition of surviving spouse
s2_a(Taxp,Spouse,Taxy) :-
    s2_a_1(Taxp,Spouse,Previous_marriage,_,_,Taxy),
    \+ s2_a_2(Taxp,Spouse,Previous_marriage,Taxy).

%(1) In general

%For purposes of section 1, the term "surviving spouse" means a taxpayer-
s2_a_1(Taxp,Spouse,Previous_marriage,Household,Dependent,Taxy) :-
    s2_a_1_A(Taxp,Spouse,Previous_marriage,_,Taxy),
    s2_a_1_B(Taxp,Household,Dependent,Taxy).

%(A) whose spouse died during either of the two years immediately preceding the taxable year, and
s2_a_1_A(Taxp,Spouse,Marriage,S5,Taxy) :-
    marriage_(Marriage),
    agent_(Marriage,Taxp),
    agent_(Marriage,Spouse),
    Taxp \== Spouse,
    start_(Marriage,Start_marriage),
    death_(Death),
    agent_(Death,Spouse),
    start_(Death,Time_death),
    split_string(Time_death,"-","",[YS,_,_]),
    atom_number(YS,S5),
    is_before(Start_marriage,Time_death),
    ( % check whether the marriage ended with the death of the spouse
        (
            \+ end_(Marriage,_) 
        );
        (
            end_(Marriage,End_marriage),
            is_before(Time_death,End_marriage)
        )
    ),
    Taxy2 is Taxy-2,
    first_day_year(Taxy2,First_day_year),
    is_before(First_day_year,Time_death),
    Taxy1 is Taxy-1,
    last_day_year(Taxy1,Last_day_year),
    is_before(Time_death,Last_day_year).

%(B) who maintains as his home a household which constitutes for the taxable year the principal place of abode (as a member of such household) of a dependent (i) who (within the meaning of section 152) is a son, stepson, daughter, or stepdaughter of the taxpayer, and (ii) with respect to whom the taxpayer is entitled to a deduction for the taxable year under section 151.

%For purposes of this paragraph, an individual shall be considered as maintaining a household only if over half of the cost of maintaining the household during the taxable year is furnished by such individual.
s2_a_1_B(Taxp,Household,Dependent,Taxy) :-
    % who maintains as his home a household
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    residence_(Taxpayer_residence),
    agent_(Taxpayer_residence,Taxp),
    patient_(Taxpayer_residence,Household),
    start_(Taxpayer_residence,Start_taxpayer_residence),
    is_before(Start_taxpayer_residence,First_day_year),
    (
        (
            \+ end_(Taxpayer_residence,_)
        );
        (
            end_(Taxpayer_residence,End_taxpayer_residence),
            is_before(Last_day_year,End_taxpayer_residence)
        )
    ),
    % which constitutes for the taxable year the principal place of abode (as a member of such household) of...
    residence_(Dependent_residence),
    agent_(Dependent_residence,Dependent),
    patient_(Dependent_residence,Household),
    start_(Dependent_residence,Start_dependent_residence),
    is_before(Start_dependent_residence,First_day_year),
    (
        (
            \+ end_(Dependent_residence,_)
        );
        (
            end_(Dependent_residence,End_dependent_residence),
            is_before(Last_day_year,End_dependent_residence)
        )
    ),
    s7703_b_2(Taxp,Household,_,Taxy), % such individual furnishes over one-half of the cost of maintaining such household during the taxable year
    (
        is_child_of(Dependent,Taxp,Start_dependent,End_dependent);
        is_stepparent_of(Taxp,Dependent,Start_dependent,End_dependent)
    ),
    (
        var(Start_dependent);
        is_before(Start_dependent,First_day_year)
    ),
    (
        var(End_dependent);
        is_before(Last_day_year,End_dependent)
    ),
    s151_c_applies(Taxp,Dependent,Taxy).

%(2) Limitations

%Notwithstanding paragraph (1), for purposes of section 1 a taxpayer shall not be considered to be a surviving spouse-
s2_a_2(Taxp,Spouse,Previous_marriage,Taxy) :-
    s2_a_2_A(Taxp,_,Previous_marriage,_,Taxy);
    \+ s2_a_2_B(Taxp,Spouse,Taxy).

%(A) if the taxpayer has remarried at any time before the close of the taxable year, or
s2_a_2_A(Taxp,Remarriage,Previous_marriage,S31,Taxy) :-
    marriage_(Previous_marriage),
    agent_(Previous_marriage,Taxp),
    start_(Previous_marriage,Start_previous_marriage),
    marriage_(Remarriage),
    agent_(Remarriage,Taxp),
    start_(Remarriage,S31),
    Remarriage \== Previous_marriage,
    is_before(Start_previous_marriage,S31),
    last_day_year(Taxy,Last_day_year),
    is_before(S31,Last_day_year).

%(B) unless, for the taxpayer's taxable year during which his spouse died, a joint return could have been made. A husband and wife may make a single return jointly of income taxes, even though one of the spouses has neither gross income nor deductions, except that no joint return shall be made if either the husband or wife at any time during the taxable year is a nonresident alien.
s2_a_2_B(Taxp,Spouse,Taxy) :-
    \+ ( % no joint return shall be made if either the husband or wife at any time during the taxable year is a nonresident alien
        nonresident_alien_(Someone_is_nra),
        (
            agent_(Someone_is_nra,Taxp);
            agent_(Someone_is_nra,Spouse)
        ),
        (
            (
                \+ start_(Someone_is_nra,_)
            );
            (
                start_(Someone_is_nra,Start_nra),
                last_day_year(Taxy,Last_day_year),
                is_before(Start_nra,Last_day_year)
            )
        ),
        (
            (
                \+ end_(Someone_is_nra,_)
            );
            (
                end_(Someone_is_nra,End_nra),
                first_day_year(Taxy,First_day_year),
                is_before(First_day_year,End_nra)
            )
        )
    ).

%(b) Definition of head of household
s2_b(Taxp,Dependent,Taxy) :- 
    s2_b_1(Taxp,_,Dependent,Taxy),
    % s2_b_2 was incorporated directly into s2_b_1
    \+ s2_b_3(Taxp,Dependent,Taxy).

%(1) In general

%An individual shall be considered a head of a household if, and only if, such individual is not married at the close of his taxable year, is not a surviving spouse (as defined in subsection (a)), and either-
s2_b_1(Taxp,Household,Dependent,Taxy) :-
    \+ ( % "such individual is not married"
        marriage_(Marriage),
        agent_(Marriage,Taxp),
        agent_(Marriage,Spouse),
        Spouse \== Taxp,
        start_(Marriage,Start_marriage),
        last_day_year(Taxy,Last_day_year),
        is_before(Start_marriage,Last_day_year),
        (
            ( % spouse has died
                death_(Spouse_dies),
                agent_(Spouse_dies,Spouse),
                (
                    s2_b_2_C(Taxp,Marriage,Spouse,Taxy); % spouse died during the year
                    (
                        start_(Spouse_dies,Death_time), % spouse died after year considered
                        is_before(Last_day_year,Death_time)
                    )
                )
            );
            ( % spouse has not died
                \+ (
                    death_(Spouse_dies),
                    agent_(Spouse_dies,Spouse)
                ),
                (
                    ( % marriage has ended
                        end_(Marriage,End_marriage),
                        Taxy1 is Taxy+1,
                        first_day_year(Taxy1,First_day_year1),
                        is_before(First_day_year1,End_marriage)
                    );
                    ( % marriage has not ended
                        \+ end_(Marriage,_)
                    )
                )
            )
        ),
        \+ s2_b_2_A(_,_,_,Marriage,Taxy),
        \+ s2_b_2_B(Taxp,Spouse,Taxy)
    ),
    \+ s2_a(Taxp,_,Taxy),
    (
        s2_b_1_A(Taxp,Household,Dependent,Taxy);
        s2_b_1_B(Taxp,Household,Dependent,_,Taxy)
    ).

%(A) maintains as his home a household which constitutes for more than one-half of such taxable year the principal place of abode, as a member of such household, of-
s2_b_1_A(Taxp,Household,Dependent,Taxy) :-
    % who maintains as his home a household
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    residence_(Taxpayer_residence),
    agent_(Taxpayer_residence,Taxp),
    patient_(Taxpayer_residence,Household),
    (
        start_(Taxpayer_residence,Start_taxpayer_residence)
    ->
        is_before(Start_taxpayer_residence,First_day_year)
    ;
        \+ start_(Taxpayer_residence,_)
    ),
    (
        end_(Taxpayer_residence,End_taxpayer_residence)
    ->
        is_before(Last_day_year,End_taxpayer_residence)
    ;
        \+ end_(Taxpayer_residence,_)
    ),
    s7703_b_2(Taxp,Household,_,Taxy), % such individual furnishes over one-half of the cost of maintaining such household during the taxable year
    % which constitutes for more than one-half of such taxable year...
    residence_(Individual_residence),
    agent_(Individual_residence,Dependent),
    patient_(Individual_residence,Household),
    (
        (
            \+ start_(Individual_residence,_),
            Start_individual_residence = First_day_year
        );
        (
            start_(Individual_residence,Start_individual_residence)
        )
    ),
    (
        (
            \+ end_(Individual_residence,_),
            End_individual_residence = Last_day_year
        );
        (
            end_(Individual_residence,End_individual_residence)
        )
    ),
    duration(Start_individual_residence,End_individual_residence,Duration_individual_residence),
    duration(First_day_year,Last_day_year,Taxy_duration),
    Half_year_duration is Taxy_duration / 2,
    Duration_individual_residence >= Half_year_duration,
    (
        s2_b_1_A_i(Taxp,Dependent,Taxy);
        s2_b_1_A_ii(Taxp,Dependent,Taxy)
    ).

%(i) a qualifying child of the individual (as defined in section 152(c)), but not if such child-
s2_b_1_A_i(Taxp,Dependent,Taxy) :-
    s152_c(Dependent,Taxp,Taxy),
    \+ (
        s2_b_1_A_i_I(Dependent,Taxy),
        s2_b_1_A_i_II(Dependent,Taxp,Taxy)
    ).

%(I) is married at the close of the taxpayer's taxable year, and
s2_b_1_A_i_I(Dependent,Taxy) :-
    s7703(Dependent,_,_,Taxy).

%(II) is not a dependent of such individual by reason of section 152(b)(2), or
s2_b_1_A_i_II(Dependent,Taxp,Taxy) :-
    s152_b_2(Dependent,_,Taxp,Taxy).

%(ii) any other person who is a dependent of the taxpayer, if the taxpayer is entitled to a deduction for the taxable year for such person under section 151, or
s2_b_1_A_ii(Taxp,Dependent,Taxy) :-
    s152(Dependent,Taxp,Taxy),
    (
        s151_b_applies(Taxp,Dependent,Taxy);
        s151_c_applies(Taxp,Dependent,Taxy)
    ).

%(B) maintains a household which constitutes for such taxable year the principal place of abode of the father or mother of the taxpayer, if the taxpayer is entitled to a deduction for the taxable year for such father or mother under section 151.
s2_b_1_B(Taxp,Household,Dependent,Deduction,Taxy) :-
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    % which constitutes for the taxable year the principal place of abode (as a member of such household) of...
    residence_(Parent_residence),
    agent_(Parent_residence,Dependent),
    patient_(Parent_residence,Household),
    start_(Parent_residence,Start_dependent_residence),
    is_before(Start_dependent_residence,First_day_year),
    s7703_b_2(Taxp,Household,_,Taxy), % such individual furnishes over one-half of the cost of maintaining such household during the taxable year
    (
        (
            \+ end_(Parent_residence,_)
        );
        (
            end_(Parent_residence,End_dependent_residence),
            is_before(Last_day_year,End_dependent_residence)
        )
    ),
    is_child_of(Taxp,Dependent,Start_child,End_child),
    (
        is_before(Start_child,First_day_year);
        var(Start_child)
    ),
    (
        is_before(Last_day_year,End_child);
        var(End_child)
    ),
    s151_c(Taxp,Dependent,Deduction,Taxy).
%s151_c_applies(Taxp,Parent,Taxy).

%For purposes of this paragraph, an individual shall be considered as maintaining a household only if over half of the cost of maintaining the household during the taxable year is furnished by such individual.

%(2) Determination of status

%Notwithstanding paragraph (1),

%(A) an individual who is legally separated from his spouse under a decree of divorce or of separate maintenance shall not be considered as married;
s2_b_2_A(Taxp,Spouse,S98,Marriage,Taxy) :-
    marriage_(Marriage),
    agent_(Marriage,Taxp),
    agent_(Marriage,Spouse),
    Taxp \== Spouse,
    legal_separation_(S98),
    patient_(S98,Marriage),
    (
        agent_(S98,"decree of divorce");
        agent_(S98,"decree of separate maintenance")
    ),
    start_(S98,Divorce_time),
    last_day_year(Taxy,Last_day_year),
    is_before(Divorce_time,Last_day_year).

%(B) a taxpayer shall be considered as not married at the close of his taxable year if at any time during the taxable year his spouse is a nonresident alien; and
s2_b_2_B(Taxp,Spouse,Taxy) :-
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    marriage_(Marriage),
    agent_(Marriage,Taxp),
    agent_(Marriage,Spouse),
    nonresident_alien_(Spouse_is_nra),
    agent_(Spouse_is_nra,Spouse),
    (
        (
            \+ start_(Spouse_is_nra,_)
        );
        (
            start_(Spouse_is_nra,Start_nra),
            is_before(Start_nra,Last_day_year)
        )
    ),
    (
        (
            \+ end_(Spouse_is_nra,_)
        );
        (
            end_(Spouse_is_nra,Stop_nra),
            is_before(First_day_year,Stop_nra)
        )
    ).

%(C) a taxpayer shall be considered as married at the close of his taxable year if his spouse (other than a spouse described in subparagraph (B)) died during the taxable year.
s2_b_2_C(Taxp,Marriage,Spouse,Taxy) :-
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    marriage_(Marriage),
    agent_(Marriage,Taxp),
    agent_(Marriage,Spouse),
    \+ s2_b_2_B(Taxp,Spouse,Taxy),
    death_(Spouse_dies),
    agent_(Spouse_dies,Spouse),
    start_(Spouse_dies,Time_death),
    (
        (
            \+ end_(Marriage,_)
        );
        (
            end_(Marriage,End_marriage),
            is_before(Time_death,End_marriage)
        )
    ),
    is_before(First_day_year,Time_death),
    is_before(Time_death,Last_day_year).

%(3) Limitations

%Notwithstanding paragraph (1), for purposes of this subtitle a taxpayer shall not be considered to be a head of a household-
s2_b_3(Taxp,Dependent,Taxy) :-
    (
        s2_b_3_A(Taxp,Taxy,_);
        s2_b_3_B(Taxp,Dependent,Taxy)
    ).


%(A) if at any time during the taxable year he is a nonresident alien; or
s2_b_3_A(Taxp,Taxy,S119A) :-
    first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    nonresident_alien_(Taxpayer_is_nra),
    agent_(Taxpayer_is_nra,Taxp),
    (
        (
            \+ start_(Taxpayer_is_nra,_),
            S119A=First_day_year
        );
        (
            start_(Taxpayer_is_nra,Start_nra),
            is_before(Start_nra,Last_day_year),
            S119A=Last_day_year
       )
    ),
    (
        (
            \+ end_(Taxpayer_is_nra,_)
        );
        (
            end_(Taxpayer_is_nra,Stop_nra),
            is_before(First_day_year,Stop_nra),
            earliest([S119A,Stop_nra],S119A)
        )
    ).

%(B) by reason of an individual who would not be a dependent for the taxable year but for subparagraph (H) of section 152(d)(2).
s2_b_3_B(Taxp,Dependent,Taxy) :-
    first_day_year(Taxy,First_day),
    last_day_year(Taxy,Last_day),
    \+ s152_b(Dependent,Taxp,Taxy),
    \+ s152_a_1(Dependent,Taxp,Taxy),
    s152_d_1_B(Dependent,Taxy),
    s152_d_1_D(Dependent,Taxy),
    \+ (
        (
            s152_d_2_A(Dependent,Taxp,Start_relationship,End_relationship);
            s152_d_2_B(Dependent,Taxp,Start_relationship,End_relationship);
            s152_d_2_C(Dependent,Taxp,Start_relationship,End_relationship);
            s152_d_2_D(Dependent,Taxp,Start_relationship,End_relationship);
            s152_d_2_E(Dependent,Taxp,_,Start_relationship,End_relationship);
            s152_d_2_F(Dependent,Taxp,_,Start_relationship,End_relationship);
            s152_d_2_G(Dependent,Taxp,Start_relationship,End_relationship)
        ),
        (
            var(Start_relationship);
            is_before(Start_relationship,First_day)
        ),
        (
            var(End_relationship);
            is_before(End_relationship,Last_day)
        )
    ),
    s152_d_2_H(Dependent,Taxp,Taxy,_,StartH,EndH),
    (
        var(StartH);
        is_before(StartH,First_day)
    ),
    (
        var(EndH);
        is_before(Last_day,EndH)
    ).
