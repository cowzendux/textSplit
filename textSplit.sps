* Python function to split a string variable based on a delimiter
* by Jamie DeCoster

* This program takes a string variable and divides it into a number of 
* parts based on a delimiter (space by default). It then creates a number
* of new SPSS variables that contain each of the parts. 

* Usage: textSplit(textVar, delimiter, outVarName)
**** "textVar" is the name of the variable that contains the original text to
* be split.
**** "delimiter" is the text that separates the different parts. This can be
* a single character or it can be multiple characters. By default this is
* the space character, where multiple spaces are treated as a single
* separation.
**** "outVarName" is a string with a maximum of 4 characters that will
* be used to name the variables that will hold the different parts. By
* default this will be the first 4 characters of textVar.

*******
* Version History
*******
* 2014-02-17 Created

begin program python.
import spss
def textSplit(textVar, delimiter = None, outVarName = None):
    if (outVarName == None):
        outVarName = textVar[:4]
    if (len(outVarName) > 4):
        outVarName = outVarName[:4]

    textVarNum = -1
    for i in range(spss.GetVariableCount()):
        if spss.GetVariableName(i)==textVar:
            textVarNum = i
    if textVarNum == -1:
        print "textVar not in data set"
        exit(-1)

# Extract parts

    outData = []
    dataCursor=spss.Cursor([textVarNum], accessType='r')
    for i in range(spss.GetCaseCount()):
        inData=dataCursor.fetchone()
        splitList = inData[0].split(delimiter)
        outData.append(splitList)
    dataCursor.close()

# Determine number of parts and max size of parts

    maxParts = 0
    maxLength = 0
    for t in outData:
        if (len(t) > maxParts):
            maxParts = len(t)
        for i in t:
            if (len(i) > maxLength):
                maxLength = len(i)
    newNames = []
    newTypes = []
    for t in range(maxParts):
        newNames.append(outVarName + "_" + str(t+1))
        newTypes.append(maxLength)

# Create new variables to hold parts

    oldVar = []
    for t in range(spss.GetVariableCount()):
        oldVar.append(spss.GetVariableName(t))

    for t in newNames:
        for i in oldVar:
            if (t == i):
                print "Variable name {0} already in data set".format(t)
                print "Stopping execution"
                exit(-1)

    dataCursor=spss.Cursor([textVarNum], accessType='w')
    dataCursor.SetVarNameAndType(newNames, newTypes)
    dataCursor.CommitDictionary()

# Adding new values to data set

    for t in range(spss.GetCaseCount()):
        row = dataCursor.fetchone()
        for i in range(len(outData[t])):
            dataCursor.SetValueChar(newNames[i], outData[t][i])
        dataCursor.CommitCase()
    dataCursor.close()
end program python.
