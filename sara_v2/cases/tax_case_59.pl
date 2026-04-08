% Text
% Bob is Charlie and Dorothy's son, born April 15th, 2015. Alice married Charlie on August 8th, 2018. Alice was paid $73200 in 2020 as an employee of the United States Government in Arlington, Virginia, USA. Alice files a separate return and takes the standard deduction. Since 2019, Alice, Bob and Charlie live in a house maintained by Alice and Charlie.

% Question
% How much tax does Alice have to pay in 2020? $15236

% Facts
:- [statutes/prolog/init].
son_("son").
agent_("son","Bob").
patient_("son","Charlie").
patient_("son","Dorothy").
start_("son","2015-04-15").
marriage_("married").
agent_("married","Alice").
agent_("married","Charlie").
start_("married","2018-08-08").
service_("an employee").
patient_("an employee","United States Government").
agent_("an employee","Alice").
start_("an employee","2020-01-01").
end_("an employee","2020-12-31").
location_("an employee","Arlington").
location_("an employee","Virginia").
location_("an employee","USA").
payment_("paid").
agent_("paid","United States Government").
patient_("paid","Alice").
start_("paid","2020-12-31").
purpose_("paid","an employee").
amount_("paid",73200).
residence_("live").
agent_("live","Alice").
agent_("live","Bob").
agent_("live","Charlie").
patient_("live","a house").
start_("live","2019-01-01").
payment_("maintained").
agent_("maintained","Alice").
agent_("maintained","Charlie").
amount_("maintained",1).
start_("maintained","2019-12-31").
payment_("maintained").
agent_("maintained","Alice").
agent_("maintained","Charlie").
amount_("maintained",1).
start_("maintained","2020-12-31").

% Test
:- tax("Alice",2020,15236).
:- halt.
