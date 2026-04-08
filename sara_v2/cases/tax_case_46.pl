% Text
% Alice has paid $3200 to Bob for agricultural labor done from Feb 1st, 2020 to Sep 2nd, 2020. Alice paid Bob with eggs, grapes and hay. Alice has been married since 1999. Alice files a joint return with her spouse for 2020. Alice's and her spouse's gross income for the year 2020 is $103272. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2020? $17399

% Facts
:- [statutes/prolog/init].
service_("agricultural labor").
patient_("agricultural labor","Alice").
agent_("agricultural labor","Bob").
start_("agricultural labor","2020-02-01").
end_("agricultural labor","2020-09-02").
purpose_("agricultural labor","agricultural labor").
payment_("Alice has paid $3200 to Bob").
agent_("Alice has paid $3200 to Bob","Alice").
patient_("Alice has paid $3200 to Bob","Bob").
start_("Alice has paid $3200 to Bob","2020-09-02").
purpose_("Alice has paid $3200 to Bob","agricultural labor").
amount_("Alice has paid $3200 to Bob",3200).
means_("Alice has paid $3200 to Bob","eggs, grapes and hay").
marriage_("married").
agent_("married","Alice").
agent_("married","her spouse").
start_("married","1999-12-31").
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","her spouse").
start_("files a joint return","2020-01-01").
end_("files a joint return","2020-12-31").
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",103272).
start_("gross income","2020-12-31").

% Test
:- tax("Alice",2020,17399).
:- halt.
