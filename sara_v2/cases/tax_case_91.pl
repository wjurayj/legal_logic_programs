% Text
% Alice got married on June 2nd, 2006. Alice files a joint return with her spouse for 2017. Alice's and her spouse's gross income for the year 2017 is $684642. They take the standard deduction in 2017.
% Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor on various occasions during the year 2017:
% - Jan 24: Bob, Cameron, Dan, Emily and Fred
% - Feb 4: Bob, Cameron and Fred
% - Mar 3: Bob, Cameron, Dan, Emily and Fred
% - Mar 19: Cameron, Dan, Emily, Fred and George
% - Apr 2: Bob, Cameron, Dan, Fred and George
% - May 9: Cameron, Dan, Emily, Fred and George
% - Oct 15: Bob, Cameron, Dan, Emily and George
% - Oct 25: Bob, Emily, Fred and George
% - Nov 8: Bob, Cameron, Emily, Fred and George
% - Nov 22: Bob, Cameron, Dan, Emily and Fred
% - Dec 1: Bob, Cameron, Dan, Emily and George
% - Dec 3: Bob, Cameron, Dan, Emily and George
% Alice has paid each $632 on each occasion.

% Question
% How much tax does Alice have to pay in 2017? $247432

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2006-06-02").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2017-12-31").
amount_("gross income",684642).
agricultural_service(Event,Employee,Day) :-
    member(Day, ["2017-01-24","2017-02-04","2017-03-03","2017-03-19","2017-04-02","2017-05-09","2017-10-15","2017-10-25","2017-11-08","2017-11-22","2017-12-01","2017-12-03"]),
    (
        (
            Day == "2017-01-24",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2017-02-04",
            member(Employee, ["Bob","Cameron","Fred"])
        );
        (
            Day == "2017-03-03",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2017-03-19",
            member(Employee, ["Cameron","Dan","Emily","Fred","George"])
        );
        (
            Day == "2017-04-02",
            member(Employee, ["Bob","Cameron","Dan","Fred","George"])
        );
        (
            Day == "2017-05-09",
            member(Employee, ["Cameron","Dan","Emily","Fred","George"])
        );
        (
            Day == "2017-10-15",
            member(Employee, ["Bob","Cameron","Dan","Emily","George"])
        );
        (
            Day == "2017-10-25",
            member(Employee, ["Bob","Emily","Fred","George"])
        );
        (
            Day == "2017-11-08",
            member(Employee, ["Bob","Cameron","Emily","Fred","George"])
        );
        (
            Day == "2017-11-22",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2017-12-01",
            member(Employee, ["Bob","Cameron","Dan","Emily","George"])
        );
        (
            Day == "2017-12-03",
            member(Employee, ["Bob","Cameron","Dan","Emily","George"])
        )
    ),
    atom_concat("employed ",Day,Tmp),
    atom_concat(Tmp,"_",Tmp2),
    atom_concat(Tmp2,Employee,Event).
purpose_(Event,"agricultural labor") :-
    agricultural_service(Event,_,_).
service_(Event) :- agricultural_service(Event,_,_).
agent_(Event,Employee) :- agricultural_service(Event,Employee,_).
patient_(Event,"Alice") :- agricultural_service(Event,_,_).
start_(Event,Day) :- agricultural_service(Event,_,Day).
end_(Event,Day) :- agricultural_service(Event,_,Day).
payment_for_labor(Payment_event,Service_event,Employee,Day) :-
    agricultural_service(Service_event,Employee,Day),
    atom_concat(Service_event," paid ",Payment_event).
payment_(Event) :- payment_for_labor(Event,_,_,_).
agent_(Event,"Alice") :- payment_for_labor(Event,_,_,_).
patient_(Event,Employee) :- payment_for_labor(Event,_,Employee,_).
start_(Event,Day) :- payment_for_labor(Event,_,_,Day).
amount_(Event,632) :- payment_for_labor(Event,_,_,_).
purpose_(Payment_event,Service_event) :-
    payment_for_labor(Payment_event,Service_event,_,_).

% Test
:- tax("Alice",2017,247432).
:- halt.
