# textSplit

SPSS Python Extension function that splits a string variable based on a delimiter

This program takes a string variable and divides it into a number of parts based on a delimiter (space by default). It then creates a number of new SPSS variables that contain each of the parts. 

This and other SPSS Python Extension functions can be found at http://www.stat-help.com/python.html

## Usage
**textSplit(textVar, delimiter, outVarName)**
*"textVar" is the name of the variable that contains the original text to be split.
* "delimiter" is the text that separates the different parts. This can be a single character or it can be multiple characters. By default this is the space character, where multiple spaces are treated as a single separation.
* "outVarName" is a string with a maximum of 4 characters that will be used to name the variables that will hold the different parts. By default this will be the first 4 characters of textVar.

## Example
**textSplit(textVar = "sentence",    
delimiter = " ",    
outVarName = "word")**
* This will that the contents of the "sentence" variable for each case and then split it into separate words, each of which will be saved in a variables named "word_1", "word_2", "word_3", up to the maximum number of words found in the sentences.
