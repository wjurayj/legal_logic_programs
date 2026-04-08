% Text
% Alice got married on May 30th, 2014. Alice files a joint return with her spouse for 2017 and they take the standard deduction. Alice's gross income for the year 2017 is $103272 while her spouse had no income. Alice has paid $3200 to her brother Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Baltimore, Maryland, USA.

% Question
% How much tax does Alice have to pay in 2017? $21635

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","2014-05-30").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2017-01-01").
end_("files a joint return","2017-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",103272).
start_("gross income","2017-12-31").
service_("work").
patient_("work","Alice").
agent_("work","Bob").
start_("work","2017-02-01").
end_("work","2017-09-02").
location_("work","Baltimore").
location_("work","Maryland").
location_("work","USA").
payment_("paid").
agent_("paid","Alice").
patient_("paid","Bob").
start_("paid","2017-09-02").
purpose_("paid","work").
amount_("paid",3200).
brother_("brother").
agent_("brother","Bob").
patient_("brother","Alice").

% Test
:- tax("Alice",2017,21635).
:- halt.
