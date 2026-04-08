% Text
% Alice has a son, Bob, who in 2015 lives with her at the house she maintains as her home. Alice was paid $73200 in 2015 as an employee of Bertha's Mussels in Baltimore, Maryland, USA. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $14296

% Facts
:- [statutes/prolog/init].
son_("has a son").
agent_("has a son","Bob").
patient_("has a son","Alice").
residence_("lives").
agent_("lives","Alice").
agent_("lives","Bob").
patient_("lives","the house").
start_("lives","2015-01-01").
end_("lives","2015-12-31").
payment_("maintains").
agent_("maintains","Alice").
amount_("maintains",1).
start_("maintains","2015-01-01").
purpose_("maintains","the house").
service_("an employee").
patient_("an employee","Bertha's Mussels").
agent_("an employee","Alice").
start_("an employee","2015-01-01").
end_("an employee","2015-12-31").
location_("an employee","Baltimore").
location_("an employee","Maryland").
location_("an employee","USA").
payment_("was paid").
agent_("was paid","Bertha's Mussels").
patient_("was paid","Alice").
start_("was paid","2015-12-31").
purpose_("was paid","an employee").
amount_("was paid",73200).

% Test
:- tax("Alice",2015,14296).
:- halt.
