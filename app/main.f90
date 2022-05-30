program donut

use, intrinsic:: iso_fortran_env, only: stdout => output_unit

implicit none (type, external)

character, parameter :: ESC = achar(27)
character(3), parameter :: LF = ESC // "[d" !< line feed
character(4), parameter :: TL = ESC // "[2J" !< erase screen and move to top left
character, parameter :: TAB(0:11) = [".", ",", "-", "~", ":", ";", "=", "!", "*", "#", "$", "@"]
real, parameter :: PI = 4*atan(1.)

integer :: cols, rows, L, k

real :: a=0, b=0, i, j

real, allocatable :: z(:)
character, allocatable :: screen(:)

real :: sini,cosj,sinA,sinj,cosA,cosj2, mess, cosi,cosB,t,sinB
integer :: x,y,o,N,ii, u, Nloop
character(5) :: buf

character(:), allocatable :: dumpfn
logical :: dump

print *, ESC // "[?25l" !< hide cursor

Nloop = 300
dump = .false.
do ii = 1, command_argument_count()
  call get_command_argument(ii, buf)

  select case (buf)
  case ("-dump")
    call get_command_argument(ii+1, buf, status=k)
    if (k==0) then
      dumpfn = trim(buf)
      dump = .true.
    endif
  case ("-frames")
    call get_command_argument(ii+1, buf, status=k)
    if (k==0) read(buf, '(I5)') Nloop
  end select
enddo


cols = 79
rows = 22
L = rows*cols

allocate(z(0:L-1), screen(0:L-1))

if(dump) open(newunit=u, file=dumpfn, status='replace', action='write')

write(stdout,"(a)", advance="no") TL
!! move cursor to top left

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
      x = int(40 + 30*mess*(cosi*cosj2*cosB - t*sinB))
      y = int(12 + 15*mess*(cosi*cosj2*sinB + t*cosB))
      o = min(L-1, x+cols*y)  !< C program goes out of bounds
      N = int(8*((sinj*sinA - sini*cosj*cosA)*cosB - sini*cosj*sinA - sinj*cosA - cosi * cosj*sinB))
      if(rows>y .and. y>0 .and. x>0 .and. cols>x .and. mess>z(o)) then
        z(o) = mess
        screen(o) = TAB(max(N,0))
      endif
      i = i + 0.02
    enddo
    j = j + 0.07
  enddo

  write(stdout, "(a)", advance="no") LF

  do k=0, rows-2
    print '(80a)', screen(k*cols:k*cols+cols)
    if(dump) write(u, "(80a)") screen(k*cols:k*cols+cols)
  enddo

  a = a + 0.04
  b = b + 0.02
enddo

if(dump) close(u)

print *, ESC // "[?25h" !< show cursor

end program
