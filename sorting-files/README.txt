Requires Python 3

cd `THIS-DIRECTORY`
run `python3 ./generate-test-cases.py`

A file called "unsorted.txt" will be created. It will be 
about 400 MB large. For a smaller or bigger file, change the 
`1e6` value of line 8 in "generate-test-cases.py" file.

Next run `python3 ./sort-file.py` and a file will be created called
"sorted.txt"

I hard coded the file names because I was lazy, so to test your own stuff,
move it in and rename, or change the paths in the Python code. You are 
smart and can figure that out!