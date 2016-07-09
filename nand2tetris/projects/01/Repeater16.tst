// File name: projects/01/Repeater16.tst

load Repeater16.hdl,
output-file Repeater16.out,
compare-to Repeater16.cmp,
output-list in%B3.1.3 out%B1.16.1;


set in 0,
eval,
output;

set in 1,
eval,
output;
