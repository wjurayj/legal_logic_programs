% Text
% In 2017, Alice's gross income was $33200. Alice and Bob have been married since Feb 3rd, 2017. Alice has been blind since October 4, 2013. Alice and Bob file jointly in 2017. Bob has no gross income in 2017. Alice and Bob take the standard deduction. Alice and Bob has the same principal place of abode from 2017 to 2020.

% Question
% How much tax does Alice have to pay in 2017? $3390

% Facts
:- [statutes/prolog/init].
income_("Alice's gross income").
agent_("Alice's gross income","Alice").
start_("Alice's gross income","2017-12-31").
amount_("Alice's gross income",33200).
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
blindness_("blind").
agent_("blind","Alice").
start_("blind","2013-10-04").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2017-01-01").
end_("file jointly","2017-12-31").
residence_("principal place of abode").
agent_("principal place of abode","Alice").
agent_("principal place of abode","Bob").
patient_("principal place of abode","principal place of abode").
start_("principal place of abode","2017-01-01").
end_("principal place of abode","2020-12-31").

% Test
:- tax("Alice",2017,3390).
:- halt.
