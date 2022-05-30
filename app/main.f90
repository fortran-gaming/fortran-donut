program donut

use, intrinsic :: iso_fortran_env, only : wp=>real64, stdout => output_unit

implicit none (type, external)

character, parameter :: ESC = achar(27)
character, parameter :: TAB(0:11) = [".", ",", "-", "~", ":", ";", "=", "!", "*", "#", "$", "@"]
real(wp), parameter :: PI = 4*atan(1.)

integer :: cols, rows, L, k

real(wp) :: a=0, b=0, i, j

real(wp), allocatable :: z(:)
character, allocatable :: screen(:)

real(wp) :: sini,cosj,sinA,sinj,cosA,cosj2, mess, cosi,cosB,t,sinB
integer :: x,y,o,N,ii, u, Nloop
character(5) :: buf
character(:), allocatable :: dumpfn

Nloop = 100
do ii = 1, command_argument_count()
  call get_command_argument(ii, buf)

  select case (buf)
  case ("-dump")
    call get_command_argument(ii+1, buf, status=k)
    if (k==0) dumpfn = trim(buf)
  case ("-frames")
    call get_command_argument(ii+1, buf, status=k)
    if (k==0) read(buf, '(I5)') Nloop
  end select
enddo


cols = 80
rows = 22
L = rows*cols

allocate(z(0:L-1), screen(0:L-1))

if(allocated(dumpfn)) open(newunit=u, file=dumpfn, status='replace', action='write')

write(stdout,"(a)", advance="no") ESC // "[2J"  !< move cursor to top left

do ii = 1,Nloop
  z=0
  screen=""
  j=0
  sinA = sin(a)
  cosA = cos(a)
  cosB = cos(b)
  sinB = sin(b)
  do while(2*pi > j)
    i=0
    cosj = cos(j)
    cosj2 = cosj+2
    sinj = sin(j)
    do while(2*pi > i)
      sini = sin(i)
      cosi = cos(i)
      mess = 1 / (sini*cosj2*sinA+sinj*cosA+5)
      t = sini*cosj2*cosA - sinj*sinA
      x = 40 + 30*mess*(cosi*cosj2*cosB - t*sinB)
      y = 12 + 15*mess*(cosi*cosj2*sinB + t*cosB)
      o = min(L, x+cols*y)  !< C program goes out of bounds
      N = int(8*((sinj*sinA - sini*cosj*cosA)*cosB - sini*cosj*sinA - sinj*cosA - cosi * cosj*sinB))
      if(rows>y .and. y>0 .and. x>0 .and. cols>x .and. mess>z(o)) then
        z(o) = mess
        screen(o) = TAB(max(N,0))
      endif
      i = i + 0.02
    enddo
    j = j + 0.07
  enddo

  write(stdout, "(a)", advance="no") ESC // "[d" !< line feed

  do k=0, rows-2
    print *, screen(k*cols:k*cols+cols)
    if(allocated(dumpfn)) write(u, "(80a)") screen(k*cols:k*cols+cols)
  enddo

  ! print *, size(screen), k*cols,k*cols+cols

  a = a + 0.04
  b = b + 0.02
enddo

if(allocated(dumpfn)) close(u)

end program
