-module(calculator).
-export([start/0]).
-author("Nathan Kelderman").
  
% This module is a simple calculator that will keep a running total and supports
% the use of +,-,*,/, and exponentiation as well as clearing working total.

%
% The calculate function runs recursively and keeps a tally of the subtotal until
%n the user enters q to quit.
%
calculate(I, Sub)	->
  	% makes sure they entered at least 1 thing otherwise asks for another input
		if
			length(I) < 1 -> calculate(lists:delete(10,io:get_line("Invalid value, please enter a valid a command: ")), Sub);
			% splits the input up and binds the command (1st value) to Command and binds the number
	    % (2nd value or empty list in the case of just one value entered) to Number and converts from a string to a number
			length(I) > 0 -> X = lists:split(1,I), Command = element(1,X),
												Number = element(1,string:to_integer(element(2,X))),
			% selects the appropriate case for the command and either does a calculation or prints something and
			% asks for another input or clears or quits
			case Command of
				"q" -> io:format("Total = ~w~n", [Sub]), io:format("Thank you for using the Erlang Calculator!~n");
				"a"	-> io:format("~w + ~w = ~w~n", [Sub,Number,Sub+Number]),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub + Number);
				"s"	-> io:format("~w - ~w = ~w~n", [Sub,Number,Sub-Number]),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub - Number);
				"m"	-> io:format("~w * ~w = ~w~n", [Sub,Number,Sub*Number]),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub * Number);
				"d"	-> case Number of
									0 -> io:format("Cannot divide by zero!~n"),
												calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub);
									_ -> io:format("~w / ~w = ~w~n", [Sub,Number,Sub/Number]),
												calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub / Number)
								end;
				"e"	-> io:format("~w ^ ~w = ~w~n", [Sub,Number,math:pow(Sub,Number)]),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), math:pow(Sub,Number));
				"t"	-> io:format("Subtotal = ~w~n", [Sub]),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), Sub);
				"c"	-> io:format("Subtotal cleared to 0~n"),
								calculate(lists:delete(10,io:get_line("Enter a command: ")), 0);
				_		-> calculate(lists:delete(10,io:get_line("Invalid a command, please enter a valid a command: ")), Sub)
			end
		end.

%
% Starts the calculator program with with a welcome and then some instructions and finally
% making the first call to the calculator function with the an input from user and a subtotal of 0
%
start()	-> io:format("Welcome to the Erlang Calculator!~nYou will start with the value of 0"),
						io:format(" and keep entering commands until you would like to quit.~n"),
						io:format("A command is a letter for the operation, immediately followed by the"),
						io:format(" number you wish to perform that operation on.~n"),
						io:format("The list of operations are as follows: ~n'a' for addition~n's' for subtraction~n"),
						io:format("'m' for multiplication~n'd' for division~n'e' to raise running total to the exponent you wish~n"),
						io:format("'t' to display the working total~n'c' to clear working total back to 0~n"),
						io:format("'q' to quit and display final total~n"),
						calculate(lists:delete(10,io:get_line("Enter a command: ")), 0).
