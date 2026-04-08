% Text
% In 2012, Alice was paid $54268 in remuneration. In addition, Alice has paid $11571 to Bob for work done from Feb 1st, 2012 to Sep 2nd, 2012, in Caracas, Venezuela. Alice is an American employer, and Bob is an American citizen. Bob takes the standard deduction in 2012.

% Question
% How much tax does Bob have to pay in 2012? $986

% Facts
:- [statutes/prolog/init].
payment_("Alice was paid").
patient_("Alice was paid","Alice").
start_("Alice was paid","2012-12-31").
amount_("Alice was paid",54268).
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2012-02-01").
end_("work","2012-09-02").
location_("work","Caracas, Venezuela").
country_("Caracas, Venezuela","Venezuela").
payment_("Alice has paid").
agent_("Alice has paid","Alice").
patient_("Alice has paid","Bob").
start_("Alice has paid","2012-09-02").
purpose_("Alice has paid","work").
amount_("Alice has paid",11571).
american_employer_("an American employer").
agent_("an American employer","Alice").
citizenship_("an American citizen").
agent_("an American citizen","Bob").
patient_("an American citizen","USA").

% Test
:- tax("Bob",2012,986).
:- halt.
