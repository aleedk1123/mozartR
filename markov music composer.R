library(tuneR)
library(markovchain)
library(dplyr)
library(plyr)
library(stringr)
library(stats)

mozart.data = readMidi('minuetk1.mid_1581194736714.mid')
mozart.notes = getMidiNotes(mozart.data)

note.chain = function(X){
  noteTpm = createSequenceMatrix(X$note, toRowProbs = TRUE)
  noteMc = as(noteTpm, "markovchain")
  markov.notes = markovchainSequence(nrow(X), markovchain = noteMc)
  
  return(markov.notes)
}

length.chain = function(X){
  lengthTpm = createSequenceMatrix(X$length, toRowProbs = TRUE)
  lengthMc = as(lengthTpm, "markovchain")
  markov.length = markovchainSequence(nrow(X), markovchain = lengthMc)
  
  return(markov.length)
}

velocity.chain = function(X){
  velocityTpm = createSequenceMatrix(X$velocity, toRowProbs = TRUE)
  velocityMc = as(velocityTpm, "markovchain")
  markov.velocity = markovchainSequence(nrow(X), markovchain = velocityMc)
  
  return(markov.velocity)
}

markov.notes = as.integer(note.chain(mozart.notes))
markov.length = as.integer(length.chain(mozart.notes))
markov.velocity = as.integer(velocity.chain(mozart.notes))

markov.song = data.frame(note = markov.notes,
                         length = markov.length,
                         velocity = markov.velocity)

write.csv(markov.song, "markov_song.csv", row.names = FALSE)