//
//  HelloWorld.m
//  
//
//  Created by Bill Gestrich on 12/23/23.
//

#import "HelloWorld.h"

@implementation HelloWorld

@end


void myMethod() {

    int x = 0;
    if(x == 0); // <-- Note the accidental semicolon here, creating an empty body
    {
        printf("Incrementing x\n");
        x++;
    }

    while (true) {}
}
