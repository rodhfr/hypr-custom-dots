#!/bin/bash

# Function to extract subtitles from movie files
subs() {
  local movie idx lang subs=
  local -a dests=()

  # Loop through all the movie files passed as arguments
  for movie in "$@"
  do
    # Use ffprobe to detect subtitle streams and their languages
    ffprobe -loglevel error -select_streams s -show_entries stream=index:stream_tags=language -of csv=p=0 "$movie" |
    {
      # Read each line of the output from ffprobe
      while IFS=, read idx lang
      do
        # Build the subtitle file name and map it
        subs+=" ${lang}_$idx"
        dests+=(-map "0:$idx" "${movie%.*}_${lang}_$idx.srt")
      done

      # If subtitle streams were found, extract them
      if test -n "$subs"
      then
        echo "Extracting subtitles from $movie:$subs"
        ffmpeg -nostdin -y -hide_banner -loglevel quiet -i "$movie" "${dests[@]}"
      else
        echo "No subtitles in $movie"
      fi
    }
  done
}

find /media/tv -name '*.mkv' | while read -r file; do
    subs "$file"
done

# Call the function with all passed arguments (movie files)
#subs "$@"

