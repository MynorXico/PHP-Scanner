t							[tT]
r							[rR]
u							[uU]
e							[eE]
f							[fF]
a							[aA]
l							[lL]
s							[sS]
blank						[ ]+


digit						[0-9]

real						{int_type}.?{digit}*


reserved					const|define

ar_op						("+"|"-"|"*"|"/"|"%"|"**")

log_op						(and|or|xor|!|&&|"||")

bool_type					{t}{r}{u}{e}|{f}{a}{l}{s}{e}

decimal						[1-9][0-9]*|0
hexadecimal					0[xX][0-9a-fA-F]+
octal						0[0-7]+
binary						0[bB][01]+
int_type					[+-]?({decimal}|{hexadecimal}|{octal}|{binary})


double_type					[-+]?[0-9]*\.?[0-9]+([eE]{int_type}.?{digit}*)?	


escaped						\\n|\\r|\\t|\\v|\\e|\\f|\\\\|\\$|\\\"|(\\[0-7]{1,3})|(\\x[0-9A-Fa-f]{1,2})|(\\u([0-9A-Fa-f]+))
string_type					'([^(')(\n)]|\\')*'


type						{bool_type}|{int_type}|{double_type}|{string_type}


label						[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
identifier					${label}

constant_dec1				const{blank}{label}{blank}*={blank}*{type}{blank}*;
constant_dec				define{blank}*\({blank}*\"{label}\"{blank}*,{blank}*{type}{blank}*\){blank}*;
%%
{reserved}	{
					printf("Reserved word found");
				}

{ar_op}			{
					printf("Arithmetic operator found");
				}

{log_op}		{
					printf("Logical operator found");
				}
{type}			{
					printf("Data type found");
				}

{identifier}	{
					printf("Identifier found");
				}

{constant_dec}	{
					printf("constant declaration found");
				}
				
{blank}			{
					printf("blank found");	
				}
{label}			{
					printf("label found");	
				}
%%

main(){
	yylex();
}
