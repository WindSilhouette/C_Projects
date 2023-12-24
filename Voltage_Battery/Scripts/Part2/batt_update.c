// THIS FILE IS INCLUDED TO BE USED WITH HYBRID_MAIN FOR TESTING
// Copy your batt_update.c solution to part1 into this file to test C alongside assembly code.
// The compiler will mix functions from batt_update_asm.s and batt_update.c if you
// comment out the version not to be used by the compiler when running 'make hybrid_main'.
// only ONE version of each function should be defined between the asm and c file!

#include "batt.h"


// int set_batt_from_ports(batt_t *batt){
//   int voltage = BATT_VOLTAGE_PORT;
//     if (voltage < 0) {
//         return 1;
//     }
//     batt->mlvolts = voltage >> 1;
//     if ((batt->mlvolts) < 3000){
//         batt->percent = 0;
//     }else{
//         batt->percent = ((batt->mlvolts) - 3000) >> 3;
//     }
//     if(batt->percent > 100){
//         batt->percent = 100;
//     }
//     if ((BATT_STATUS_PORT & 0x10) != 0) {
//         batt->mode = 1;
//     } else {
//         batt->mode = 2;
//     }
//     return 0;
// } 

// int set_display_from_batt(batt_t batt, int *display){
//     *display = 0;

//     int digits[11] = {
//         0b0111111, //0
//         0b0000110, //1
//         0b1011011, //2
//         0b1001111, //3
//         0b1100110, //4
//         0b1101101, //5
//         0b1111101, //6
//         0b0000111, //7
//         0b1111111, //8
//         0b1101111, //9
//         0b0000000  //empty
//     };

//     int ldigit, mdigit, rdigit;
//     int volt = batt.mlvolts + 5;
//     int percent = batt.percent;

//     //caclulate digits
//     ldigit = percent / 100; 
//     mdigit = (percent/10) % 10;
//     rdigit = percent % 10;

//     //taking out 0's into 0b0000000
//     if (ldigit == 0 && mdigit == 0) {
//         ldigit = mdigit = 10;
//     } else if (ldigit == 0) {
//         ldigit = 10;
//     }

//     if (batt.mode == 1) {  // percent

//         //add each bits to its corresponding area in the display bits
//         *display |= (digits[ldigit] << 17);
//         *display |= (digits[mdigit] << 10);        
//         *display |= (digits[rdigit] << 3);
//         *display |= (0b001);
//         *display |= 0b00000 << 24;
//     } else {  ///volts
//         volt /= 10;
//         //caclulate digits
//         ldigit = volt / 100;
//         mdigit = (volt / 10) % 10;
//         rdigit = volt % 10;

//         //add each bits to its corresponding area in the display bits
//         *display |= (digits[ldigit] << 17);
//         *display |= (digits[mdigit] << 10);
//         *display |= (digits[rdigit] << 3);
//         *display |= (0b110);
//         *display |= 0b00000 << 24;
//     }

//     int level_bar[] = {
//         0b00000,  // 0-5%
//         0b00001,  // 5-29%
//         0b00011,  // 30-49%
//         0b00111,  // 50-69%
//         0b01111,  // 70-89%
//         0b11111,  // 90-100%
//     };

//     // Set level bars
//     if (percent >= 0 && percent <= 5) {
//         *display |= level_bar[0] << 24;
//     } else if (percent > 5 && percent <= 29) {
//         *display |= level_bar[1] << 24;
//     } else if (percent > 29 && percent <= 49) {
//         *display |= level_bar[2] << 24;
//     } else if (percent > 49 && percent <= 69) {
//         *display |= level_bar[3] << 24;
//     } else if (percent > 69 && percent <= 89) {
//         *display |= level_bar[4] << 24;
//     } else if (percent > 89 && percent <= 100) {
//         *display |= level_bar[5] << 24;
//     }
//     return 0;
// } 

// int batt_update(){
//     batt_t batt = {.mlvolts = -100, .percent = -1, .mode = -1};
//     // Set the batt values from the ports, and return 1 if there's an error
//     if (set_batt_from_ports(&batt) != 0) {
//         return 1;
//     }

//     // Set the display value from the batt struct, and return 0 if there's no error
//     set_display_from_batt(batt, &BATT_DISPLAY_PORT);
//     return 0;
// }
