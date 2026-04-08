% Text
% Alice and Bob have been married since Feb 3rd, 2017. Alice files a joint return with her spouse for 2020. Alice's gross income for the year 2020 is $103272. Bob earned $10 in 2020. Alice and Bob take the standard deduction.

% Question
% How much tax does Bob have to pay in 2020? $17402

% Facts
:- [statutes/prolog/init].
joint_return_("files a joint return").
agent_("files a joint return","Alice").
agent_("files a joint return","Bob").
start_("files a joint return","2020-01-01").
end_("files a joint return","2020-12-31").
income_("gross income").
agent_("gross income","Alice").
start_("gross income","2020-12-31").
amount_("gross income",103272).
payment_("earned").
patient_("earned","Bob").
start_("earned","2020-12-31").
amount_("earned",10).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").

% Test
:- tax("Bob",2020,17402).
:- halt.
