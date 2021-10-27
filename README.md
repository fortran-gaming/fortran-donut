# fortran-donut

Fortran terminal spinning 3D-like donut

The earliest implementation I found in C was at this [2011 Gist](https://gist.github.com/gcr/1075131).
I fixed some bugs in this (array bounds).
I also sped it up dramatically by writing line-by-line instead of character-by-character--this also reduces screen printing artifacts.

Works in Linux/macOS and Windows Terminal, using escape codes to position cursor and clear screen.

## options

`-frames 1000`: 1000 frames before exit
`-dump file.txt`: dump each frame to a file

## Notes

other [Fortran donut](https://github.com/ShrirajHegde/ASCII-Donut-FORTRAN)
