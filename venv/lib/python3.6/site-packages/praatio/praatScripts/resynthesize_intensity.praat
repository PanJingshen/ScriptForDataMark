form Resynthesize pitch
    sentence Input_audio_file_name
    sentence Input_intensity_file_name
    sentence Output_audio_file_name
    real MinPitch 75
    real MaxPitch 350
endform

sound = Read from file: input_audio_file_name$

pitchtier = Read from file: input_pitch_file_name$

selectObject: sound
manipulation = To Manipulation: 0.01, minPitch, maxPitch

selectObject: pitchtier
plus manipulation
Replace pitch tier

selectObject: "Sound damon_given"
plusObject: "IntensityTier damon_contrastive"
Multiply: "yes"
Save as WAV file: output_audio_file_name$
Remove

selectObject: manipulation
Remove
selectObject: pitchtier
Remove
selectObject: sound
Remove

exitScript()



Draw: 0, 0, "yes"
Play
selectObject: "Sound damon_contrastive"
Play
To Intensity: 100, 0, "yes"
selectObject: "Sound damon_given"
plusObject: "Intensity damon_contrastive"
selectObject: "Intensity damon_contrastive"
Down to IntensityTier
View & Edit

