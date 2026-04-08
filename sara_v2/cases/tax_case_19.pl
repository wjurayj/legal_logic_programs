% Text
% Alice was paid $73200 in 2017 as an employee of the State of Maryland in Baltimore, Maryland, USA. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $16664

% Facts
:- [statutes/prolog/init].
service_("an employee").
patient_("an employee","State of Maryland").
agent_("an employee","Alice").
start_("an employee","2017-01-01").
end_("an employee","2017-12-31").
location_("an employee","Baltimore").
location_("an employee","Maryland").
location_("an employee","USA").
payment_("paid").
agent_("paid","State of Maryland").
patient_("paid","Alice").
start_("paid","2017-12-31").
purpose_("paid","an employee").
amount_("paid",73200).

% Test
:- tax("Alice",2017,16664).
:- halt.
