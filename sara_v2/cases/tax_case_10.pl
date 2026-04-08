% Text
% Alice and Harold got married on Sep 3rd, 1992. Harold and Alice have a son, born Jan 25th, 2000. Harold died on Feb 28th, 2016. They had been living in the same house since 1993, maintained by Alice. Alice and her son continued doing so after Harold's death. Alice's gross income for the year 2017 was $236422. Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor from Sep 9th to Oct 1st 2017, and paid them $5012 each. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $68844

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Harold").
start_("married","1992-09-03").
son_("have a son").
agent_("have a son","son").
patient_("have a son","Alice").
patient_("have a son","Harold").
start_("have a son","2000-01-25").
death_("died").
agent_("died","Harold").
start_("died","2016-02-28").
residence_("continued doing so").
agent_("continued doing so","Alice").
patient_("continued doing so","house").
start_("continued doing so","2016-02-28").
residence_("had been living").
agent_("had been living","Harold").
patient_("had been living","house").
start_("had been living","1993-01-01").
end_("had been living","2016-02-28").
residence_("continued doing so").
agent_("continued doing so","son").
patient_("continued doing so","house").
start_("continued doing so","2000-01-25").
payment_("maintained").
agent_("maintained","Alice").
amount_("maintained",1).
purpose_("maintained","house").
start_("maintained",Day) :- between(1993,2093,Year), first_day_year(Year,Day).
income_("income").
agent_("income","Alice").
amount_("income",236422).
start_("income","2017-12-31").
alice_employer(Employee,Service_event_name,Payment_event_name) :-
    member(Employee,["Bob","Cameron","Dan","Emily","Fred","George"]),
    atom_concat("employed ",Employee,Service_event_name),
    atom_concat("paid ",Employee,Payment_event_name).
service_(Service_event) :- alice_employer(_,Service_event,_).
agent_(Service_event,Employee) :- alice_employer(Employee,Service_event,_).
patient_(Service_event,"Alice") :- alice_employer(_,Service_event,_).
start_(Service_event,"2017-09-09") :- alice_employer(_,Service_event,_).
end_(Service_event,"2017-10-01") :- alice_employer(_,Service_event,_).
payment_(Payment_event) :- alice_employer(_,_,Payment_event).
patient_(Payment_event,Employee) :- alice_employer(Employee,_,Payment_event).
agent_(Payment_event,"Alice") :- alice_employer(_,_,Payment_event).
start_(Payment_event,"2017-10-01") :- alice_employer(_,_,Payment_event).
amount_(Payment_event,5012) :- alice_employer(_,_,Payment_event).
purpose_(Payment_event,Service_event) :- alice_employer(_,Service_event,Payment_event).
purpose_(Service_event,"agricultural labor") :- alice_employer(_,Service_event,_).

% Test
:- tax("Alice",2017,68844).
:- halt.
