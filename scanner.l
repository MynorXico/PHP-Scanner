a							[aA]
b							[bB]
c							[cC]
d							[dD]
e							[eE]
f							[fF]
g							[gG]
h							[hH]
i							[iI]
j							[jJ]
k							[kK]
l							[lL]
m							[mM]
n							[nN]
o							[oO]
p							[pP]
q							[qQ]
r							[rR]
s							[sS]
t							[tT]
u							[uU]
v							[vV]
w							[wW]
x							[xX]
y							[yY]
z							[zZ]

blank						[ \t]+
newline						\n

digit						[0-9]

real						{int_type}.?{digit}*









decimal						[1-9][0-9]*|0
hexadecimal					0[xX][0-9a-fA-F]+
octal						0[0-7]+
binary						0[bB][01]+






escaped						\\n|\\r|\\t|\\v|\\e|\\f|\\\\|\\$|\\\"|(\\[0-7]{1,3})|(\\x[0-9A-Fa-f]{1,2})|(\\u([0-9A-Fa-f]+))



type						{bool_type}|{int_type}|{double_type}|{string_type}


label						[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
var							${label}

mag_constant				(__)(LINE|FILE|DIR|FUNCTION|CLASS|TRAIT|METHOD|NAMESPACE)(__)

/* Rsereved Words */
rsrvd_words					__halt_compiler|break|clone|die|empty|endswitch|final|global|include_once|list|private|return|try|xor|abstract|callable|const|do|enddeclare|endwhile|finally|goto|instanceof|namespace|protected|static|unset|yield|and|case|continue|echo|endfor|eval|for|if|insteadof|new|public|switch|use|array|catch|declare|else|endforeach|exit|foreach|implements|interface|or|require|throw|var|as|class|default|elseif|endif|extends|function|include|isset|print|require_once|trait|while


/*Operators*/
ar_op						("+"|"-"|"*"|"/"|"%"|"**")
cmp_op						<|>|<=|>=|==|!=
log_op						(and|or|xor|!|&&|"||")
ass_op						"="|"+="|"-="|"*="|"/="
inc_dec_op					"++"|"--"
prnthss						"("|")"
curly						"{"|"}"
bracket						"["|"]"
semicolon					;
comma						,
/* Data types */
bool_type					{t}{r}{u}{e}|{f}{a}{l}{s}{e}
int_type					[+-]?({decimal}|{hexadecimal}|{octal}|{binary})
double_type					[-+]?[0-9]*\.?[0-9]+([eE]{int_type}.?{digit}*)?
string_type					('([^(')(\n)]|\\')*')|(\"([^(\")(\n)]|\\\")*\")

/* Identifiers */
var_id						${label}
cnst_id						{label}

/* Control Structures*/
if							{i}{f}
else						{e}{l}{s}{e}
elseif						{e}{l}{s}{e}{i}{f}
endif						{e}{n}{d}{i}{f}
while						{w}{h}{i}{l}{e}
do							{d}{o}
for							{f}{o}{r}
foreach						{f}{o}{r}{e}{a}{c}{h}
break						{b}{r}{e}{a}{k}
switch						{s}{w}{i}{t}{c}{h}
case						{c}{a}{s}{e}
include						{i}{n}{c}{l}{u}{d}{e}
continue					{c}{o}{n}{t}{i}{n}{u}{e}
return						{r}{e}{t}{u}{r}{n}
control_struct				{if}|{else}{elseif}|{endif}|{while}|{do}|{for}|{foreach}|{break}|{switch}|{case}|{continue}|{return}

/* Reserved Variables*/
superglobal					$(GLOBALS|_(SERVER|GET|POST|FILES|COOKIE|SESSION|REQUEST|ENV))
other_reserved_var			$(php_errormsg|HTTP_RAW_POST_DATA|http_response_header|argc|argv)
rsrvd_var					{superglobal}|{other_reserved_var}

/* Comments */
single_line_comment			("//"|"#")(.)*
multiline_comment			(("/*")([^(("*/"))(\n)])*("*/"))
comment						{single_line_comment}|{multiline_comment}

/* Oracle DB Access fields*/
recordset					${r}{e}{c}{o}{r}{d}{s}{e}{t}"["{string_type}"]"

function					function
%{
	int lineNumber = 0;
%}

%%
{newline}				{lineNumber++; printf("\n");}
{prnthss}				printf("<Parenthesis>");
{curly}					printf("<Curly brace>");
{bracket}				printf("<Bracket>");
{semicolon}				printf("<Semicolon>");
{comma}					printf("<Comma>");
{recordset}				printf("<Recordset>");
{ar_op}					printf("<Arithmetic operator>");
{log_op}				printf("<Logical operator>");
{cmp_op}				printf("<Comparison operator>");
{ass_op}				printf("<Assignment operator>");
{inc_dec_op}			printf("<Increment/Decrement operator>");
{bool_type}				printf("<Boolean type>");
{int_type}				printf("<Integer type>");
{double_type}			printf("<Float type>");
{string_type}			printf("<String type>");
{rsrvd_var}				printf("<Reserved variable>");
{var_id}				printf("<Variable id>");
{if}					printf("<if>");
{else}					printf("<else>");
{elseif}				printf("<elseif>");
{endif}					printf("<endif>");
{while}					printf("<while>");
{do}					printf("<do>");
{for}					printf("<for>");
{foreach}				printf("<foreach>");
{break}					printf("<break>");
{switch}				printf("<switch");
{case}					printf("<case>");
{include}				printf("<include>");
{return}				printf("<return>");
{continue}				printf("<continue>");
{single_line_comment}	printf("<single line comment>");
{multiline_comment}		printf("<multi line comment>");
{blank}					printf("<blank>");
{cnst_id}				printf("<id>");
<<EOF>>					{yyterminate();}
.						{printf("\n<<error at line%d. '%s' is not a valid token >>\n", lineNumber, yytext); yyterminate();}
%%

main(){

	yylex();
}
