%§151. Allowance of deductions for personal exemptions
s151(Taxp,S2,Person_list,Exemptions_list,Taxy) :-
	first_day_year(Taxy,First_day_year),
    last_day_year(Taxy,Last_day_year),
    (
        ( % if the individual is filing a joint return with his spouse, sum both incomes
            s7703(Taxp,Spouse,_,Taxy),
            joint_return_(Joint_return),
            agent_(Joint_return,Taxp),
            agent_(Joint_return,Spouse),
            start_(Joint_return,First_day_year),
            end_(Joint_return,Last_day_year),
            s151_individual(Taxp,Total_ex_taxpayer,Indiv_list_taxpayer,Ex_list_taxpayer,Taxy),
            s151_individual(Spouse,Total_ex_spouse,Indiv_list_spouse,Ex_list_spouse,Taxy),
            S2 is Total_ex_taxpayer+Total_ex_spouse,
            append(Indiv_list_taxpayer,Indiv_list_spouse,Person_list),
            append(Ex_list_taxpayer,Ex_list_spouse,Exemptions_list)
        );
        ( % otherwise, it's just the individual's income
            \+ (
                s7703(Taxp,Spouse,_,Taxy),
                joint_return_(Joint_return),
                agent_(Joint_return,Taxp),
                agent_(Joint_return,Spouse),
                start_(Joint_return,First_day_year),
                end_(Joint_return,Last_day_year)
            ),
            s151_individual(Taxp,S2,Person_list,Exemptions_list,Taxy)
        )
    ).

s151_individual(Taxp,S2,Person_list,Exemptions_list,Taxy) :-
    s151_b(Taxp,Exemption_amount_self,Taxy),
    findall(
        (Person,Exemption),
        s151_b(Taxp,Person,Exemption,Taxy),
        List_b
    ),
    append([(Taxp,Exemption_amount_self)],List_b,List_b_2),
    list_to_set(List_b_2,Set_b),
    findall(
        (Person,Exemption),
        s151_c(Taxp,Person,Exemption,Taxy),
        List_c
    ),
    list_to_set(List_c,Set_c),
    append(Set_b,Set_c,List_all_exemptions),
    findall(
        Person,
        member((Person,_),List_all_exemptions),
        Person_list
    ),
    findall(
        Exemption,
        member((_,Exemption),List_all_exemptions),
        Exemptions_list
    ),
    sum_list(Exemptions_list,S2).

%(a) Allowance of deductions

%In the case of an individual, the exemptions provided by this section shall be allowed as deductions in computing taxable income.
s151_a(Taxp,S2,Taxy) :- % simpler interface
    s151(Taxp,S2,_,_,Taxy).

%(b) Taxpayer and spouse

%An exemption of the exemption amount for the taxpayer; and an additional exemption of the exemption amount for the spouse of the taxpayer if a joint return is not made by the taxpayer and his spouse, and if the spouse, for the calendar year in which the taxable year of the taxpayer begins, has no gross income and is not the dependent of another taxpayer.
s151_b_applies(_,_). % defining these auxiliary functions allows to test whether "a deduction under this section is allowable" without going into an infinite loop (b) -> (d) -> (b)...
s151_b_applies(Taxp,Spouse,Taxy) :-
    s7703(Taxp,Spouse,_,Taxy),
    \+ ( % if a joint return is not made by the taxpayer and his spouse
       joint_return_(Joint_return),
       agent_(Joint_return,Taxp),
       agent_(Joint_return,Spouse),
       first_day_year(Taxy,First_day_year),
       start_(Joint_return,First_day_year),
       last_day_year(Taxy,Last_day_year),
       end_(Joint_return,Last_day_year)
    ),
    \+ s152(Spouse,_,Taxy), % if the spouse is not the dependent of another taxpayer
    gross_income(Spouse,Taxy,0). % if the spouse has no gross income

s151_b(Taxp,Ea,Taxy) :- % An exemption of the exemption amount for the taxpayer
    s151_b_applies(Taxp,Taxy),
    s151_d(Taxp,Ea,Taxy).

s151_b(Taxp,Spouse,Ea,Taxy) :- % and an additional exemption of the exemption amount for the spouse
    s151_b_applies(Taxp,Spouse,Taxy),
    s151_d(Taxp,Ea,Taxy).

%(c) Additional exemption for dependents

