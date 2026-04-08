% Text
% Alice has paid $3200 to Bob for domestic service done from Feb 1st, 2012 to Sep 2nd, 2012, in Baltimore, Maryland, USA. Bob has paid $4500 to Alice for work done from Apr 1st, 2012 to Dec 31st, 2012. Alice takes the standard deduction in 2012.

% Question
% How much tax does Alice have to pay in 2012? $192

% Facts
:- [statutes/prolog/init].
service_("domestic service").
patient_("domestic service","Alice").
agent_("domestic service","Bob").
start_("domestic service","2012-02-01").
end_("domestic service","2012-09-02").
purpose_("domestic service","domestic service").
location_("domestic service","Baltimore, Maryland, USA").
country_("Baltimore, Maryland, USA","USA").
payment_("Alice has paid $3200 to Bob").
agent_("Alice has paid $3200 to Bob","Alice").
patient_("Alice has paid $3200 to Bob","Bob").
start_("Alice has paid $3200 to Bob","2012-09-02").
purpose_("Alice has paid $3200 to Bob","domestic service").
amount_("Alice has paid $3200 to Bob",3200).
service_("work").
patient_("work","Bob").
agent_("work","Alice").
start_("work","2012-04-01").
end_("work","2012-12-31").
payment_("Bob has paid $4500 to Alice").
agent_("Bob has paid $4500 to Alice","Bob").
patient_("Bob has paid $4500 to Alice","Alice").
start_("Bob has paid $4500 to Alice","2012-09-02").
purpose_("Bob has paid $4500 to Alice","work").
amount_("Bob has paid $4500 to Alice",4500).

% Test
:- tax("Alice",2012,192).
:- halt.
