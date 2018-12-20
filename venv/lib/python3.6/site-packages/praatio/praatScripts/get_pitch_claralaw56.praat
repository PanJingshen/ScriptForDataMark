
form Extract Pitch
comment Directory of sound files
text sound_directory /Users/tmahrt/Dropbox/workspace/praatIO/examples/files/blah/
sentence Sound_file_extension .wav
comment Directory of finished files
text end_fn /Users/tmahrt/Dropbox/workspace/praatIO/examples/files/blah/f0.txt
real sample_step 0.01
real min_pitch 75
real max_pitch 450
real silence_threshold 0.03
endform

strings = Create Strings as file list... list 'sound_directory$'*'sound_file_extension$'
numberOfFiles = Get number of strings

for ifile to numberOfFiles
select strings
filename$ = Get string... ifile

# A sound file is opened from the listing:
sound = Read from file: sound_directory$ + filename$
select sound

# Get timing information
startTime = Get start time
endTime = Get end time

# Get pitch track and measure the average pitch over the file
pitch = To Pitch (ac): sample_step, min_pitch, 15, "no", silence_threshold, 0.45, 0.01, 0.35, 0.14, max_pitch
f0 = Get mean: startTime, endTime, "Hertz"

appendFileLine: end_fn$, filename$, tab$, f0

select sound
Remove

select pitch
Remove

endeditor
endfor

select strings
Remove


