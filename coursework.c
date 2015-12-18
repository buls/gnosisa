#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Declare all variables
	FILE *inputFile ;
	FILE *outputFile ;
    char line[100][100];
	char inputString[100], *degreeClassification ;
	int scores[42] = {0}, i = 0, studentId;
	int len = 0, offset = 0, used = 0;
	int creditCounter, credits, i, j = 0, k = 0, studentAverage, numberOfLines, numberOfModulesTaken, studentTotalMarks ; 

int main() 
{
	
	readFile() ;
	inputFile = fopen("input.dat", "r") ;
	numberOfLines = line_count(inputFile) ;
	printf("%d\n", numberOfLines) ;
	openOutputFile() ;
	for (j = 0; j <= numberOfLines ; j++)
	{
		strcpy(inputString, line[j]) ;
		processOutputFile() ;
		printOutput() ;
		resetVariables() ;
	}
}

readFile() 
{
	if((inputFile = fopen("input.dat", "r")) == NULL) 
	{
		printf("File could not be opened! \n") ;
	}
	else 
	{
		if (inputFile != NULL)
		{
			while(fgets(line[k], 100, inputFile)) {
				line[k][strlen(line[k])] = '\0';
				k++;
			}

		}
		else 
		{
			printf("File empty") ;
		}
	}
}

int line_count(FILE *n)
{
	char c;
	int lines = 0;

	while ((c = fgetc(n)) != EOF)
	{
		if (c == '\n') ++lines;
	}

	return lines;
}

processOutputFile() 
{
    len = strlen ( inputString);
	i = 0 ;
	offset = 0 ;
	used = 0 ;
    do {
        if ( ( sscanf ( inputString + offset, "%d%n", &scores[i], &used)) == 1) 
        {
            i++ ;
            offset += used + 1;
        }
        else {
            offset++;
            scores[i] = 0;
            i++;
        }
    } while ( offset < len && i < 42);

	studentId = scores[0] ;
	numberOfModulesTaken = 0;
    for ( i = 1; i <= 20; i++) 
	{
		if (scores[i] > 0)
			numberOfModulesTaken++ ;
        studentTotalMarks += scores[i] ;
    }
	studentAverage = studentTotalMarks / numberOfModulesTaken ;

	if(studentAverage > 70)
		degreeClassification = "FirstClass" ;
	else if (studentAverage > 60 && studentAverage <= 69)
		degreeClassification = "Second Class, Division I" ;
	else if (studentAverage > 50 && studentAverage <= 59)
		degreeClassification = "Second Class, Division II" ;
	else if (studentAverage > 40 && studentAverage <= 49)
		degreeClassification = "Third Class" ;
	else if (studentAverage < 40 )
		degreeClassification = "Fail" ;
}

openOutputFile() 
{
	if((outputFile = fopen("output.dat", "w")) == NULL) 
	{
		printf("File could not be opened! \n") ;
	}
	else 
	{
		fprintf(outputFile, "Student ID\tAverage\tDegree Classification\n") ;	
	}
}

printOutput() 
{
	fprintf(outputFile, "0%d\t\t%d\t\t%s\n",studentId, studentAverage, degreeClassification ) ;
}

resetVariables()
{
	studentAverage = 0 ; 
	studentTotalMarks = 0 ;
	numberOfModulesTaken = 0 ;
	strcpy(inputString, "") ;
	studentId = 0 ;
}

//Sort the output