%An exemption of the exemption amount for each individual who is a dependent (as defined in section 152) of the taxpayer for the taxable year.
s151_c_applies(Taxp,S24A,Taxy) :- % defining this auxiliary function allows to test whether "a deduction under this section is allowable" without going into an inf loop (c) -> (d) -> (c)...
    s152(S24A,Taxp,Taxy).

s151_c(Taxp,S24A,Ea,Taxy) :-
    s151_c_applies(Taxp,S24A,Taxy),
    s151_d(Taxp,Ea,Taxy).

%(d) Exemption amount

%For purposes of this section-
s151_d(Taxp,Ea,Taxy) :-
    (
        ( % either the exemption amount is disallowed or it's one of those years (both set the exemption to 0)
            s151_d_2(Taxp,_,Ea,Taxy);
            s151_d_5(Ea,Taxy)
        );
        ( % or it isn't
            \+ s151_d_2(Taxp,_,_,Taxy),
            \+ s151_d_5(_,Taxy),
            s151_d_1(Exemption_in),
            (
                s151_d_3(Taxp,Exemption_in,Ea,Taxy); % and Exemption_amount might have to be reduced
                (
                    \+ s151_d_3(Taxp,Exemption_in,Ea,Taxy),
                    Ea = Exemption_in
                )
            )
        )
    ).

%(1) In general

%Except as otherwise provided in this subsection, the term "exemption amount" means $2,000.
s151_d_1(Ea) :-
    Ea is 2000.

%(2) Exemption amount disallowed in case of certain dependents

%In the case of an individual with respect to whom a deduction under this section is allowable to another taxpayer for a taxable year beginning in the calendar year in which the individual's taxable year begins, the exemption amount applicable to such individual for such individual's taxable year shall be zero.
s151_d_2(Taxp,Otaxp,Ea,Taxy) :-
    Taxp \== Otaxp,
    (
        s151_b_applies(Otaxp,Taxp,Taxy);
        s151_c_applies(Otaxp,Taxp,Taxy)
    ),
    Ea is 0.

%(3) Phaseout
s151_d_3(Taxp,Exemption_amount_in,Ea,Taxy) :-
    s151_d_3_A(Taxp,_,_,_,Exemption_amount_in,Ea,Taxy).

%(A) In general

%In the case of any taxpayer whose adjusted gross income for the taxable year exceeds the applicable amount in effect under section 68(b), the exemption amount shall be reduced by the applicable percentage.
s151_d_3_A(Taxp,Agi,Aa,Ap,Exemption_amount_in,Ea,Taxy) :-
    gross_income(Taxp,Taxy,Agi),
    !,
    s68_b(Taxp,Aa,Taxy),
    !,
    Agi>Aa,
    s151_d_3_B(Ap,Taxp,Agi,Taxy,_),
    Reduction_amount is round( (Exemption_amount_in*Ap) / 100),
    Ea is max(Exemption_amount_in-Reduction_amount,0).

%(B) Applicable percentage

%For purposes of subparagraph (A), the term "applicable percentage" means 2 percentage points for each $2,500 (or fraction thereof) by which the taxpayer's adjusted gross income for the taxable year exceeds the applicable amount in effect under section 68(b). In the case of a married individual filing a separate return, the preceding sentence shall be applied by substituting "$1,250" for "$2,500". In no event shall the applicable percentage exceed 100 percent.
s151_d_3_B(Ap,Taxp,Agi,Taxy,Aa) :-
    gross_income(Taxp,Taxy,Agi),
    s68_b(Taxp,Aa,Taxy),
    Difference is max(Agi-Aa,0),
    (
        ( % In the case of a married individual filing a separate return
            s7703(Taxp,Spouse,_,Taxy),
            \+ ( % if a joint return is not made by the taxpayer and his spouse
               joint_return_(Joint_return),
               agent_(Joint_return,Taxp),
               agent_(Joint_return,Spouse),
               first_day_year(Taxy,First_day_year),
               start_(Joint_return,First_day_year),
               last_day_year(Taxy,Last_day_year),
               end_(Joint_return,Last_day_year)
            )
        ) ->
        (
            Number is 2*ceil(Difference/1250)
        );
        (
            Number is 2*ceil(Difference/2500)
        )
    ),
    Ap is min(Number,100).

%(5) Special rules for taxable years 2018 through 2025
%
%In the case of a taxable year beginning after December 31, 2017, and before January 1, 2026, the term "exemption amount" means zero.
s151_d_5(Ea,Taxy) :-
    between(2018,2025,Taxy),
    Ea is 0.
