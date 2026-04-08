%§1. Tax imposed
s1(Taxp,Taxy,Taxinc,Tax) :-
    s1_a(Taxp,Taxy,Taxinc,Tax);
    s1_b(Taxp,Taxy,Taxinc,Tax);
    s1_c(Taxp,Taxy,Taxinc,Tax);
    s1_d(Taxp,_,Taxy,Taxinc,Tax).

%(a) Married individuals filing joint returns and surviving spouses
s1_a(Taxp,Taxy,Taxinc,Tax) :-
    (
        s1_a_1(Taxp,_,_,Taxy,Taxinc,Tax);
        s1_a_2(Taxp,Taxy,Taxinc,Tax)
    ).

%There is hereby imposed on the taxable income of-

%(1) every married individual (as defined in section 7703) who makes a single return jointly with his spouse, and
s1_a_1(Taxp,S4,Spouse,Taxy,Taxinc,Tax) :-
    s7703(Taxp,Spouse,_,Taxy),
    joint_return_(S4),
    agent_(S4,Taxp),
    agent_(S4,Spouse),
    first_day_year(Taxy,First_day),
    last_day_year(Taxy,Last_day),
    start_(S4,First_day),
    end_(S4,Last_day),
    \+ ( % nonresident aliens can't file jointly
        nonresident_alien_(someone_is_nra),
        (
            agent_(someone_is_nra,Taxp);
            agent_(someone_is_nra,Spouse)
        ),
        (
            (
                \+ start_(someone_is_nra,_),
                Start_time=First_day
            );
            start_(someone_is_nra,Start_time)
        ),
        (
            (
                \+ end_(someone_is_nra,_),
                End_time=Last_day
            );
            end_(someone_is_nra,End_time)
        ),
        is_before(Start_time,Last_day),
        is_before(First_day,End_time)
    ),
    s63(Taxp,Taxy,Taxinc),
    s1_a_tax(Taxinc,Tax).

%(2) every surviving spouse (as defined in section 2(a)),
s1_a_2(Taxp,Taxy,Taxinc,Tax) :-
    s2_a(Taxp,_,Taxy),
    s63(Taxp,Taxy,Taxinc),
    s1_a_tax(Taxinc,Tax).

%Such tax shall be:
s1_a_tax(Taxinc,Tax) :-
    s1_a_i(Taxinc,Tax);
    s1_a_ii(Taxinc,Tax);
    s1_a_iii(Taxinc,Tax);
    s1_a_iv(Taxinc,Tax);
    s1_a_v(Taxinc,Tax).

%(i) 15% of taxable income if the taxable income is not over $36,900;
s1_a_i(Taxinc,Tax) :-
    Taxinc =< 36900,
    Tax is round(Taxinc*0.15).
%(ii) $5,535, plus 28% of the excess over $36,900 if the taxable income is over $36,900 but not over $89,150;
s1_a_ii(Taxinc,Tax) :-
    Taxinc =< 89150,
    36900 < Taxinc,
    Tax is round(5535+(Taxinc-36900)*0.28).
%(iii) $20,165, plus 31% of the excess over $89,150 if the taxable income is over $89,150 but not over $140,000;
s1_a_iii(Taxinc,Tax) :-
    Taxinc =< 140000,
    89150 < Taxinc,
    Tax is round(20165+(Taxinc-89150)*0.31).
%(iv) $35,928.50, plus 36% of the excess over $140,000 if the taxable income is over $140,000 but not over $250,000;
s1_a_iv(Taxinc,Tax) :-
    Taxinc =< 250000,
    140000 < Taxinc,
    Tax is round(35928.50+(Taxinc-140000)*0.36).
%(v) $75,528.50, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_a_v(Taxinc,Tax) :-
    250000 < Taxinc,
    Tax is round(75528.50+(Taxinc-250000)*0.396).

%(b) Heads of households

