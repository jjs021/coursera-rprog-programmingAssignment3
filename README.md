Programming Assignment 3 by jjs02
=================================
Coursera R Programming Class 013 2015-04...05
---------------------------------------------
Using some of the Hospital Compare data from the U.S. Dept of Health and Human Services at http://hospitalcompare.hhs.gov/
we're asked to develop three functions that deal with 30-day mortality outcomes for heart attack, heart failure, and pneumonia
at all the 4000+ listed hospitals. The functions are:

1. `best(state, outcome)` E.G. `best("TX", "heart attack")` gives you the hospital name with the lowest 30-day mortality rate
for the outcome in that state. Ties are broken by alphabetical order.
2. `rankhospital(state, outcome, rank)` E.G. `rankhospital("MD", "heart failure", 5)` will give you the [5th] ranked hospital
by name for the outcome in that state. Again ties are broken by alphabetical order. "worst" gives the lowest ranked hospital in
the state for which data for the 30-day mortality rate of that condition exists.
3. `rankall(outcome", rank)` E.G. `rankall("pneumonia", "worst")` will give you the hospitals by name and state for each state
at the rank requested for the specific outcome. If not enough hospitals rank in a given state, that state's hospital name will
be "NA".

