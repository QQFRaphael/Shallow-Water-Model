timer_get_(tsec,usec)
int *tsec,*usec;
{
    int isec;
     struct timeval {
         long   tv_sec;
         long   tv_usec;} tp;

     gettimeofday(&tp,0);
     isec = tp.tv_sec;
     *tsec = isec;
     isec = tp.tv_usec;
     *usec = isec;
     return;
}