%There is hereby imposed on the taxable income of every head of a household (as defined in section 2(b)) a tax determined in accordance with the following:
s1_b(Taxp,Taxy,Taxinc,Tax) :-
    s2_b(Taxp,_,Taxy),
    s63(Taxp,Taxy,Taxinc),
    (
        s1_b_i(Taxinc,Tax);
        s1_b_ii(Taxinc,Tax);
        s1_b_iii(Taxinc,Tax);
        s1_b_iv(Taxinc,Tax);
        s1_b_v(Taxinc,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $29,600;
s1_b_i(Taxinc,Tax) :-
    Taxinc =< 29600,
    Tax is round(Taxinc*0.15).
%(ii) $4,440, plus 28% of the excess over $29,600 if the taxable income is over $29,600 but not over $76,400;
s1_b_ii(Taxinc,Tax) :-
    Taxinc =< 76400,
    29600 < Taxinc,
    Tax is round(4440+(Taxinc-29600)*0.28).
%(iii) $17,544, plus 31% of the excess over $76,400 if the taxable income is over $76,400 but not over $127,500;
s1_b_iii(Taxinc,Tax) :-
    Taxinc =< 127500,
    76400 < Taxinc,
    Tax is round(17544+(Taxinc-76400)*0.31).
%(iv) $33,385, plus 36% of the excess over $127,500 if the taxable income is over $127,500 but not over $250,000;
s1_b_iv(Taxinc,Tax) :-
    Taxinc =< 250000,
    127500 < Taxinc,
    Tax is round(33385+(Taxinc-127500)*0.36).
%(v) $77,485, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_b_v(Taxinc,Tax) :-
    250000 < Taxinc,
    Tax is round(77485+(Taxinc-250000)*0.396).

%(c) Unmarried individuals (other than surviving spouses and heads of households)

%There is hereby imposed on the taxable income of every individual (other than a surviving spouse as defined in section 2(a) or the head of a household as defined in section 2(b)) who is not a married individual (as defined in section 7703) a tax determined in accordance with the following:
s1_c(Taxp,Taxy,Taxinc,Tax) :-
    \+ s2_a(Taxp,_,Taxy),
    \+ s2_b(Taxp,_,Taxy),
    \+ s7703(Taxp,_,_,Taxy),
    s63(Taxp,Taxy,Taxinc),
    (
        s1_c_i(Taxinc,Tax);
        s1_c_ii(Taxinc,Tax);
        s1_c_iii(Taxinc,Tax);
        s1_c_iv(Taxinc,Tax);
        s1_c_v(Taxinc,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $22,100;
s1_c_i(Taxinc,Tax) :-
    Taxinc =< 22100,
    Tax is round(Taxinc*0.15).
%(ii) $3,315, plus 28% of the excess over $22,100 if the taxable income is over $22,100 but not over $53,500;
s1_c_ii(Taxinc,Tax) :-
    Taxinc =< 53500,
    22100 < Taxinc,
    Tax is round(3315+(Taxinc-22100)*0.28).
%(iii) $12,107, plus 31% of the excess over $53,500 if the taxable income is over $53,500 but not over $115,000;
s1_c_iii(Taxinc,Tax) :-
    Taxinc =< 115000,
    53500 < Taxinc,
    Tax is round(12107+(Taxinc-53500)*0.31).
%(iv) $31,172, plus 36% of the excess over $115,000 if the taxable income is over $115,000 but not over $250,000;
s1_c_iv(Taxinc,Tax) :-
    Taxinc =< 250000,
    115000 < Taxinc,
    Tax is round(31172+(Taxinc-115000)*0.36).
%(v) $79,772, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_c_v(Taxinc,Tax) :-
    250000 < Taxinc,
    Tax is round(79772+(Taxinc-250000)*0.396).

%(d) Married individuals filing separate returns

%There is hereby imposed on the taxable income of every married individual (as defined in section 7703) who does not make a single return jointly with his spouse, a tax determined in accordance with the following:
s1_d(Taxp,Spouse,Taxy,Taxinc,Tax) :-
    s7703(Taxp,Spouse,_,Taxy),
    \+ (
        joint_return_(Joint_return),
        agent_(Joint_return,Taxp),
        agent_(Joint_return,Spouse),
        first_day_year(Taxy,First_day),
        last_day_year(Taxy,Last_day),
        start_(Joint_return,First_day),
        end_(Joint_return,Last_day)
    ),
    s63(Taxp,Taxy,Taxinc),
    (
        s1_d_i(Taxinc,Tax);
        s1_d_ii(Taxinc,Tax);
        s1_d_iii(Taxinc,Tax);
        s1_d_iv(Taxinc,Tax);
        s1_d_v(Taxinc,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $18,450;
s1_d_i(Taxinc,Tax) :-
    Taxinc =< 18450,
    Tax is round(Taxinc*0.15).
%(ii) $2,767.50, plus 28% of the excess over $18,450 if the taxable income is over $18,450 but not over $44,575;
s1_d_ii(Taxinc,Tax) :-
    Taxinc =< 44575,
    18450 < Taxinc,
    Tax is round(2767.50+(Taxinc-18450)*0.28).
%(iii) $10,082.50, plus 31% of the excess over $44,575 if the taxable income is over $44,575 but not over $70,000;
s1_d_iii(Taxinc,Tax) :-
    Taxinc =< 70000,
    44575 < Taxinc,
    Tax is round(10082.50+(Taxinc-44575)*0.31).
%(iv) $17,964.25, plus 36% of the excess over $70,000 if the taxable income is over $70,000 but not over $125,000;
s1_d_iv(Taxinc,Tax) :-
    Taxinc =< 125000,
    70000 < Taxinc,
    Tax is round(17964.25+(Taxinc-70000)*0.36).
%(v) $37,764.25, plus 39.6% of the excess over $125,000 if the taxable income is over $125,000
s1_d_v(Taxinc,Tax) :-
    125000 < Taxinc,
    Tax is round(37764.25+(Taxinc-125000)*0.396).
