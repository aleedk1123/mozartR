'''From csv to Midi'''

from mido import Message, MidiFile, MidiTrack
import csv

with open('/home/andrew/Downloads/mozartR/markov_song.csv') as midiFile:
    reader = csv.reader(midiFile, delimiter=',')
    mid = MidiFile()
    track = MidiTrack()
    mid.tracks.append(track)

    next(reader)                     
    for line in reader:
        note = int(line[0])
        time = int(line[1])
        velocity = int(line[2])

        track.append(Message('note_on',
                                 note=note,
                                 velocity=velocity,
                                 time=0))
        track.append(Message('note_off',
                             note=note,
                             velocity=0,
                             time=time))

mid.save('/home/andrew/Downloads/mozartR/markov_song.mid')
