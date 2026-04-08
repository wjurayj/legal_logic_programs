% Text
% Alice's gross income in 2015 is $395276. Alice is allowed itemized deductions of $4571, $1973 and $15271.

% Question
% How much tax does Alice have to pay in 2015? $130388

% Facts
:- [statutes/prolog/init].
income_("gross income").
agent_("gross income","Alice").
amount_("gross income",395276).
start_("gross income","2015-01-01").
end_("gross income","2015-12-31").
deduction_("$4571").
agent_("$4571","Alice").
amount_("$4571",4571).
start_("$4571","2015-12-31").
deduction_("$1973").
agent_("$1973","Alice").
amount_("$1973",1973).
start_("$1973","2015-12-31").
deduction_("$15271").
agent_("$15271","Alice").
amount_("$15271",15271).
start_("$15271","2015-12-31").

% Test
:- tax("Alice",2015,130388).
:- halt.
