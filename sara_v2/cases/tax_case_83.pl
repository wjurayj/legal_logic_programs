% Text
% In 2016, Alice's gross income was $567192.
% Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor on various occasions during the year 2016:
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
% On each occasion, Alice paid each of them $550. Alice takes the standard deduction in 2016.

% Question
% How much tax does Alice have to pay in 2016? $206073

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2016-12-31").
amount_("gross income",567192).
agricultural_service(Event,Employee,Day) :-
    member(Day, ["2016-01-24","2016-02-04","2016-03-03","2016-03-19","2016-04-02","2016-05-09","2016-10-15","2016-10-25","2016-11-08","2016-11-22","2016-12-01","2016-12-03"]),
    (
        (
            Day == "2016-01-24",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2016-02-04",
            member(Employee, ["Bob","Cameron","Fred"])
        );
        (
            Day == "2016-03-03",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2016-03-19",
            member(Employee, ["Cameron","Dan","Emily","Fred","George"])
        );
        (
            Day == "2016-04-02",
            member(Employee, ["Bob","Cameron","Dan","Fred","George"])
        );
        (
            Day == "2016-05-09",
            member(Employee, ["Cameron","Dan","Emily","Fred","George"])
        );
        (
            Day == "2016-10-15",
            member(Employee, ["Bob","Cameron","Dan","Emily","George"])
        );
        (
            Day == "2016-10-25",
            member(Employee, ["Bob","Emily","Fred","George"])
        );
        (
            Day == "2016-11-08",
            member(Employee, ["Bob","Cameron","Emily","Fred","George"])
        );
        (
            Day == "2016-11-22",
            member(Employee, ["Bob","Cameron","Dan","Emily","Fred"])
        );
        (
            Day == "2016-12-01",
            member(Employee, ["Bob","Cameron","Dan","Emily","George"])
        );
        (
            Day == "2016-12-03",
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
amount_(Event,550) :- payment_for_labor(Event,_,_,_).
purpose_(Payment_event,Service_event) :-
    payment_for_labor(Payment_event,Service_event,_,_).

% Test
:- tax("Alice",2016,206073).
:- halt.
