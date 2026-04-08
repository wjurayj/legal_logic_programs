% Text
% Alice and Bob have been married since Feb 3rd, 2017. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955. Bob's gross income for the year 2019 is $113580. Alice and Bob file jointly in 2019, and take the standard deduction. Alice had no income in 2019.

% Question
% How much tax does Bob have to pay in 2019? $20298

% Facts
:- [statutes/prolog/init].
marriage_("married").
agent_("married","Alice").
agent_("married","Bob").
start_("married","2017-02-03").
birth_("Alice was born").
agent_("Alice was born","Alice").
start_("Alice was born","1950-03-02").
end_("Alice was born","1950-03-02").
birth_("Bob was born").
agent_("Bob was born","Bob").
start_("Bob was born","1955-03-03").
end_("Bob was born","1955-03-03").
income_("gross income").
agent_("gross income","Bob").
amount_("gross income",113580).
start_("gross income","2019-12-31").
joint_return_("file jointly").
agent_("file jointly","Alice").
agent_("file jointly","Bob").
start_("file jointly","2019-01-01").
end_("file jointly","2019-12-31").

% Test
:- tax("Bob",2019,20298).
:- halt.
